#!/bin/sh

if brew list --formula | grep -q "^tmux$"; then
  echo "tmux is already installed. Attempting to update..."
  brew upgrade tmux
else
  echo "tmux is not installed. Installing..."
  brew install tmux
fi
