#!/bin/sh

if brew list --formula | grep -q "^obsidian$"; then
  echo "obsidian is already installed. Attempting to update..."
  brew upgrade --cask obsidian
else
  echo "obsidian is not installed. Installing..."
  brew install --cask obsidian
fi
