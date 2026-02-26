#!/bin/sh

if brew list --formula | grep -q "^claude-code$"; then
  echo "claude-code is already installed. Attempting to update..."
  brew upgrade --cask claude-code
else
  echo "claude-code is not installed. Installing..."
  brew install --cask claude-code
fi
