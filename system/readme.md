# Life Mono

<!-- If you already have a Life mono file, move this section into it and delete duplicates. -->

## 🧩 System

### Overview
Tracks configuration, theming, and automation of the full environment — from base packages to shell UX.
**Scope:** Arch setup, dotfiles repo, desktop environment (Hyprland / Crostini), theming (Tinty), editors, terminal stack, and CLI automation.

### Objectives
- Maintain a stable, reproducible environment with minimal breakage after updates.
- Reduce friction between daily creative/learning work and system upkeep.
- Integrate the system as a first-class domain of the Life mono (so tasks and priorities appear beside study and therapy tracks).

### Subdomains
| Subdomain | Description | Current Status |
|----------|-------------|----------------|
| **Dotfiles** | Chezmoi-managed configs, GitHub repo, branching workflow. | Up to date (`main`); Starship removed; Tinty migration planned. |
| **Shell** | Fish configuration, aliases, functions, prompt logic. | Stable post-cleanup; prompt uses base vars; no Starship. |
| **Theming** | Tinty-first workflow; integration with Kitty, Helix, Zellij, Fish. | Templates staged; installation pending. |
| **Workspaces** | Zellij layouts and automation scripts. | Dev layout validated; plugins pending install. |
| **File Ops** | Yazi setup, preview plugins, search/replace tooling (Scooter). | Base install complete; plugin setup pending. |
| **Automation** | Makefile and orchestration scripts for recurring tasks. | Defined; awaiting theming migration. |

### Task Priorities
1. ✅ Revert old theming merges (done).
2. 🔜 Integrate System section into Life mono (today).
3. ⏳ Deploy Tinty hard-fork package and sanity check.
4. ⏳ Install Yazi + Zellij plugins (aligned with Tinty).
5. 💤 Evaluate additional QOL tools (notifications, service scripts, systemd timers).

### Metrics
- Boot-to-productive (login → ready shell) under 5 s.
- Zero broken CLI on update.
- Theming switch < 10 s via `make theme THEME=<name>`.
- Repository remains clean (`git status` = 0 after theme switch).

### Notes
- All system updates, migrations, and cleanup tasks are logged here weekly.
- Tag related entries with `#system` to integrate into searches and dashboards.

---

### 🏷️ Tag Definition – System (`#system`)

**Domain:** Infrastructure & Environment
**Scope:** All work related to system configuration, automation, and maintenance.

**Applies To:**
- Dotfiles and chezmoi workflows
- Fish shell functions, prompt, and scripts
- Terminal stack (Kitty, Helix, Zellij, Yazi)
- Theming and Tinty integration
- Automation scripts (Makefile, unit files, hooks)
- Local development tools (Scooter, ripgrep, fd, etc.)
- System hygiene, updates, and backups

**Tracking Format:**
 #system [Area] – Short description
Example: #system [Theming] – integrate tinty apply hook into login shell

markdown
Copy code

**Review Frequency:** Weekly
**Metrics:**
- CLI uptime and reliability
- Time-to-productive-session
- Config parity across hosts
- Repository cleanliness (`git status` clear)

**Priority Flags:**
- 🧩 Configuration / Setup
- ⚙️ Maintenance / Update
- 🚀 Enhancement / Automation
- 🐞 Fix / Regression

**Dashboard Filters:**
- `#system & 🧩` → new configuration work
- `#system & ⚙️` → upkeep / verification tasks
- `#system & 🚀` → automation improvements
- `#system & 🐞` → bug or regression remediation
