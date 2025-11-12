#!/bin/sh

if brew list --formula | grep -q "^font-fire-code$"; then
  echo "font-fire-code is already installed. Attempting to update..."
  brew upgrade font-fire-code
else
  echo "font-fire-code is not installed. Installing..."
  brew install --cask font-fire-code
fi
