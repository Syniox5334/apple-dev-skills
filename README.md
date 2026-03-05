# apple-dev-skills

Codex skills for Apple development workflows focused on Swift, Xcode, Dash docs, and repository policy maintenance.

## v2.0.0 Highlights

Version `v2.0.0` introduced five canonical skills:

- `apple-skills-router-advise-install`
  - Routes requests to the right skill and provides install commands for missing skills.
- `apple-xcode-workflow-execute`
  - Canonical Apple/Swift execution workflow with MCP-first routing, official CLI fallback, mutation safety gates, and Dash-local-first docs routing.
- `apple-dash-docset-manage`
  - Unified Dash docset search/install/generation workflow.
- `apple-swift-package-bootstrap`
  - Deterministic Swift package bootstrap workflow.
- `apple-swift-package-agents-sync`
  - Canonical AGENTS synchronization workflow across Swift package repos.

## Planned v3.0.0 Changes

`v3.0.0` removes `apple-swift-package-agents-sync` as a breaking change and keeps four active skills in this repository:

- `apple-skills-router-advise-install`
- `apple-xcode-workflow-execute`
- `apple-dash-docset-manage`
- `apple-swift-package-bootstrap`

Migration notes:

- `apple-swift-package-agents-sync` removed in `v3.0.0`.
- Use `apple-swift-package-bootstrap` for deterministic AGENTS setup in new Swift package repos.
- Use [`shared/agents-snippets/apple-swift-core.md`](./shared/agents-snippets/apple-swift-core.md) for AGENTS baseline updates in existing repos.
- Use dedicated docs-alignment skills (maintained outside this repo) for cross-repo AGENTS drift and documentation alignment workflows.

## Install

Install one skill:

```bash
npx skills add gaelic-ghost/apple-dev-skills --skill apple-xcode-workflow-execute
```

Install all skills:

```bash
npx skills add gaelic-ghost/apple-dev-skills --all
```

Pack-oriented installs:

```bash
# Routing
npx skills add gaelic-ghost/apple-dev-skills --skill apple-skills-router-advise-install

# Xcode and Swift execution
npx skills add gaelic-ghost/apple-dev-skills --skill apple-xcode-workflow-execute

# Dash docs
npx skills add gaelic-ghost/apple-dev-skills --skill apple-dash-docset-manage

# Swift package bootstrap
npx skills add gaelic-ghost/apple-dev-skills \
  --skill apple-swift-package-bootstrap
```

## Shared AGENTS Snippet

Repository-consumable Swift/Apple baseline policy snippet:

- [shared/agents-snippets/apple-swift-core.md](./shared/agents-snippets/apple-swift-core.md)

Use this snippet for cross-project standards that belong in `AGENTS.md`.
Keep workflow orchestration and tool-routing policies in skills.

## Repository Layout

```text
.
├── README.md
├── ROADMAP.md
├── shared/
│   └── agents-snippets/
│       └── apple-swift-core.md
└── skills/
    ├── apple-skills-router-advise-install/
    ├── apple-xcode-workflow-execute/
    ├── apple-dash-docset-manage/
    └── apple-swift-package-bootstrap/
```

## v1.6.2 Highlights

Version `v1.6.2` was the final pre-v2 grouped-layout release before canonical rename and consolidation.

Maintainers: authoritative skill-authoring resources live in `AGENTS.md`.

## License

See [LICENSE](./LICENSE).
