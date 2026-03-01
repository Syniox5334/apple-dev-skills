#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

echo "Validating roadmap presence..."
[[ -f ROADMAP.md ]] || fail "Missing ROADMAP.md at repo root."

echo "Validating skill directory layout..."
skill_mds=()
while IFS= read -r line; do
  skill_mds+=("$line")
done < <(find . -mindepth 2 -maxdepth 2 -type f -name SKILL.md | sort)
[[ ${#skill_mds[@]} -gt 0 ]] || fail "No skill directories found (missing */SKILL.md)."

for skill_md in "${skill_mds[@]}"; do
  skill_dir="${skill_md%/SKILL.md}"
  [[ -f "$skill_dir/agents/openai.yaml" ]] || fail "Missing $skill_dir/agents/openai.yaml"
  [[ -f "$skill_dir/customization.template.yaml" ]] || fail "Missing $skill_dir/customization.template.yaml"
  [[ -f "$skill_dir/scripts/customization_config.py" ]] || fail "Missing $skill_dir/scripts/customization_config.py"
  [[ -d "$skill_dir/references" ]] || fail "Missing $skill_dir/references/"
  grep -q "^## Interactive Customization Flow$" "$skill_md" || fail "Missing '## Interactive Customization Flow' in $skill_md"

  # Some skills are policy-only and intentionally do not ship scripts.
  if grep -q "scripts/" "$skill_md"; then
    [[ -d "$skill_dir/scripts" ]] || fail "Missing $skill_dir/scripts/ (referenced by $skill_md)"
  fi
done

echo "Validating root README release continuity..."
latest_tag="$(git tag --sort=version:refname | tail -n 1)"
[[ -n "$latest_tag" ]] || fail "No git tags found; cannot validate README release coverage."

escaped_tag="$(printf '%s' "$latest_tag" | sed 's/\./\\./g')"
if ! grep -Eq "^## ${escaped_tag} (Highlights|Contents)$" README.md; then
  fail "README.md missing heading for latest tag ${latest_tag} (expected '## ${latest_tag} Highlights' or '## ${latest_tag} Contents')."
fi

echo "All validation checks passed."
