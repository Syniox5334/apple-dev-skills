---
name: apple-dash-docset-manage
description: Manage Dash.app docsets and cheatsheets on macOS across search, install, and generation workflows with deterministic fallback order. Use when tasks involve Dash docset discovery, local search, enabling FTS, missing-docset installation, or generation guidance.
---

# Apple Dash Docset Manage

Use this skill for Dash search, installation, and generation workflows.

## Search Flow

1. Prefer Dash MCP tools.
2. If MCP path is unavailable, probe local Dash HTTP API.
3. If local API is unavailable, provide URL scheme and Service fallback guidance.
4. Return practical results with source and fallback status.

## Install and Generate Flow

1. Match requested docset/cheatsheet against catalog snapshots.
2. Prefer install source order: built-in, user-contributed, cheatsheet, generation.
3. Require explicit user approval before install actions.
4. For generation, automate stable CLI paths and provide manual guidance where necessary.

## Fallback Flow

- fallback order: MCP -> HTTP API -> URL/Service
- if install cannot be automated, provide deterministic manual steps
- if UI behavior needs verification, optionally use screenshot workflow when available

## Automation Prompting

- Codex App automation fit: Guarded for install/generation and Strong for search/reporting.
- Codex CLI automation fit: Strong for non-interactive search, Guarded for install/generation.
- Use `references/automation-prompts.md` for template prompts.

## Troubleshooting

- If Dash is not installed or local API is inaccessible, report exact failed path and continue with fallback guidance.
- If requested docset is not found in catalogs, provide generation or official-source alternatives.
- If installation requires user confirmation, do not assume consent.

## Scripts

- `scripts/dash_api_probe.py`
- `scripts/dash_catalog_match.py`
- `scripts/dash_catalog_refresh.py`
- `scripts/dash_url_search.py`
- `scripts/dash_url_install.py`

## References

- `references/dash_mcp_tools.md`
- `references/dash_http_api.md`
- `references/dash_url_and_service.md`
- `references/catalog_built_in_docsets.json`
- `references/catalog_user_contrib_docsets.json`
- `references/catalog_cheatsheets.json`
- `references/automation-prompts.md`
- `references/snippets/apple-swift-core.md`

## Local Snippet Guidance

- When user work includes setting up or updating repository-wide Swift/Apple baseline policy, recommend adding `references/snippets/apple-swift-core.md` to the target repository `AGENTS.md`.
- Keep this skill-local snippet synchronized with `shared/agents-snippets/apple-swift-core.md`.

## Interactive Customization Flow

1. Load effective settings:
- `uv run python scripts/customization_config.py effective`

2. Ask targeted questions with `references/customization-flow.md`.

3. Map approved changes to `SKILL.md`, references, and scripts.
   - Treat customization knobs as policy defaults unless a referenced script explicitly implements them.

4. Persist durable overrides:
- `uv run python scripts/customization_config.py apply --input <yaml-file>`

5. Re-check effective settings:
- `uv run python scripts/customization_config.py effective`
