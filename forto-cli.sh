#!/bin/sh

brew tap freight-hub/internal
if brew list --formula | grep -q "^forto-cli$"; then
  echo "forto-cli is already installed. Attempting to update..."
  brew upgrade forto-cli
else
  echo "forto-cli is not installed. Installing..."
  brew install forto-cli
fi
