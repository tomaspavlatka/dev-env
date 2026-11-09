#!/bin/sh

# Tilt - runs a multi-service dev stack from a Tiltfile with live reload.
if brew list --formula | grep -q "^tilt$"; then
  echo "tilt is already installed. Attempting to update..."
  brew upgrade tilt
else
  echo "tilt is not installed. Installing..."
  brew install tilt
fi
