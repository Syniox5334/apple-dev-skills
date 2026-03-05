# Customization Flow

## Purpose

Tune Dash search and install/generation policy defaults for local environments.

## Customization Knobs

- `fallbackOrder`
- `defaultMaxResults`
- `defaultSearchSnippets`
- `installSourcePriority`
- `requireExplicitApprovalForYes`
- `generationPolicy`
- `troubleshootingPreference`

## Interactive Question Sequence

1. Ask preferred fallback order among MCP, HTTP, and URL/service paths.
2. Ask default result limits and snippet behavior.
3. Ask install source priority and install approval expectations.
4. Ask generation policy and preferred troubleshooting path when APIs are unavailable.
5. Confirm final merged settings before apply.

## File Mapping

- `SKILL.md`: fallback and workflow policy.
- `scripts/dash_catalog_match.py`: ranking behavior.
- `scripts/dash_api_probe.py`: access-path probing.
- `references/dash_mcp_tools.md`: MCP tool guidance.
- `references/dash_http_api.md`: local HTTP API guidance.
- `references/dash_url_and_service.md`: URL/service fallback guidance.
- `references/automation-prompts.md`: automation defaults.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Runtime Behavior Note

These knobs are policy defaults stored as customization metadata. Runtime scripts do not auto-load all settings; apply requested behavior changes only where explicit script wiring exists.

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
- "Require explicit approval before install commands that use --yes."
