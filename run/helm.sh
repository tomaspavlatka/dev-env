#!/bin/sh

# Helm - package manager for Kubernetes; installs/upgrades apps via charts.
if brew list --formula | grep -q "^helm$"; then
  echo "helm is already installed. Attempting to update..."
  brew upgrade helm
else
  echo "helm is not installed. Installing..."
  brew install helm
fi
