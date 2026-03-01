# Customization Flow

## Purpose

Tune AGENTS sync defaults and scanning/reporting policy for workspace maintenance automation.

## Customization Knobs

- `defaultDiscoveryRoot`
- `directoryExclusions`
- `defaultMode`
- `canonicalAgentsPathMode`
- `reportFormat`

## Interactive Question Sequence

1. Ask for default discovery root.
2. Ask whether exclusion patterns should be expanded or narrowed.
3. Ask whether default mode should be `check` or `apply`.
4. Ask whether canonical file should stay asset-default or external.
5. Ask preferred report format and confirm final merged settings.

## File Mapping

- `SKILL.md`: policy defaults.
- `scripts/sync_agents_md.sh`: scan/sync behavior.
- `references/automation-usage.md`: recurring mode recommendations.
- `references/automation-prompts.md`: automation templates.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Guardrails

- Keep check/apply semantics explicit.
- Avoid silent partial writes in apply mode.
- Keep summary reporting machine-readable when requested.

## Validation Checklist

- Run `scripts/sync_agents_md.sh --help`.
- Run one check-mode and one apply-mode test against a sample repo.
- Run `uv run python scripts/customization_config.py effective`.

## Example Customization Requests

- "Use ~/Code as the default scan root."
- "Require explicit apply mode and default to check."
- "Emit JSON summary for automation logs."
