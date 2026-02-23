#!/bin/sh

if brew list --formula | grep -q "^pyenv$"; then
  echo "pyenv is already installed. Attempting to update..."
  brew upgrade pyenv
else
  echo "pyenv is not installed. Installing..."
  brew install pyenv
fi
