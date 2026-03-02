#!/bin/sh

if brew list --formula | grep -q "^maccy$"; then
  echo "maccy is already installed. Attempting to update..."
  brew upgrade maccy
else
  echo "maccy is not installed. Installing..."
  brew install maccy
fi
