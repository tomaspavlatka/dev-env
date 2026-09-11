#!/bin/sh

# Obsidian - local Markdown note-taking app with backlinks/graph view.
if brew list --cask | grep -q "^obsidian$"; then
  echo "obsidian is already installed. Attempting to update..."
  brew upgrade --cask obsidian
else
  echo "obsidian is not installed. Installing..."
  brew install --cask obsidian
fi
