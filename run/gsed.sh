#!/bin/sh

if brew list --formula | grep -q "^gsed$"; then
  echo "gsed is already installed. Attempting to update..."
  brew upgrade gsed
else
  echo "gsed is not installed. Installing..."
  brew install gsed
fi
