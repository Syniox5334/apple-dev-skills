# Swift Package Type Guide

## Package Types

- `library`: reusable code consumed by other packages or apps. Default choice.
- `executable`: runnable command-line package with an entry point. Default CLI choice.
- `tool`: advanced explicit passthrough to `swift package init --type tool`. Use this only when the active Swift toolchain's tool template is explicitly desired; otherwise prefer `executable`.

Choose `library` unless you explicitly need a runnable CLI (`executable` or `tool`).

## Platform Presets

- `mac`: macOS only.
- `macos`: Alias for `mac`.
- `mobile`: iOS only.
- `ios`: Alias for `mobile`.
- `multiplatform`: iOS + macOS.
- `both`: Alias for `multiplatform`.

Choose `multiplatform` unless platform scope is explicitly constrained.

## Version Profiles

- `latest-major`: iOS `26.0`, macOS `26.0`
- `current-minus-one`: iOS `18.0`, macOS `15.0` (default)
- `current-minus-two`: iOS `17.0`, macOS `14.0`
- `latest`: Alias for `latest-major`
- `minus-one`: Alias for `current-minus-one`
- `minus-two`: Alias for `current-minus-two`

The bootstrap script applies these by patching `Package.swift` with string platform versions.
