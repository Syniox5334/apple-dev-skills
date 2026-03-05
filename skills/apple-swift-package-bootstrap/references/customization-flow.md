# Bootstrap Customization Contract

## Purpose

Adjust the documented bootstrap defaults while keeping runtime behavior grounded in the actual script.

## Knobs

| Knob | Default | Status | Effect |
| --- | --- | --- | --- |
| `defaultPackageType` | `library` | `policy-only` | Sets the documented default scaffold type. |
| `defaultPlatformPreset` | `multiplatform` | `policy-only` | Sets the documented default platform preset. |
| `defaultVersionProfile` | `current-minus-one` | `policy-only` | Sets the documented default version profile. |
| `initializeGit` | `true` | `policy-only` | Describes whether docs present git initialization as default behavior. |
| `copyAgentsMd` | `true` | `policy-only` | Describes whether docs present `AGENTS.md` copy-in as default behavior. |
| `namingPattern` | `pascal-case` | `policy-only` | Describes the preferred package naming convention in docs and examples. |

## Runtime Behavior

- `scripts/customization_config.py` reads, writes, resets, and reports customization state.
- `scripts/bootstrap_swift_package.sh` does not auto-load any knob in this file today.
- If a future change must enforce a knob automatically, update both the script and this document.

## Update Flow

1. Inspect current settings with `uv run python scripts/customization_config.py effective`.
2. Update `SKILL.md`, `references/package-types.md`, and `references/automation-prompts.md` to reflect the approved policy change.
3. Persist the metadata change with `uv run python scripts/customization_config.py apply --input <yaml-file>`.
4. Re-run `uv run python scripts/customization_config.py effective` and confirm the stored values match the docs.
5. Use `uv run python scripts/customization_config.py reset` only when the user explicitly wants to clear customization state.

## Validation

1. Run the bootstrap workflow once with defaults.
2. Run the bootstrap workflow once with explicit overrides.
3. Verify `Package.swift`, `.git`, `AGENTS.md`, and `Tests/` exist.
4. Verify the docs do not claim that customization state changes runtime behavior automatically.
