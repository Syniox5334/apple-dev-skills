#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  sync_agents_md.sh [--canonical <path>] [--repo <path> | --root <path>] [--check] [--verbose]

Options:
  --canonical <path>  Canonical AGENTS.md source file. Defaults to ../assets/AGENTS.md.
  --repo <path>       Single repository path containing Package.swift.
  --root <path>       Root path to scan recursively for Swift package repositories.
                     Defaults to ~/Workspace when neither --repo nor --root is provided.
  --check             Read-only drift detection mode; exit 1 when drift exists.
  --verbose           Print per-repo action details.
  -h, --help          Show this help.
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CANONICAL="${SCRIPT_DIR}/../assets/AGENTS.md"
REPO_PATH=""
ROOT_PATH=""
CHECK_MODE=0
VERBOSE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --canonical)
      CANONICAL="$2"
      shift 2
      ;;
    --repo)
      REPO_PATH="$2"
      shift 2
      ;;
    --root)
      ROOT_PATH="$2"
      shift 2
      ;;
    --check)
      CHECK_MODE=1
      shift
      ;;
    --verbose)
      VERBOSE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ ! -f "$CANONICAL" ]]; then
  echo "Canonical file not found: $CANONICAL" >&2
  exit 2
fi

if [[ -n "$REPO_PATH" && -n "$ROOT_PATH" ]]; then
  echo "Use either --repo or --root, not both." >&2
  exit 2
fi

if [[ -z "$REPO_PATH" && -z "$ROOT_PATH" ]]; then
  ROOT_PATH="$HOME/Workspace"
fi

declare -a REPOS=()

if [[ -n "$REPO_PATH" ]]; then
  if [[ -f "$REPO_PATH/Package.swift" ]]; then
    REPOS+=("$(cd "$REPO_PATH" && pwd)")
  else
    echo "Not a Swift package repository (missing Package.swift): $REPO_PATH" >&2
    exit 2
  fi
else
  if [[ ! -d "$ROOT_PATH" ]]; then
    echo "Root path not found: $ROOT_PATH" >&2
    exit 2
  fi

  while IFS= read -r package_manifest; do
    repo_dir="$(dirname "$package_manifest")"
    REPOS+=("$repo_dir")
  done < <(
    find "$ROOT_PATH" \
      \( -type d \( -name ".*" -o -name ".build" -o -name ".swiftpm" -o -name "node_modules" -o -name "*.xcworkspace" -o -name "*.xcodeproj" -o -name "DerivedData" \) -prune \) -o \
      \( -type f -name "Package.swift" -print \) \
      | sort -u
  )
fi

if [[ ${#REPOS[@]} -eq 0 ]]; then
  echo "No Swift package repositories found." >&2
  exit 0
fi

scanned=0
unchanged=0
updated=0
drift=0

for repo in "${REPOS[@]}"; do
  scanned=$((scanned + 1))
  target="$repo/AGENTS.md"

  if [[ -f "$target" ]] && cmp -s "$CANONICAL" "$target"; then
    unchanged=$((unchanged + 1))
    [[ $VERBOSE -eq 1 ]] && echo "UNCHANGED $repo"
    continue
  fi

  drift=$((drift + 1))

  if [[ $CHECK_MODE -eq 1 ]]; then
    [[ $VERBOSE -eq 1 ]] && echo "DRIFT    $repo"
    continue
  fi

  cp "$CANONICAL" "$target"
  updated=$((updated + 1))
  [[ $VERBOSE -eq 1 ]] && echo "UPDATED  $repo"
done

echo "scanned=$scanned unchanged=$unchanged drift=$drift updated=$updated mode=$([[ $CHECK_MODE -eq 1 ]] && echo check || echo apply)"

if [[ $CHECK_MODE -eq 1 && $drift -gt 0 ]]; then
  exit 1
fi

exit 0
