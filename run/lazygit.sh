#!/bin/sh

if brew list --formula | grep -q "^lazygit$"; then
  echo "lazygit is already installed. Attempting to update..."
  brew upgrade lazygit
else
  echo "lazygit is not installed. Installing..."
  brew install lazygit
fi
