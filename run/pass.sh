#!/bin/sh

if brew list --formula | grep -q "^pass$"; then
  echo "pass is already installed. Attempting to update..."
  brew upgrade pass
else
  echo "pass is not installed. Installing..."
  brew install pass
fi
