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
```

There are no build, test, or lint commands.

## Architecture

**Two scripts, two directories:**

- `dev-env` — Copies files from `env/` to their live locations (`~/.config/`, `~/.zshrc`, etc.). Does rm+copy, not merge. Pass `--real` to apply. **Note:** the repo path is hardcoded as `$HOME/codebase/personal/dev-env`.
  - Exception: directories listed in `PRESERVE_DIRS` are overlaid instead of rm+copy, because the app writes its own state there that isn't tracked in the repo. Currently `karabiner` (Karabiner-Elements owns `automatic_backups/` and `assets/`). Stale files in a preserved directory are *not* cleaned up — remove them by hand.
- `dev-run` — Discovers and runs all executable `run/*.sh` scripts. Supports grep filtering. Pass `--real` to execute.

**`env/`** — Source of truth for all dotfiles:
- `.zshrc` — Zsh config (Oh My Zsh + Powerlevel10k, fzf, zoxide, nvm)
- `.tmux.conf` — Tmux config (Gruvbox dark, vim-style splits)
- `.p10k.zsh` — Powerlevel10k prompt theme config
- `.mbsyncrc` — Email sync (isync/mbsync) config
- `.config/nvim/` — Neovim config (lazy.nvim plugin manager, Nord theme)
- `intelephense/` — PHP LSP (Intelephense) license key directory

**`run/`** — Individual Homebrew/npm install scripts. All follow the same idempotent pattern: check `brew list`, upgrade if present, install if not.

**Root-level standalone scripts** (`forto-cli.sh`, `gh.sh`) — Same install pattern but *not* managed by `dev-run` (they live outside `run/`).

## Neovim Config Structure

Entry point: `env/.config/nvim/init.lua` → `lua/tomaspavlatka/init.lua`

- `set.lua` — Vim options (relative numbers, 2-space tabs default, 4-space for Java/TypeScript, 120 col)
- `remap.lua` — Key mappings (leader = Space)
- `lsp.lua` — LSP keybinds using native `vim.lsp.enable()` (not nvim-lspconfig); servers: ts_ls, pyright
- `plugins/` — One file per plugin (telescope, harpoon, oil, treesitter, mason, nvim-cmp, trouble, fugitive, cloak, colors, markdown-preview, octo)

## Conventions

- Install scripts go in `run/` as standalone `.sh` files
- All install scripts must be idempotent (check before install/upgrade)
- Dotfiles are stored in `env/` mirroring their home directory path
- Both `dev-env` and `dev-run` default to dry run for safety
