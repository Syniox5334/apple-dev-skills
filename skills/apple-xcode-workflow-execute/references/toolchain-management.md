# Toolchain Management

## Preferred path

1. If `swiftly` exists, prefer it for selecting and managing Swift toolchains.
2. If `swiftly` is unavailable, use official Xcode/CLT paths.

## Quickly check toolchain state

- `swift --version`
- `xcodebuild -version`
- `xcode-select -p`
- `xcrun --find swift`

## Official Xcode and CLT actions

- Select active developer directory:
  - `xcode-select --switch <Xcode.app/Contents/Developer>`
- Install/repair command line tools (interactive on macOS):
  - `xcode-select --install`

## Guidance

- Prefer explicit output of versions and selected developer dir before diagnosing build/test failures.
- Keep fallback commands deterministic and project-local.
