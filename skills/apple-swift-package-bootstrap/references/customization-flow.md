# Customization Flow

## Purpose

Adjust bootstrap defaults and generation behavior for team-specific Swift package conventions.
Treat generated `AGENTS.md` as the full scaffold policy file that incorporates the shared `apple-swift-core` baseline.

## Customization Knobs

- `defaultPackageType`
- `defaultPlatformPreset`
- `defaultVersionProfile`
- `initializeGit`
- `copyAgentsMd`
- `namingPattern`

## Interactive Question Sequence

1. Ask for desired default package type and platform preset.
2. Ask which version profile should be default.
3. Ask whether `git init` should remain default.
4. Ask whether `AGENTS.md` should always be copied.
5. Ask for naming pattern constraints and confirm final merged settings.

## File Mapping

- `SKILL.md`: operator-facing defaults.
- `scripts/bootstrap_swift_package.sh`: runtime behavior.
- `references/package-types.md`: type/profile guidance.
- `references/automation-prompts.md`: automation defaults.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Runtime Behavior Note

These knobs are policy defaults stored as customization metadata. The bootstrap script does not auto-load all settings; wire runtime behavior intentionally when a knob must be enforced automatically.

## Guardrails

- Keep bootstrap deterministic.
- Keep docs aligned with script behavior.
- Keep `assets/AGENTS.md` aligned with `shared/agents-snippets/apple-swift-core.md` baseline expectations.
- Avoid introducing destructive defaults.

## Validation Checklist

- Run bootstrap once with defaults and once with explicit overrides.
- Verify generated structure and platform profile expectations.
- Run `uv run python scripts/customization_config.py effective`.

## Example Customization Requests

- "Default to executable packages for this team."
- "Disable automatic git initialization unless explicitly requested."
- "Make AGENTS.md copy-in opt-in instead of default."
