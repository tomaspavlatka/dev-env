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

- `dev-env` — Copies files from `env/` to their live locations (`~/.config/`, `~/.zshrc`, etc.). Does rm+copy, not merge. Pass `--real` to apply.
- `dev-run` — Discovers and runs all executable `run/*.sh` scripts. Supports grep filtering. Pass `--real` to execute.

**`env/`** — Source of truth for all dotfiles:
- `.zshrc` — Zsh config (Oh My Zsh + Powerlevel10k, fzf, zoxide, nvm)
- `.tmux.conf` — Tmux config (Gruvbox dark, vim-style splits)
- `.config/nvim/` — Neovim config (lazy.nvim plugin manager, Nord theme)

**`run/`** — Individual Homebrew/npm install scripts. All follow the same idempotent pattern: check `brew list`, upgrade if present, install if not.

## Neovim Config Structure

Entry point: `env/.config/nvim/init.lua` → `lua/tomaspavlatka/init.lua`

- `set.lua` — Vim options (relative numbers, 2-space tabs, 120 col)
- `remap.lua` — Key mappings (leader = Space)
- `lsp.lua` — LSP keybinds and server config (ts_ls, pyright)
- `plugins/` — One file per plugin (telescope, harpoon, oil, treesitter, mason, nvim-cmp, trouble, fugitive, cloak, colors)

## Conventions

- Install scripts go in `run/` as standalone `.sh` files
- All install scripts must be idempotent (check before install/upgrade)
- Dotfiles are stored in `env/` mirroring their home directory path
- Both `dev-env` and `dev-run` default to dry run for safety
