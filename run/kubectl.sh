#!/bin/sh

if brew list --formula | grep -q "^kubectl$"; then
  echo "kubectl is already installed. Attempting to update..."
  brew upgrade kubectl
else
  echo "kubectl is not installed. Installing..."
  brew install kubectl
fi
