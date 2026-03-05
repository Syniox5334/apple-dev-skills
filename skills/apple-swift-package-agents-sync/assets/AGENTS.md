# AGENTS.md

## Repository Expectations

- Use Swift Package Manager (SPM) as the source of truth for package structure and dependencies.
- Prefer `swift package` CLI commands for structural changes whenever the command exists.
- Use `swift package add-dependency` to add dependencies instead of hand-editing package graphs.
- Use `swift package add-target` to add library, executable, or test targets.
- For package configuration not covered by CLI commands, update `Package.swift` intentionally and keep edits minimal.
- Keep package graph updates together in the same change (`Package.swift`, `Package.resolved`, and target/test layout when applicable).
- Validate package changes with:
  - `swift build`
  - `swift test`

## Swift Coding Preferences

- Use idiomatic Swift and Cocoa-style naming conventions.
- Prefer explicit, consistent, and unambiguous names.
- Prefer compact and concise code; use shorthand syntax when readability remains high.
- Prefer trailing-closure syntax when it improves clarity.
- Avoid deep nesting; refactor into focused helpers and types.

## Types and Architecture

- Prefer value types (`struct`, `enum`) for domain modeling.
- Prefer concrete types internally; use protocols at module seams and integration boundaries.
- Mark classes as `final` by default.
- Prefer synthesized conformances (`Codable`, `Equatable`, `Hashable`, etc.) where possible.
- Prefer synthesized/memberwise initializers; avoid unnecessary custom initializers.
- Use enums as namespaces to group related concerns.
- Keep code modular and cohesive; group highly related concerns together.
- Avoid spaghetti code and tight coupling.
- Prefer pure Swift solutions where practical.

## Concurrency and Language Mode

- Keep code compliant with Swift 6 language mode.
- Keep strict concurrency checking enabled.
- Use modern structured concurrency (`async`/`await`, task groups) instead of legacy async patterns.
- For app-facing packages, prefer approachable concurrency defaults with main-actor isolation by default.
- Introduce parallelism where it produces clear performance gains.

## State, Frameworks, and Dependencies

- Prefer `@Observation` over Combine for observation/state propagation.
- Prefer frameworks and packages from Swift.org, Swift on Server, Apple, and Apple Open Source ecosystems when suitable.
- Commonly acceptable examples include packages like `swift-algorithms`.

## Testing and Tooling Baseline

- Use Swift Testing (`import Testing`) as the default test framework.
- Avoid XCTest unless an external constraint requires it.
- Keep formatting consistent with `swift-format` conventions.
- Keep linting clean against `swiftlint` with clear, maintainable rule intent.

## CLI Tooling Preferences

- Prefer `swift package` for package-focused workflows (dependency graph, targets, manifest intent, and local package validation).
- Prefer `swift package` subcommands for structural package edits before manually editing `Package.swift`.
- Use `swift build` and `swift test` as the default first-pass validation commands.
- Use `xcodebuild` when validating Apple platform integration details that `swift package` does not cover well (schemes, destinations, SDK-specific behavior, and configuration-specific builds/tests).
- Keep `xcodebuild` invocations explicit and reproducible (always pass scheme, destination or SDK, and configuration when relevant).
- Prefer deterministic non-interactive CLI usage in automation/CI for both `swift package` and `xcodebuild`.
