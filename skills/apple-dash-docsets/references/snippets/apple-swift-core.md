# Apple Swift Core AGENTS Snippet

Use this snippet in repository `AGENTS.md` files when you want cross-project Swift and Apple baseline standards.

## Swift Package Baseline

- Use Swift Package Manager as the source of truth for package structure and dependencies.
- Prefer `swift package` subcommands for structural package edits before manual manifest edits.
- Keep package graph updates cohesive (`Package.swift`, `Package.resolved`, targets/tests where applicable).

## Build and Test Baseline

- Run `swift build` and `swift test` as default validation checks after package-level changes.
- Keep command invocations deterministic and reproducible in automation/CI.

## Concurrency and Language Baseline

- Keep code compliant with Swift 6 language mode.
- Keep strict concurrency checking enabled.
- Prefer modern structured concurrency (`async`/`await`, task groups) over legacy async patterns.

## Testing Baseline

- Prefer Swift Testing (`import Testing`) as the default test framework.
- Use XCTest only when an external dependency or platform constraint requires it.

## CLI Automation Baseline

- Prefer non-interactive, explicit CLI commands in automation runs.
- Use `swift package` for package-focused operations and `xcodebuild` for Apple platform integration validation.
