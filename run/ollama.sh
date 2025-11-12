#!/bin/sh

if brew list --formula | grep -q "^ollama$"; then
  echo "ollama is already installed. Attempting to update..."
  brew upgrade ollama
else
  echo "ollama is not installed. Installing..."
  brew install ollama
fi
