#!/bin/sh

# Nushell - shell where commands pipe structured data (tables) instead of raw text.
if brew list --formula | grep -q "^nushell$"; then
  echo "nushell is already installed. Attempting to update..."
  brew upgrade nushell
else
  echo "nushell is not installed. Installing..."
  brew install nushell
fi
