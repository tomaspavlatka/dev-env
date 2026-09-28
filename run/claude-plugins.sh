#!/bin/sh

# Claude Code plugins - marketplaces and the plugins installed from them.
#
# Not a Homebrew package. `claude plugin marketplace add` only registers the
# catalogue; the plugin itself still has to be installed, and both facts live
# in ~/.claude/settings.json, which dev-env does not deploy (it holds auth and
# per-project state). So this script is the record.
if ! command -v claude >/dev/null 2>&1; then
  echo "claude is not on PATH. Run run/claude-code.sh first, then re-run this."
  exit 0
fi

# marketplace-name github-owner/repo
MARKETPLACES="
mattpocock mattpocock/skills
"

# plugin@marketplace
PLUGINS="
mattpocock-skills@mattpocock
typescript-lsp@claude-plugins-official
"

echo "$MARKETPLACES" | while read -r name repo; do
  [ -z "$name" ] && continue
  if claude plugin marketplace list | grep -q "^  ❯ $name$"; then
    echo "marketplace $name is already added. Attempting to update..."
    claude plugin marketplace update "$name"
  else
    echo "marketplace $name is not added. Adding..."
    claude plugin marketplace add "$repo"
  fi
done

echo "$PLUGINS" | while read -r plugin; do
  [ -z "$plugin" ] && continue
  if claude plugin list | grep -q "^  ❯ $plugin$"; then
    echo "$plugin is already installed. Attempting to update..."
    claude plugin update "$plugin"
  else
    echo "$plugin is not installed. Installing..."
    claude plugin install "$plugin"
  fi
done
