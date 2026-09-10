#!/bin/sh

if brew list --cask | grep -q "^monitorcontrol$"; then
  echo "monitorcontrol is already installed. Attempting to update..."
  brew upgrade --cask monitorcontrol
else
  echo "monitorcontrol is not installed. Installing..."
  brew install --cask monitorcontrol
fi
