#!/bin/sh

# Podman - daemonless container engine; needs `podman machine init && podman machine start` once.
if brew list --formula | grep -q "^podman$"; then
  echo "podman is already installed. Attempting to update..."
  brew upgrade podman
else
  echo "podman is not installed. Installing..."
  brew install podman
fi
