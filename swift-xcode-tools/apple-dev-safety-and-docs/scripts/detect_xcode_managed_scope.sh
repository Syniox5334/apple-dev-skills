#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
if [ ! -d "$ROOT" ]; then
  echo "{\"managed\":false,\"reason\":\"path-not-directory\",\"path\":\"$ROOT\"}"
  exit 0
fi

found="$(find "$ROOT" \( -name "*.xcodeproj" -o -name "*.xcworkspace" -o -name "*.pbxproj" \) -print -maxdepth 4 2>/dev/null | head -n 20)"

if [ -n "$found" ]; then
  printf '{"managed":true,"path":"%s","markers":[\n' "$ROOT"
  first=1
  while IFS= read -r line; do
    [ -z "$line" ] && continue
    if [ "$first" -eq 0 ]; then
      printf ',\n'
    fi
    first=0
    esc="${line//\"/\\\"}"
    printf '  "%s"' "$esc"
  done <<< "$found"
  printf '\n]}\n'
else
  printf '{"managed":false,"path":"%s","markers":[]}\n' "$ROOT"
fi
