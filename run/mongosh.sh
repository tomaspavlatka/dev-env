#!/bin/sh

# mongosh - the MongoDB shell; CLI for querying/administering MongoDB.
if brew list --formula | grep -q "^mongosh$"; then
  echo "mongosh is already installed. Attempting to update..."
  brew upgrade mongosh
else
  echo "mongosh is not installed. Installing..."
  brew install mongosh
fi
