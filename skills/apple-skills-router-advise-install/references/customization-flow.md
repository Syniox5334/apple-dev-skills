# Router Customization Flow

## Purpose

Tune routing and installation recommendation policy defaults for this skill.

## Knobs

- `defaultRoutingPreference`: default route when intent overlaps multiple skills
- `preferPackSuggestions`: include pack suggestions by default
- `installCommandStyle`: command verbosity profile
- `includeAllOption`: include `--all` suggestion by default

## Runtime Behavior Note

These knobs are policy defaults stored as customization metadata. This skill currently applies them through SKILL/ref guidance rather than dynamic runtime branching in scripts.

## Validation

1. Verify routing suggestions point only to existing skill names.
2. Verify install commands use `gaelic-ghost/apple-dev-skills`.
3. Run `uv run python scripts/customization_config.py effective`.
