#!/bin/sh

# Insomnia - GUI client for testing REST/GraphQL/gRPC APIs (Postman alternative).
if brew list --cask | grep -q "^insomnia$"; then
  echo "insomnia is already installed. Attempting to update..."
  brew upgrade --cask insomnia
else
  echo "insomnia is not installed. Installing..."
  brew install --cask insomnia
fi
