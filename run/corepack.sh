#!/bin/sh

# corepack - the shim that runs whatever package manager a project pins in its
# package.json "packageManager" field (yarn 4, pnpm, ...), instead of whatever
# happens to be on $PATH.
#
# corepack ships inside node up to 24, but its shims are linked per node version, so
# a fresh `nvm install` starts without them. Node 25+ no longer bundles corepack, so
# for those it is installed into that version with its own npm first. This enables it
# for every version under $NVM_DIR. Homebrew's node does not ship corepack at all - that
# is the one nvm calls `system`, and a project pinning yarn 4 needs an nvm node.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [ ! -d "$NVM_DIR/versions/node" ]; then
  echo "no nvm-managed node found. Skipping corepack (run 'nvm install' first)."
  exit 0
fi

# A Homebrew yarn lands in /opt/homebrew/bin and wins over these shims in any
# shell that has not loaded nvm, where it then refuses a pinned packageManager.
# There is deliberately no run/yarn.sh; this catches a manual `brew install yarn`.
if brew list --formula 2>/dev/null | grep -qx yarn; then
  echo "WARNING: Homebrew yarn is installed and shadows corepack. Remove it with"
  echo "         ./dev-remove yarn --real"
fi

for node_bin in "$NVM_DIR"/versions/node/*/bin; do
  node_version="$(basename "$(dirname "$node_bin")")"

  # Checked before the install below: the corepack npm package ships its own yarn bin.
  if [ -e "$node_bin/yarn" ]; then
    echo "corepack is already enabled for node $node_version. Re-linking shims..."
  else
    echo "corepack is not enabled for node $node_version. Enabling..."
  fi

  if [ ! -x "$node_bin/corepack" ]; then
    echo "corepack is not bundled with node $node_version. Installing..."
    # npm -g installs into the running node's own prefix, so corepack lands in $node_bin.
    PATH="$node_bin:$PATH" "$node_bin/npm" install -g corepack@latest || continue
  fi

  # Run corepack through its own node, and let it drop the shims next to itself.
  PATH="$node_bin:$PATH" "$node_bin/corepack" enable
done
