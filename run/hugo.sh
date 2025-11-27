#!/bin/sh

if brew list --formula | grep -q "^hugo$"; then
  echo "hugo is already installed. Attempting to update..."
  brew upgrade hugo
else
  echo "hugo is not installed. Installing..."
  brew install hugo
fi
