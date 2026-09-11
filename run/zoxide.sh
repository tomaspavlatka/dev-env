#!/bin/sh

# zoxide - smarter cd; jumps to frequently used directories by fuzzy name.
if brew list --formula | grep -q "^zoxide$"; then
  echo "zoxide is already installed. Attempting to update..."
  brew upgrade zoxide
else
  echo "zoxide is not installed. Installing..."
  brew install zoxide
fi
