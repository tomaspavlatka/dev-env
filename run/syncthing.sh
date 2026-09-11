#!/bin/sh

# Syncthing - peer-to-peer file sync between your own devices (no cloud).
if brew list --formula | grep -q "^syncthing$"; then
  echo "syncthing is already installed. Attempting to update..."
  brew upgrade syncthing
else
  echo "syncthing is not installed. Installing..."
  brew install syncthing
fi
