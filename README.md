# apple-dev-skills

Codex skills for Apple development workflows focused on Swift, Xcode, Dash docs, and repository policy maintenance.

## v2.0.0 Highlights

This repository now exposes five canonical skills:

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

# Swift package bootstrap + AGENTS sync
npx skills add gaelic-ghost/apple-dev-skills \
  --skill apple-swift-package-bootstrap \
  --skill apple-swift-package-agents-sync
```

## Breaking Migration Map (v2.0.0)

- `apple-xcode-hybrid-orchestrator` -> `apple-xcode-workflow-execute` (merged)
- `xcode-mcp-first-executor` -> `apple-xcode-workflow-execute` (merged)
- `apple-swift-cli-fallback` -> `apple-xcode-workflow-execute` (merged)
- `apple-dev-safety-and-docs` -> `apple-xcode-workflow-execute` (merged)
- `dash-docset-search` -> `apple-dash-docset-manage` (merged)
- `dash-docset-install-generate` -> `apple-dash-docset-manage` (merged)
- `bootstrap-swift-package` -> `apple-swift-package-bootstrap`
- `swift-package-agents-maintainer` -> `apple-swift-package-agents-sync`

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
    ├── apple-swift-package-bootstrap/
    └── apple-swift-package-agents-sync/
```

## v1.6.2 Highlights

Version `v1.6.2` was the final pre-v2 grouped-layout release before canonical rename and consolidation.

## Resources

- Vercel guidance: https://vercel.com/kb/guide/agent-skills-creating-installing-and-sharing-reusable-agent-context
- Skills catalog: https://skills.sh/

## License

See [LICENSE](./LICENSE).
