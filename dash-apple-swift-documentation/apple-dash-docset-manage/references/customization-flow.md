# Customization Flow

## Purpose

Tune Dash search fallback behavior, ranking defaults, and FTS handling for local environments.

## Customization Knobs

- `fallbackOrder`
- `defaultMaxResults`
- `defaultSearchSnippets`
- `ftsEnablePolicy`
- `troubleshootingPreference`

## Interactive Question Sequence

1. Ask preferred fallback order among MCP, HTTP, and URL/service paths.
2. Ask default result limits and snippet behavior.
3. Ask FTS enable policy (never, enable-when-disabled, enable-and-retry).
4. Ask preferred troubleshooting path when APIs are unavailable.
5. Confirm final merged settings before apply.

## File Mapping

- `SKILL.md`: fallback and workflow policy.
- `scripts/dash_catalog_match.py`: ranking behavior.
- `scripts/dash_api_probe.py`: access-path probing.
- `references/dash_*.md`: API/URL guidance.
- `references/automation-prompts.md`: automation defaults.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Guardrails

- Avoid install/generation side effects in search workflows.
- Keep fallback order explicit.
- Do not invent docset identifiers.

## Validation Checklist

- Run `uv run python scripts/dash_api_probe.py`.
- Run `uv run python scripts/dash_catalog_match.py --query "swift"`.
- Run `uv run python scripts/customization_config.py effective`.

## Example Customization Requests

- "Use HTTP before MCP in this environment."
- "Raise default result limit to 50."
- "Enable FTS automatically when disabled."
