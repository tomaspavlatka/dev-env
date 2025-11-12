#!/bin/sh

if brew list --formula | grep -q "^fzf$"; then
  echo "fzf is already installed. Attempting to update..."
  brew upgrade fzf
else
  echo "fzf is not installed. Installing..."
  brew install fzf
fi
