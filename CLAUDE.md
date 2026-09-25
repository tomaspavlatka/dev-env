# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal macOS developer environment configuration (dotfiles + tool installers). Pure Bash, no frameworks.

## Key Commands

```bash
./dev-env           # Dry run: shows what dotfiles would be deployed
./dev-env --real    # Deploy dotfiles from env/ to ~/

./dev-run                      # Dry run: lists all install scripts
./dev-run --real               # Install/update all tools
./dev-run neovim --real        # Install/update only matching scripts

./dev-remove nushell                       # Dry run: shows what would be removed
./dev-remove nushell --real                # Uninstall + delete run/nushell.sh
./dev-remove nushell --real --keep-script  # Uninstall only, leave run/ untouched

./dev-detox                    # Dry run: lists what would be cleared
./dev-detox --real             # Move Desktop/Downloads/Documents contents to Trash
./dev-detox downloads --real   # Limit to one folder

./dev-remember                 # Dry run: lists the days it would collect
./dev-remember --real          # Write "memories - all.md" into the vault
./dev-remember 2026 --real     # One year
./dev-remember 2026-09 --real  # One month
./dev-remember --from 2025-06-01 --to 2025-06-30 --real
```

There are no build, test, or lint commands.

## Architecture

**Five scripts, two directories:**

- `dev-env` — Copies files from `env/` to their live locations (`~/.config/`, `~/.zshrc`, etc.). Does rm+copy, not merge. Pass `--real` to apply. **Note:** the repo path is hardcoded as `$HOME/codebase/personal/dev-env`.
  - Exception: directories listed in `PRESERVE_DIRS` are overlaid instead of rm+copy, because the app writes its own state there that isn't tracked in the repo. Currently `karabiner` (Karabiner-Elements owns `automatic_backups/` and `assets/`). Stale files in a preserved directory are *not* cleaned up — remove them by hand.
  - Claude Code skills deploy from `env/.claude/skills/` to `~/.claude/skills/`. The copy is scoped one level down, at `skills/`, never at `~/.claude/` — the rm+copy would otherwise wipe settings, auth and per-project state that only live there.
  - `env/.claude/CLAUDE.md` is copied file-by-file to `~/.claude/CLAUDE.md` for the same reason — user-level memory, which Claude Code merges with each project's own `CLAUDE.md`.
