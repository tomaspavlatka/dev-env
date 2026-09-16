#!/bin/sh

# tfenv - Terraform version manager, and the way terraform itself gets installed.
# Terraform left homebrew-core after the BUSL relicense, and HashiCorp's own tap
# (hashicorp/tap) fails to load under Homebrew 7, so there is no `brew install
# terraform`. tfenv pulls the official binaries from releases.hashicorp.com and
# respects a project's .terraform-version file.
if brew list --formula | grep -q "^tfenv$"; then
  echo "tfenv is already installed. Attempting to update..."
  brew upgrade tfenv
else
  echo "tfenv is not installed. Installing..."
  brew install tfenv
fi

# tfenv only ships the manager - make sure an actual terraform is present.
if tfenv version-name >/dev/null 2>&1; then
  echo "terraform $(tfenv version-name) is active. Checking for a newer release..."
else
  echo "no terraform version active. Installing latest..."
fi

tfenv install latest
tfenv use latest
