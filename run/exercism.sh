#!/bin/sh

if brew list --formula | grep -q "^exercism$"; then
  echo "exercism is already installed. Attempting to update..."
  brew upgrade exercism
else
  echo "exercism is not installed. Installing..."
  brew install exercism
fi
