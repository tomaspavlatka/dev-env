#!/bin/sh

if brew list --formula | grep -q "^saml2aws$"; then
  echo "saml2aws is already installed. Attempting to update..."
  brew upgrade saml2aws
else
  echo "saml2aws is not installed. Installing..."
  brew install saml2aws
fi
