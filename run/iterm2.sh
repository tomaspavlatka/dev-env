#!/bin/sh

# iTerm2 - macOS terminal emulator; replacement for Terminal.app.
if brew list --cask | grep -q "^iterm2$"; then
  echo "iterm2 is already installed. Attempting to update..."
  brew upgrade --cask iterm2
else
  echo "iterm2 is not installed. Installing..."
  brew install --cask iterm2
fi
