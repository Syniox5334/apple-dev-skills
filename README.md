# apple-dev-skills

Canonical Codex skills for Apple development workflows focused on Xcode execution, Dash docsets, Swift package bootstrap, and Apple-skill routing.

## Active Skills

- `apple-skills-router`
  - Routes Apple and Swift requests to the right active skill and returns install guidance only as fallback when a skill is missing.
- `apple-xcode-workflow`
  - Canonical Apple and Swift execution workflow with one MCP-first engine, official CLI fallback, mutation guards, and local-first docs guidance.
- `apple-dash-docsets`
  - Manages Dash docsets through a straight stage flow: `search -> install -> generate`.
- `apple-swift-package-bootstrap`
  - Deterministic Swift package bootstrap workflow with verification and `AGENTS.md` generation.

Every active skill now follows the same documentation contract:

- one primary workflow per request type
- explicit `inputs`, `defaults`, `status`, `path_type`, and `output`
- named `fallback` and `handoff` behavior
- customization knobs labeled `policy-only` unless runtime enforcement exists

Detailed workflow diagrams, input/output contracts, and Agent ↔ User UX maps live in [WORKFLOWS.md](./WORKFLOWS.md).

## Install

Install one skill:

```bash
npx skills add gaelic-ghost/apple-dev-skills --skill apple-xcode-workflow
```

Install all active skills:

```bash
npx skills add gaelic-ghost/apple-dev-skills --all
```

Common starting points:

- Router:
  `npx skills add gaelic-ghost/apple-dev-skills --skill apple-skills-router`
- Xcode workflow:
  `npx skills add gaelic-ghost/apple-dev-skills --skill apple-xcode-workflow`
- Dash docsets:
  `npx skills add gaelic-ghost/apple-dev-skills --skill apple-dash-docsets`
- Swift package bootstrap:
  `npx skills add gaelic-ghost/apple-dev-skills --skill apple-swift-package-bootstrap`

## Migration

This pass normalized public skill names for clarity and consistency.

| Old ID | New ID |
| --- | --- |
| `apple-skills-router-advise-install` | `apple-skills-router` |
| `apple-xcode-workflow-execute` | `apple-xcode-workflow` |
| `apple-dash-docset-manage` | `apple-dash-docsets` |

This is a naming and workflow-clarity cleanup. Update install commands, references, and automation prompts to the new IDs.

## AGENTS Guidance

Repository-consumable Swift/Apple baseline policy snippet:

- [shared/agents-snippets/apple-swift-core.md](./shared/agents-snippets/apple-swift-core.md)

Use this snippet for cross-project standards that belong in `AGENTS.md`.

- For new Swift package repositories, `apple-swift-package-bootstrap` copies its full `assets/AGENTS.md` template, which already incorporates this baseline.
- For existing repositories, use the shared snippet for targeted updates.
- For cross-repo AGENTS drift and documentation alignment workflows, use dedicated docs-alignment skills maintained outside this repository.

## Retired Skill Note

`apple-swift-package-agents-sync` is no longer part of the active skill surface.

- New repository scaffolds should use `apple-swift-package-bootstrap`.
- Existing repositories should use the shared snippet plus external docs-alignment skills when AGENTS maintenance is needed.

## Repository Layout

```text
.
├── README.md
├── ROADMAP.md
├── shared/
│   └── agents-snippets/
│       └── apple-swift-core.md
└── skills/
    ├── apple-skills-router/
    ├── apple-xcode-workflow/
    ├── apple-dash-docsets/
    └── apple-swift-package-bootstrap/
```

Maintainers: authoritative skill-authoring resources live in `AGENTS.md`.

## License

See [LICENSE](./LICENSE).
