#!/bin/sh

# nvm - Node Version Manager.
#
# Installed with the official install script rather than Homebrew: upstream
# explicitly does not support the brew formula, and the official installer puts
# nvm.sh in $NVM_DIR (~/.nvm), which is the path env/.zshrc already sources.
#
# PROFILE=/dev/null stops the installer from appending its own lines to ~/.zshrc -
# the nvm hook is tracked in env/.zshrc and deployed by dev-env.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

# Track nvm's latest release so a re-run upgrades the way the brew scripts do,
# with a known tag as the fallback when the GitHub API is unreachable.
NVM_VERSION="$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')"
if [ -z "$NVM_VERSION" ]; then
  NVM_VERSION="v0.40.7"
  echo "could not reach the GitHub API. Falling back to nvm $NVM_VERSION..."
fi

if [ -s "$NVM_DIR/nvm.sh" ]; then
  echo "nvm is already installed. Attempting to update to $NVM_VERSION..."
else
  echo "nvm is not installed. Installing $NVM_VERSION..."
fi

# The installer refuses an $NVM_DIR that does not exist unless it is the directory
# it would have picked itself - and with XDG_CONFIG_HOME set (env/.zshrc line 9)
# that default is ~/.config/nvm, not ~/.nvm - so create it first.
mkdir -p "$NVM_DIR"

# Re-running the installer is idempotent: it clones into $NVM_DIR when missing and
# fetches + checks out the requested tag when it is already there.
curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | PROFILE=/dev/null bash

# nvm only ships the manager - point out when there is no node under it yet, since
# until then `node` still resolves to the Homebrew one.
if [ ! -d "$NVM_DIR/versions/node" ]; then
  echo "no node installed under nvm yet - run 'nvm install --lts' in a new shell."
fi
