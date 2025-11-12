#!/bin/sh

if brew list --formula | grep -q "^zoxide$"; then
  echo "zoxide is already installed. Attempting to update..."
  brew upgrade zoxide
else
  echo "zoxide is not installed. Installing..."
  brew install zoxide
fi
