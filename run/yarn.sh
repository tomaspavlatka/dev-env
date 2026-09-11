#!/bin/sh

# Yarn - Node.js package manager (npm alternative).
if brew list --formula | grep -q "^yarn$"; then
  echo "yarn is already installed. Attempting to update..."
  brew upgrade yarn
else
  echo "yarn is not installed. Installing..."
  brew install yarn
fi
