#!/bin/sh

if brew list --formula | grep -q "^helm$"; then
  echo "helm is already installed. Attempting to update..."
  brew upgrade helm
else
  echo "helm is not installed. Installing..."
  brew install helm
fi
