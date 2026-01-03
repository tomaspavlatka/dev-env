#!/bin/sh

if brew list --formula | grep -q "^neomutt$"; then
  echo "neomutt is already installed. Attempting to update..."
  brew upgrade neomutt
else
  echo "neomutt is not installed. Installing..."
  brew install neomutt
fi
