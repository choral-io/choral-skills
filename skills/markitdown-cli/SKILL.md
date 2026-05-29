---
name: markitdown-cli
description: Use when converting local document files such as PDFs, Office documents, HTML, text, or other MarkItDown-supported inputs into Markdown.
---

# MarkItDown CLI

Use the installed `markitdown` command to convert readable local files into Markdown. Preserve source files and prefer the CLI over custom extraction code unless the user rejects it or a conversion fails for a clear reason.

Use for single-file or batch conversion, conversion checks or retries, stdin, and extensionless inputs. Do not use for summarizing without conversion, editing existing Markdown, dependency management, or standalone OCR/cloud extraction.

## Workflow

1. Locate inputs; inspect names, sizes, and planned output paths.
2. Verify `command -v markitdown`. If missing, report it, do not install without approval, and point to `https://github.com/microsoft/markitdown#installation`.
3. Choose output paths. Do not overwrite existing `.md` files unless replacement is explicit.
4. Run one `markitdown` invocation per input so failures are attributable. Quote paths and avoid unsafe glob assumptions.
5. Use `--extension` or `--mime-type` for stdin, extensionless files, or misleading filenames.
6. Spot-check Markdown for empty output, truncation, encoding problems, or missing structure.
7. Report converted files, skipped existing outputs, failures with exact CLI errors, and any follow-up dependency issue.

## Commands

| Need                  | Pattern                                                      |
| --------------------- | ------------------------------------------------------------ |
| Save converted output | `markitdown input.docx -o output.md`                         |
| Stream to stdout      | `markitdown input.pdf`                                       |
| Extensionless input   | `markitdown --extension pdf input -o output.md`              |
| Stdin type hint       | `markitdown --mime-type text/html -o output.md < input.html` |
| Text encoding         | `markitdown input.txt --charset utf-8 -o output.md`          |

Use `--use-docintel` or `--use-content-understanding` only for MarkItDown Markdown conversion when the user explicitly asks for that route and the required endpoint is configured.
