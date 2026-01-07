#!/bin/sh

brew tap blendle/blendle
if brew list --formula | grep -q "^kns$"; then
  echo "kns is already installed. Attempting to update..."
  brew upgrade kns
else
  echo "kns is not installed. Installing..."
  brew install kns
fi
