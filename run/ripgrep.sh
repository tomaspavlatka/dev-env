#!/bin/sh

if brew list --formula | grep -q "^ripgrep$"; then
  echo "ripgrep is already installed. Attempting to update..."
  brew upgrade ripgrep
else
  echo "ripgrep is not installed. Installing..."
  brew install ripgrep
fi
