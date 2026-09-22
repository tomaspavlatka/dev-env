#!/bin/sh

# kubectx - interactive fzf pickers for Kubernetes contexts (kubectx) and namespaces (kubens).
# Replaces the blendle/blendle ktx+kns pair; that tap has been unmaintained since 2021 and
# Homebrew 7 refuses to load formulae from untrusted taps. Aliases ktx/kns live in env/.zshrc.
if brew list --formula | grep -q "^kubectx$"; then
  echo "kubectx is already installed. Attempting to update..."
  brew upgrade kubectx
else
  echo "kubectx is not installed. Installing..."
  brew install kubectx
fi
