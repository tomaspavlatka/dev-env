# Tomas Pavlatka Dev Environment

## Basics
- iTerm2 theme: https://github.com/nordtheme/iterm2
- Font: https://www.jetbrains.com/lp/mono/#how-to-install

Inspired by https://github.com/bcampolo/nvim-starter-kit/tree/java

## Prerequisites

`dev-env` and `dev-run` assume a machine that is already bootstrapped. On a
fresh macOS install, do all of this *before* running them.

### 1. Xcode Command Line Tools

```bash
xcode-select --install
```

Gives you `git` and a C compiler. Homebrew needs it, and so does Neovim's
treesitter (`:TSUpdate` compiles parsers).

### 2. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Every script in `run/` calls `brew` without checking that it exists.

### 3. SSH keys + clone to the exact path

`dev-env` hardcodes `DEV_ENV=$HOME/codebase/personal/dev-env`, so the repo has
to live there.

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_personal
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_forto
# add both public keys to the matching GitHub accounts

mkdir -p ~/codebase/personal
git clone git@github.com:tomaspavlatka/dev-env.git ~/codebase/personal/dev-env
chmod +x ~/codebase/personal/dev-env/dev-env ~/codebase/personal/dev-env/dev-run \
         ~/codebase/personal/dev-env/dev-remove ~/codebase/personal/dev-env/run/*.sh
```

`dev-run` only picks up scripts with the executable bit (`find -perm +111`).

### 4. Oh My Zsh + theme + plugins

`.zshrc` sources `$ZSH/oh-my-zsh.sh` and names four things that nothing in this
repo installs. Without them the shell is broken after `./dev-env --real`.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git          $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git            $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git        $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git   $ZSH_CUSTOM/plugins/zsh-history-substring-search
```

The `git` and `kubectl` plugins ship with Oh My Zsh — no action needed.

### 5. A Nerd Font

Powerlevel10k needs one (`.p10k.zsh` was generated with the `nerdfont-v3`
wizard option). Currently installed: **FiraMono Nerd Font**. Install the font,
then set it as the iTerm2 profile font and import the Nord theme linked above.

### 6. `~/.config` must exist

```bash
mkdir -p ~/.config
```

`dev-env` does `cp -r ./nvim $XDG_CONFIG_HOME` with no `mkdir` first.

## After `./dev-env --real` and `./dev-run --real`

These are still manual — `dev-env` only deploys `env/.config/*` plus `.zshrc`,
`.p10k.zsh` and `.tmux.conf`.

- **Git config** — copy it into place yourself:
  ```bash
  cp gitconfig/.gitconfig      ~/.gitconfig
  cp gitconfig/.gitconfig-work ~/.gitconfig-work
  ```
  `~/.gitconfig` includes `~/.gitconfig-work` for `~/codebase/forto/`, so both
  files are needed.
- **GitHub CLI** — `gh.sh` and `forto-cli.sh` sit at the repo root, *outside*
  `run/`, so `dev-run` never executes them. Run them by hand. `gh` is also
  required by `.gitconfig`'s credential helper, so follow with `gh auth login`.
- **Intelephense licence** — `env/intelephense/licence.txt` is not deployed:
  ```bash
  mkdir -p ~/intelephense && cp env/intelephense/licence.txt ~/intelephense/
  ```
- **Neovim first launch** — opening `nvim` clones lazy.nvim and builds plugins
  (needs network + git). Install `yarn` *before* the first launch;
  markdown-preview runs `yarn install` at build time.
- **pyright** — configured in `lua/tomaspavlatka/plugins/mason.lua` but never
  installed by anything. Run `:MasonInstall pyright` in Neovim (needs Python).
  The TypeScript server is covered by `run/typescript.sh`.
- **macOS privacy approvals** — Karabiner-Elements needs Input Monitoring and
  its driver extension approved; MonitorControl needs Accessibility.

## Optional

`.zshrc` picks these up if present, and silently skips them if not — none are
installed by this repo:

- nvm (`~/.nvm`)
- Google Cloud SDK (`~/codebase/google-cloud-sdk`)
