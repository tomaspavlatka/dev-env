#!/bin/sh

if brew list --formula | grep -q "^gh$"; then
  echo "gh is already installed. Attempting to update..."
  brew upgrade gh
else
  echo "gh is not installed. Installing..."
  brew install gh
fi
