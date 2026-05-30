#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/sync-codex-plugin-skills.sh [--check] [plugin-name]

Synchronize materialized plugin Skill copies from root skills/ according to
plugins/plugin-sync.txt. With --check, report drift without writing files.
EOF
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
config_file="$repo_root/plugins/plugin-sync.txt"
mode="sync"
plugin_filter=""

while (($#)); do
  case "$1" in
    --check)
      mode="check"
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      if [[ -n "$plugin_filter" ]]; then
        echo "Only one plugin name may be provided." >&2
        usage >&2
        exit 2
      fi
      plugin_filter="$1"
      ;;
  esac
  shift
done

trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

copy_plugin_skills() {
  local plugin="$1"
  shift
  local target_dir="$repo_root/plugins/$plugin/skills"

  mkdir -p "$target_dir"
  find "$target_dir" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

  local skill
  for skill in "$@"; do
    local source_dir="$repo_root/skills/$skill"
    if [[ ! -d "$source_dir" ]]; then
      echo "Missing source Skill: skills/$skill" >&2
      exit 1
    fi
    cp -R "$source_dir" "$target_dir/$skill"
  done
}

check_plugin_skills() {
  local plugin="$1"
  shift
  local target_dir="$repo_root/plugins/$plugin/skills"
  local status=0

  if [[ ! -d "$target_dir" ]]; then
    echo "Plugin $plugin is missing skills directory: plugins/$plugin/skills" >&2
    return 1
  fi

  local expected=()
  local skill
  for skill in "$@"; do
    expected+=("$skill")
    local source_dir="$repo_root/skills/$skill"
    local target_skill_dir="$target_dir/$skill"
    if [[ ! -d "$source_dir" ]]; then
      echo "Missing source Skill: skills/$skill" >&2
      status=1
      continue
    fi
    if [[ ! -d "$target_skill_dir" ]]; then
      echo "Plugin $plugin is missing copied Skill: $skill" >&2
      status=1
      continue
    fi
    if ! diff -qr "$source_dir" "$target_skill_dir" >/dev/null; then
      echo "Plugin $plugin Skill copy is out of sync: $skill" >&2
      status=1
    fi
  done

  local entry name found
  while IFS= read -r entry; do
    name="$(basename "$entry")"
    found=0
    for skill in "${expected[@]}"; do
      if [[ "$skill" == "$name" ]]; then
        found=1
        break
      fi
    done
    if [[ "$found" -eq 0 ]]; then
      echo "Plugin $plugin has undeclared copied Skill: $name" >&2
      status=1
    fi
  done < <(find "$target_dir" -mindepth 1 -maxdepth 1 -type d -print)

  return "$status"
}

matched=0
status=0

while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
  line="${raw_line%%#*}"
  if [[ -z "${line//[[:space:]]/}" ]]; then
    continue
  fi
  if [[ "$line" != *:* ]]; then
    echo "Invalid sync config line: $raw_line" >&2
    exit 1
  fi

  plugin="$(trim "${line%%:*}")"
  skills_text="$(trim "${line#*:}")"
  if [[ -z "$plugin" || -z "$skills_text" ]]; then
    echo "Invalid sync config line: $raw_line" >&2
    exit 1
  fi
  if [[ -n "$plugin_filter" && "$plugin" != "$plugin_filter" ]]; then
    continue
  fi

  read -r -a skills <<<"$skills_text"
  matched=1

  if [[ "$mode" == "check" ]]; then
    if ! check_plugin_skills "$plugin" "${skills[@]}"; then
      status=1
    fi
  else
    copy_plugin_skills "$plugin" "${skills[@]}"
    echo "Synchronized plugin Skills: $plugin"
  fi
done <"$config_file"

if [[ "$matched" -eq 0 ]]; then
  echo "No plugin matched: ${plugin_filter:-<all>}" >&2
  exit 1
fi

exit "$status"
