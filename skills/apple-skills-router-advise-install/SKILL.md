---
name: apple-skills-router-advise-install
description: Route Apple development requests to the correct Apple skills bundle skill and advise precise installation commands when the required skill is missing. Use when users need help composing skills, selecting the right skill, or installing missing skills from this repository.
---

# Apple Skills Router Advise Install

Use this skill to route intent and provide install guidance for missing skills.

## Routing Table

- Xcode, Swift execution, MCP/CLI fallback, mutation safety, docs routing -> `$apple-xcode-workflow-execute`
- Dash docset search/install/generation -> `$apple-dash-docset-manage`
- Bootstrap new Swift package repos -> `$apple-swift-package-bootstrap`
- AGENTS maintenance and policy updates -> recommend `references/snippets/apple-swift-core.md` plus dedicated docs-alignment skills outside this repository.

## Install Advisory Workflow

1. Identify required skill from intent.
2. If available, route directly to that skill.
3. If missing, provide exact install command:
- `npx skills add gaelic-ghost/apple-dev-skills --skill <skill-name>`
4. Offer pack-level installation when it reduces friction.

## Pack Suggestions

- Xcode workflow pack:
  - `npx skills add gaelic-ghost/apple-dev-skills --skill apple-xcode-workflow-execute`
- Dash docs pack:
  - `npx skills add gaelic-ghost/apple-dev-skills --skill apple-dash-docset-manage`
- Swift package pack:
  - `npx skills add gaelic-ghost/apple-dev-skills --skill apple-swift-package-bootstrap`

## Constraints

- Do not claim implicit runtime installation APIs.
- Use documented CLI-driven install guidance.
- Keep recommendations explicit and copy-paste ready.

## References

- `references/routing-matrix.md`
- `references/install-commands.md`
- `references/customization-flow.md`
- `references/snippets/apple-swift-core.md`

## Local Snippet Guidance

- When routed work includes setting up or updating a repository `AGENTS.md`, recommend the local snippet `references/snippets/apple-swift-core.md` for Swift/Apple baseline policy.
- For cross-repo AGENTS drift and documentation alignment workflows, recommend dedicated docs-alignment skills maintained outside this repository.
- Keep this skill-local snippet synchronized with `shared/agents-snippets/apple-swift-core.md`.

## Interactive Customization Flow

1. Load effective settings:
- `uv run python scripts/customization_config.py effective`

2. Ask targeted routing/pack preference questions with `references/customization-flow.md`.

3. Persist approved overrides:
- `uv run python scripts/customization_config.py apply --input <yaml-file>`
  - Treat customization knobs as policy defaults unless runtime script behavior is explicitly wired to those settings.

4. Re-check effective settings:
- `uv run python scripts/customization_config.py effective`
