#!/bin/sh

# corepack - the shim that runs whatever package manager a project pins in its
# package.json "packageManager" field (yarn 4, pnpm, ...), instead of whatever
# happens to be on $PATH.
#
# corepack ships inside every node that nvm installs, but its shims are linked per
# node version, so a fresh `nvm install` starts without them. This enables it for
# every version under $NVM_DIR. Homebrew's node does not ship corepack at all - that
# is the one nvm calls `system`, and a project pinning yarn 4 needs an nvm node.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [ ! -d "$NVM_DIR/versions/node" ]; then
  echo "no nvm-managed node found. Skipping corepack (run 'nvm install' first)."
  exit 0
fi

for node_bin in "$NVM_DIR"/versions/node/*/bin; do
  [ -x "$node_bin/corepack" ] || continue

  node_version="$(basename "$(dirname "$node_bin")")"
  if [ -e "$node_bin/yarn" ]; then
    echo "corepack is already enabled for node $node_version. Re-linking shims..."
  else
    echo "corepack is not enabled for node $node_version. Enabling..."
  fi

  # Run corepack through its own node, and let it drop the shims next to itself.
  PATH="$node_bin:$PATH" "$node_bin/corepack" enable
done
