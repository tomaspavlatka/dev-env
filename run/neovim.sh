#!/bin/sh

if brew list --formula | grep -q "^neovim$"; then
  echo "neovim is already installed. Attempting to update..."
  brew upgrade neovim
else
  echo "neovim is not installed. Installing..."
  brew install neovim
fi
