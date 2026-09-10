#!/bin/sh

if brew list --formula | grep -q "^mongodb-compass$"; then
  echo "mongodb-compass is already installed. Attempting to update..."
  brew upgrade --cask mongodb-compass
else
  echo "mongodb-compass is not installed. Installing..."
  brew install --cask mongodb-compass
fi
