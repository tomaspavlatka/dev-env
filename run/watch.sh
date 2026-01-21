#!/bin/sh

if brew list --formula | grep -q "^watch$"; then
  echo "watch is already installed. Attempting to update..."
  brew upgrade watch
else
  echo "watch is not installed. Installing..."
  brew install watch
fi
