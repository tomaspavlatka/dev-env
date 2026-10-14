#!/bin/sh

# GitHub CLI extensions.
#
# Not a Homebrew package. `gh extension install` clones into
# ~/.local/share/gh/extensions, which dev-env does not deploy, so this script
# is the record.
if ! command -v gh >/dev/null 2>&1; then
  echo "gh is not on PATH. Run run/gh.sh first, then re-run this."
  exit 0
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "gh is not logged in. Run \`gh auth login\`, then re-run this."
  exit 0
fi

# github-owner/gh-<name>
EXTENSIONS="
github/gh-stack
"

echo "$EXTENSIONS" | while read -r repo; do
  [ -z "$repo" ] && continue
  if gh extension list | grep -q "$repo"; then
    echo "$repo is already installed. Attempting to update..."
    gh extension upgrade "${repo#*/gh-}"
  else
    echo "$repo is not installed. Installing..."
    gh extension install "$repo"
  fi
done
