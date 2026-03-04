#!/bin/sh

if brew list --formula | grep -q "^nushell$"; then
  echo "nushell is already installed. Attempting to update..."
  brew upgrade nushell
else
  echo "nushell is not installed. Installing..."
  brew install nushell
fi
