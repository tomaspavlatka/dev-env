#!/bin/sh

# Maccy - lightweight clipboard history manager for macOS.
if brew list --cask | grep -q "^maccy$"; then
  echo "maccy is already installed. Attempting to update..."
  brew upgrade --cask maccy
else
  echo "maccy is not installed. Installing..."
  brew install --cask maccy
fi
