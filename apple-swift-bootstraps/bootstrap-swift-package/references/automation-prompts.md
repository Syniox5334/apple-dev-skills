# Automation Prompts

## Automation Fit

- Codex App automation: Guarded. Best for one-off or event-driven scaffolding, not high-frequency recurring schedules.
- Codex CLI automation: Strong. Suitable for deterministic non-interactive package bootstrap runs.

## Prerequisites

- `swift` and `git` available on `PATH`.
- Write access to `<DESTINATION_DIR>`.
- `assets/AGENTS.md` and `scripts/bootstrap_swift_package.sh` present in this skill.
- Explicit values prepared for required placeholders.

## Codex App Automation Prompt Template

```text
Use $bootstrap-swift-package.

This automation is guarded for app scheduling. Run only when a package scaffold is explicitly requested.

Create a Swift package with:
- Name: <PACKAGE_NAME>
- Type: <PACKAGE_TYPE>
- Destination directory: <DESTINATION_DIR>
- Platform preset: <PLATFORM_PRESET>
- Version profile: <VERSION_PROFILE>
- Skip validation: <SKIP_VALIDATION>

Execution requirements:
1) Run `scripts/bootstrap_swift_package.sh` with the mapped flags.
2) Refuse to overwrite a non-empty target directory.
3) Stop immediately if `swift`, `git`, or `assets/AGENTS.md` is missing.
4) If `<SKIP_VALIDATION>` is `false`, require `swift build` and `swift test` to pass.
5) Do not modify files outside `<DESTINATION_DIR>/<PACKAGE_NAME>`.

Output requirements:
- Return a short status with created path, package type, platform preset, version profile, and validation result.
- Include exact command used.
- If blocked, return the blocker and the next required action.
```

## Codex CLI Automation Prompt Template

```text
Use $bootstrap-swift-package for a deterministic CLI automation run.

Task:
Bootstrap one Swift package using `scripts/bootstrap_swift_package.sh` with:
- `--name <PACKAGE_NAME>`
- `--type <PACKAGE_TYPE>`
- `--destination <DESTINATION_DIR>`
- `--platform <PLATFORM_PRESET>`
- `--version-profile <VERSION_PROFILE>`
- include `--skip-validation` only when `<SKIP_VALIDATION>` is `true`

Constraints:
- Make no unrelated edits.
- Do not overwrite non-empty directories.
- Stop on missing prerequisites instead of guessing.
- Keep changes scoped to `<DESTINATION_DIR>/<PACKAGE_NAME>`.

Verification:
- Confirm `Package.swift`, `AGENTS.md`, `Tests/`, and `.git` exist.
- If validation is enabled, verify `swift build` and `swift test` success.

Return format:
- `status: success|blocked|failed`
- `path: <resolved path>`
- `checks: <passed checks>`
- `notes: <brief follow-up>`
```

## Customization Knobs

- `<PACKAGE_NAME>`: Swift package name.
- `<PACKAGE_TYPE>`: `library`, `executable`, or `tool`.
- `<DESTINATION_DIR>`: Absolute or workspace-relative parent directory.
- `<PLATFORM_PRESET>`: `mac`, `mobile`, or `multiplatform` (aliases accepted by script).
- `<VERSION_PROFILE>`: `latest-major`, `current-minus-one`, or `current-minus-two` (aliases accepted).
- `<SKIP_VALIDATION>`: `true` or `false`.

## Guardrails and Stop Conditions

- Stop if prerequisites are missing.
- Stop if target exists and is non-empty.
- Stop if script invocation fails at any step.
- Never continue after failed validation unless `<SKIP_VALIDATION>` is explicitly `true`.

## Expected Output Shape

- One concise execution summary.
- Command invocation shown once.
- Validation status clearly stated.
- Blockers or failures reported with exact next action.
