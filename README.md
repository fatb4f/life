# GitHub Bootstrap: Repo • Project • Board • Milestones • Labels • Issues

This package bootstraps a repository with:
- Opinionated labels
- Milestones (example cadence)
- Issue templates
- A GitHub **Projects (v2)** board with common views
- Seed issues
- Makefile-driven automation wrapping **gh** CLI

> Designed for a detached-generation workflow: edit seeds, run `make init` once, iterate with idempotent targets.

## Prereqs
- GitHub CLI: `gh` (authenticated: `gh auth login`)
- Bash + GNU coreutils
- jq (for json plumbing)

## Quickstart
1. Edit `config/repo.env` to set your OWNER, REPO, and PROJECT_TITLE.
2. Dry run (no changes): `make plan`
3. Bootstrap everything: `make init`
4. Add a new week of issues: `make week`
5. Create a timestamped commit & push: `make push`

## Layout
- `config/repo.env` — owner/repo/project configuration
- `seeds/labels.tsv` — label name, color, description
- `seeds/milestones.csv` — title, due_on (ISO-8601), description
- `seeds/issues.csv` — title, body_path, labels (comma), milestone (title)
- `seeds/views.json` — default Project views (Board, Table, By Label)
- `.github/ISSUE_TEMPLATE/*.md` — templates for chore/task/bug/docs
- `scripts/*.sh` — gh wrappers (idempotent where feasible)
- `Makefile` — top-level automation

## Notes
- Projects (v2) scripting uses `gh project` and `gh api` (for a few gaps).
- All scripts are written to be **idempotent**: re-runs won’t duplicate items.
- Customize seeds then re-run specific targets (e.g., `make labels`, `make milestones`).

