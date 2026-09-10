#!/bin/sh

if brew list --cask | grep -q "^karabiner-elements$"; then
  echo "karabiner-elements is already installed. Attempting to update..."
  brew upgrade --cask karabiner-elements
else
  echo "karabiner-elements is not installed. Installing..."
  brew install --cask karabiner-elements
fi
