#!/bin/sh

# Forto CLI - from the private freight-hub/internal tap.
#
# `brew tap` clones the tap over HTTPS with gh as the git credential helper
# (see gitconfig/.gitconfig), so it fails until gh is installed and logged in.
if ! command -v gh >/dev/null 2>&1; then
  echo "gh is not on PATH. Run run/gh.sh first, then re-run this."
  exit 0
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "gh is not logged in. Run \`gh auth login\`, then re-run this."
  exit 0
fi

brew tap freight-hub/internal || exit 1
if brew list --formula | grep -q "^forto-cli$"; then
  echo "forto-cli is already installed. Attempting to update..."
  brew upgrade forto-cli
else
  echo "forto-cli is not installed. Installing..."
  brew install forto-cli
fi
