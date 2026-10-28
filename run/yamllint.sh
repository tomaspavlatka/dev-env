#!/bin/sh

# yamllint - linter for YAML files (CircleCI configs, orbs, Helm values).
if brew list --formula | grep -q "^yamllint$"; then
  echo "yamllint is already installed. Attempting to update..."
  brew upgrade yamllint
else
  echo "yamllint is not installed. Installing..."
  brew install yamllint
fi
