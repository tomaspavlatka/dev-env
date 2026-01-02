#!/bin/sh

if brew list --formula | grep -q "^zsh$"; then
  echo "zsh is already installed. Attempting to update..."
  brew upgrade zsh
else
  echo "zsh is not installed. Installing..."
  brew install zsh
fi
