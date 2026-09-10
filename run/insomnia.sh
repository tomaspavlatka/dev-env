#!/bin/sh

if brew list --formula | grep -q "^insomnia$"; then
  echo "insomnia is already installed. Attempting to update..."
  brew upgrade --cask insomnia
else
  echo "insomnia is not installed. Installing..."
  brew install --cask insomnia
fi