- `dev-run` — Discovers and runs all executable `run/*.sh` scripts. Supports grep filtering. Pass `--real` to execute.
- `dev-remove` — Inverse of `dev-run` for a single tool: uninstalls the Homebrew formula/cask (or global npm package) and deletes the matching `run/*.sh`, so `dev-run` won't reinstall it. Resolves the script by exact `run/<name>.sh` first, then by grepping `run/` (refuses if that matches more than one). Warns about config still tracked in `env/` but never deletes it. Pass `--real` to apply.
- `dev-detox` — Weekly cleanup, unrelated to the other three. For each of `~/Desktop`, `~/Downloads` and `~/Documents` it collects the folder's contents into a dated staging folder (`desktop-<weekday>-YYYYMMDD/`, weekday from `LC_ALL=C date +%A`; `-2` suffix on same-day reruns) and trashes that one folder via Finder (`osascript` → `tell application "Finder" to delete`), so the Trash records the origin and Put Back restores the whole pile. Skips hidden files; honours the `KEEP=()` glob list at the top of the script. Pass `--real` to apply.
- `dev-remember` — Also unrelated to the env scripts. Collects the "remember" sections out of the Obsidian journal (`~/codebase/personal/ptx-obsidian-wiki`, path hardcoded like `dev-env`'s) into one chronological page under `3 - areas/3.12 - memories/`, which you then export to PDF from Obsidian. Range defaults to everything; takes a year (`2026`), a month (`2026-09`), or `--from`/`--to`. Never overwrites — a second run writes `memories - 2026 (2).md`. Daily notes are only ever read. Pass `--real` to apply.
  - It matches **three** headings, because the journal's format changed: `## :LiBookOpenCheck: Today I will remember` (current, and it carries a trailing space), plus the June 2025 pair `#### :LiWorkflow: I will remember today because of ....` and `#### :LiNotebookPen: Journal`. A single day can have both legacy sections; they are merged under one date, so in the awk a heading must be tested as an *opener* before it is tested as a terminator, or the second section is swallowed.
  - Most of those headings are empty — the template emits them whether or not anything was written — so a bare run currently yields 21 days out of 315 notes, not 315. The dry run prints that skip count on purpose; without it the output looks broken.
  - `20250624-Tuesday ex.md` is excluded by the strict `^[0-9]{8}-[A-Za-z]+\.md$` filename match. It duplicates a real date, so without the filter that day would get two headings.
  - Image embeds are deliberately **not** rewritten. The page lives in the vault, so `![[name.webp]]` resolves on its own. Count occurrences, not lines — 2025-06-21 puts three embeds on one line.

**`env/`** — Source of truth for all dotfiles:
- `.zshrc` — Zsh config (Oh My Zsh + Powerlevel10k, fzf, zoxide, nvm)
- `.tmux.conf` — Tmux config (Gruvbox dark, vim-style splits)
- `.p10k.zsh` — Powerlevel10k prompt theme config
- `.mbsyncrc` — Email sync (isync/mbsync) config
- `.config/nvim/` — Neovim config (lazy.nvim plugin manager, Nord theme)
- `intelephense/` — PHP LSP (Intelephense) license key directory
- `.claude/CLAUDE.md` — User-level Claude Code memory, applied on top of every project's `CLAUDE.md`
- `.claude/skills/` — Claude Code skills (`pr-log` — logs a GitHub PR into the Obsidian work journal)

**`run/`** — Individual Homebrew/npm install scripts. All follow the same idempotent pattern: check `brew list`, upgrade if present, install if not.
  - Exception: `tfenv.sh` installs Terraform too, not just the named package. Terraform is no longer installable from Homebrew (dropped from homebrew-core after the BUSL relicense; `hashicorp/tap` fails to load under Homebrew 7), so the script installs `tfenv` via brew and then `tfenv install latest`. There is no `terraform.sh`.
  - Exception: `nvm.sh` uses no Homebrew at all. nvm upstream refuses to support the brew formula, so the script pipes the official installer into bash, pinned to the newest GitHub release (with a hardcoded fallback tag when the API is unreachable). `PROFILE=/dev/null` keeps the installer out of the live `~/.zshrc` — the nvm hook is tracked in `env/.zshrc`. It `mkdir`s `~/.nvm` first, because `XDG_CONFIG_HOME` is set and the installer otherwise rejects a `$NVM_DIR` that isn't its own default (`~/.config/nvm`). It installs no node version; `nvm install --lts` is a manual step. `dev-remove nvm` deletes the script but cannot uninstall nvm — remove `~/.nvm` by hand. Note Homebrew's `node` is still present as a `mongosh` dependency; that is what nvm calls `system`.
  - Exception: `corepack.sh` installs nothing. corepack ships inside every nvm-installed node, but its shims (`yarn`, `pnpm`) are linked per node version, so the script loops over `$NVM_DIR/versions/node/*/bin` and runs `corepack enable` for each. This is what makes a project's pinned `packageManager` (e.g. `yarn@4.12.0`) work instead of the global yarn. Re-run it after every `nvm install`. Homebrew's node ships no corepack at all.

**Root-level standalone scripts** (`forto-cli.sh`) — Same install pattern but *not* managed by `dev-run` (they live outside `run/`).

## Neovim Config Structure

Entry point: `env/.config/nvim/init.lua` → `lua/tomaspavlatka/init.lua`

- `set.lua` — Vim options (relative numbers, 2-space tabs default, 4-space for TypeScript, 120 col)
- `remap.lua` — Key mappings (leader = Space)
- `lsp.lua` — LSP keybinds using native `vim.lsp.enable()` (not nvim-lspconfig); servers: ts_ls, pyright
- `plugins/` — One file per plugin (telescope, harpoon, oil, treesitter, mason, nvim-cmp, trouble, fugitive, cloak, colors, markdown-preview, octo)

## Conventions

- Install scripts go in `run/` as standalone `.sh` files, named after the Homebrew package they install (`monitorcontrol.sh`, not `monitor-control.sh`) so `dev-remove <package>` finds them
- All install scripts must be idempotent (check before install/upgrade)
- Dotfiles are stored in `env/` mirroring their home directory path
- All five scripts default to dry run; `--real` applies
