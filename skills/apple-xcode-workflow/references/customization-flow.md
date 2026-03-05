# Xcode Workflow Customization Contract

## Purpose

Tune the documented policy defaults for MCP-first execution, fallback behavior, mutation safety, and docs routing.

## Knobs

| Knob | Default | Status | Effect |
| --- | --- | --- | --- |
| `intentBucketsProfile` | `default` | `policy-only` | Describes the documented operation taxonomy. |
| `mcpRetryCount` | `1` | `policy-only` | Describes the documented retry count for transient MCP failures. |
| `requireExplicitMutationOptInForFilesystemFallback` | `true` | `policy-only` | Describes the documented direct-edit opt-in requirement. |
| `docsRoutingOrder` | `dash-mcp,dash-local,official-web` | `policy-only` | Describes the documented docs source order. |
| `advisoryCooldownDays` | `21` | `policy-only` | Describes the documented advisory cooldown window. |
| `fallbackCommandMappingProfile` | `official-default` | `policy-only` | Describes the documented official CLI mapping profile. |

## Runtime Behavior

- `scripts/customization_config.py` reads, writes, resets, and reports customization state.
- `scripts/advisory_cooldown.py` and `scripts/detect_xcode_managed_scope.sh` enforce their own runtime flags and inputs, not the stored customization metadata.
- No knob in this file is auto-loaded by the runtime scripts today.

## Update Flow

1. Inspect current settings with `uv run python scripts/customization_config.py effective`.
2. Update `SKILL.md` and the affected workflow references to reflect the approved policy change.
3. Persist the metadata change with `uv run python scripts/customization_config.py apply --input <yaml-file>`.
4. Re-run `uv run python scripts/customization_config.py effective` and confirm the stored values match the docs.

## Validation

1. Verify the docs still describe a single MCP-first workflow.
2. Verify retry count, mutation gate, and docs source order are stated consistently across the skill and references.
3. Verify the docs do not claim that stored customization metadata changes runtime behavior automatically.
