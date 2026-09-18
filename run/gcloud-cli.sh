#!/bin/sh

# Google Cloud CLI - gcloud/bq/gsutil. Needed to authenticate against Forto's
# Artifact Registry npm feed: the yarn plugin-gcp-auth in user-service shells out
# to gcloud for a token, so `yarn install` fails there without it.
#
# The cask used to be called google-cloud-sdk; it is gcloud-cli now, and it
# auto-updates itself, so `brew upgrade` is mostly a no-op.
if brew list --cask | grep -q "^gcloud-cli$"; then
  echo "gcloud-cli is already installed. Attempting to update..."
  brew upgrade --cask gcloud-cli
else
  echo "gcloud-cli is not installed. Installing..."
  brew install --cask gcloud-cli
fi
