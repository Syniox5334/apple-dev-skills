# Dash Customization Contract

## Purpose

Tune the documented policy defaults for Dash stages without overstating runtime enforcement.

## Knobs

| Knob | Default | Status | Effect |
| --- | --- | --- | --- |
| `fallbackOrder` | `mcp,http,url-service` | `policy-only` | Describes the documented fallback order for the `search` stage. |
| `defaultMaxResults` | `20` | `policy-only` | Sets the documented default search result limit. |
| `defaultSearchSnippets` | `true` | `policy-only` | Sets the documented default snippet behavior. |
| `installSourcePriority` | `built-in,user-contributed,cheatsheet` | `policy-only` | Sets the documented install source order. |
| `requireExplicitApprovalForYes` | `true` | `policy-only` | Sets the documented approval posture for side-effectful installs. |
| `generationPolicy` | `automate-stable` | `policy-only` | Sets the documented preference for the `generate` stage to automate before using manual guidance. |
| `troubleshootingPreference` | `api-first` | `policy-only` | Sets the documented troubleshooting emphasis when Dash access fails. |

## Runtime Behavior

- `scripts/customization_config.py` reads, writes, resets, and reports customization state.
- The Dash scripts do not auto-load these settings today.
- Apply a knob to runtime behavior only when a script is explicitly changed to honor it.

## Update Flow

1. Inspect current settings with `uv run python scripts/customization_config.py effective`.
2. Update `SKILL.md`, `references/automation-prompts.md`, and the affected workflow references.
3. Persist the metadata change with `uv run python scripts/customization_config.py apply --input <yaml-file>`.
4. Re-run `uv run python scripts/customization_config.py effective` and confirm the stored values match the docs.

## Validation

1. Run `uv run python scripts/dash_api_probe.py`.
2. Run `uv run python scripts/dash_catalog_match.py --query "swift"`.
3. Verify the docs still present `search`, `install`, and `generate` as separate stages in forward order.
4. Verify no stage claims runtime behavior that scripts do not enforce today.
