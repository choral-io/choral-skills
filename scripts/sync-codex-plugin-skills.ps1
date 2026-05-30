param(
    [switch]$Check,
    [string]$Plugin
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ConfigFile = Join-Path $RepoRoot "plugins/plugin-sync.txt"

function Read-SyncConfig {
    Get-Content $ConfigFile | ForEach-Object {
        $line = ($_ -split "#", 2)[0].Trim()
        if (-not $line) {
            return
        }
        $parts = $line -split ":", 2
        if ($parts.Count -ne 2) {
            throw "Invalid sync config line: $_"
        }
        $pluginName = $parts[0].Trim()
        $skills = $parts[1].Trim() -split "\s+" | Where-Object { $_ }
        if (-not $pluginName -or $skills.Count -eq 0) {
            throw "Invalid sync config line: $_"
        }
        [pscustomobject]@{
            Plugin = $pluginName
            Skills = $skills
        }
    }
}

function Copy-PluginSkills {
    param(
        [string]$PluginName,
        [string[]]$Skills
    )

    $targetDir = Join-Path $RepoRoot "plugins/$PluginName/skills"
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
    Get-ChildItem -Force $targetDir | Remove-Item -Recurse -Force

    foreach ($skill in $Skills) {
        $sourceDir = Join-Path $RepoRoot "skills/$skill"
        if (-not (Test-Path -LiteralPath $sourceDir -PathType Container)) {
            throw "Missing source Skill: skills/$skill"
        }
        Copy-Item -LiteralPath $sourceDir -Destination (Join-Path $targetDir $skill) -Recurse
    }
}

function Get-RelativeFileMap {
    param([string]$Root)

    $map = @{}
    if (-not (Test-Path -LiteralPath $Root -PathType Container)) {
        return $map
    }
    Get-ChildItem -LiteralPath $Root -Recurse -File -Force | ForEach-Object {
        $relative = [System.IO.Path]::GetRelativePath($Root, $_.FullName)
        $map[$relative] = (Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash
    }
    return $map
}

function Test-SkillCopy {
    param(
        [string]$PluginName,
        [string[]]$Skills
    )

    $targetDir = Join-Path $RepoRoot "plugins/$PluginName/skills"
    $ok = $true

    if (-not (Test-Path -LiteralPath $targetDir -PathType Container)) {
        Write-Error "Plugin $PluginName is missing skills directory: plugins/$PluginName/skills"
        return $false
    }

    foreach ($skill in $Skills) {
        $sourceDir = Join-Path $RepoRoot "skills/$skill"
        $targetSkillDir = Join-Path $targetDir $skill
        if (-not (Test-Path -LiteralPath $sourceDir -PathType Container)) {
            Write-Error "Missing source Skill: skills/$skill"
            $ok = $false
            continue
        }
        if (-not (Test-Path -LiteralPath $targetSkillDir -PathType Container)) {
            Write-Error "Plugin $PluginName is missing copied Skill: $skill"
            $ok = $false
            continue
        }

        $sourceMap = Get-RelativeFileMap $sourceDir
        $targetMap = Get-RelativeFileMap $targetSkillDir
        $allKeys = @($sourceMap.Keys + $targetMap.Keys | Sort-Object -Unique)
        foreach ($key in $allKeys) {
            if (-not $sourceMap.ContainsKey($key) -or -not $targetMap.ContainsKey($key) -or $sourceMap[$key] -ne $targetMap[$key]) {
                Write-Error "Plugin $PluginName Skill copy is out of sync: $skill"
                $ok = $false
                break
            }
        }
    }

    $declared = @{}
    foreach ($skill in $Skills) {
        $declared[$skill] = $true
    }
    Get-ChildItem -LiteralPath $targetDir -Directory -Force | ForEach-Object {
        if (-not $declared.ContainsKey($_.Name)) {
            Write-Error "Plugin $PluginName has undeclared copied Skill: $($_.Name)"
            $script:CheckOk = $false
        }
    }

    return $ok
}

$entries = @(Read-SyncConfig | Where-Object { -not $Plugin -or $_.Plugin -eq $Plugin })
if ($entries.Count -eq 0) {
    throw "No plugin matched: $(if ($Plugin) { $Plugin } else { '<all>' })"
}

$CheckOk = $true
foreach ($entry in $entries) {
    if ($Check) {
        if (-not (Test-SkillCopy -PluginName $entry.Plugin -Skills $entry.Skills)) {
            $CheckOk = $false
        }
    } else {
        Copy-PluginSkills -PluginName $entry.Plugin -Skills $entry.Skills
        Write-Output "Synchronized plugin Skills: $($entry.Plugin)"
    }
}

if ($Check -and -not $CheckOk) {
    exit 1
}
