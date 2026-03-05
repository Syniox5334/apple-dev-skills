# Router Customization Contract

## Purpose

Tune routing and install-fallback policy defaults for this skill.

## Knobs

| Knob | Default | Status | Effect |
| --- | --- | --- | --- |
| `defaultRoutingPreference` | `specific-skill-first` | `policy-only` | Controls how the docs describe ambiguity resolution when multiple routes could fit. |
| `preferPackSuggestions` | `true` | `policy-only` | Controls whether the docs mention repo-wide install as a secondary option. |
| `installCommandStyle` | `explicit` | `policy-only` | Controls whether install commands are documented in terse or explanatory form. |
| `includeAllOption` | `true` | `policy-only` | Controls whether `--all` appears as an optional convenience command. |

## Runtime Behavior

- `scripts/customization_config.py` reads, writes, resets, and reports customization state.
- No knob in this file is runtime-enforced by routing code today.

## Update Flow

1. Inspect current settings with `uv run python scripts/customization_config.py effective`.
2. Update `SKILL.md` and the router reference files to reflect the approved policy change.
3. Persist the metadata change with `uv run python scripts/customization_config.py apply --input <yaml-file>`.
4. Re-run `uv run python scripts/customization_config.py effective` and confirm the stored values match the docs.

## Validation

1. Verify every route target exists in `skills/`.
2. Verify install commands use `gaelic-ghost/apple-dev-skills`.
3. Verify the docs do not present repo-wide install as the primary path.
