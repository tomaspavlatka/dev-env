#!/bin/sh

if brew list --formula | grep -q "^iterm2$"; then
  echo "iterm2 is already installed. Attempting to update..."
  brew upgrade iterm2
else
  echo "iterm2 is not installed. Installing..."
  brew install --cask iterm2
fi
