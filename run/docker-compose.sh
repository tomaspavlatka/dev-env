#!/bin/sh

# Docker Compose - compose CLI; Tilt's docker_compose() and `podman compose` call it.
if brew list --formula | grep -q "^docker-compose$"; then
  echo "docker-compose is already installed. Attempting to update..."
  brew upgrade docker-compose
else
  echo "docker-compose is not installed. Installing..."
  brew install docker-compose
fi
