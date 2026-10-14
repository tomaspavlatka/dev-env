#!/bin/sh

# Claude Code settings - the keys this repo owns in ~/.claude/settings.json.
#
# dev-env does not deploy that file (it holds auth, plugins and per-project
# state), so this script merges only the keys below into it and leaves the
# rest alone. Empty attribution strings drop the Co-Authored-By trailer from
# commits and the "Generated with Claude Code" line from PR descriptions.
SETTINGS="$HOME/.claude/settings.json"

OWNED='{
  "attribution": {
    "commit": "",
    "pr": ""
  }
}'

mkdir -p "$(dirname "$SETTINGS")"
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"

# jq's * merges objects recursively, so a sibling key under the same parent
# that Claude Code wrote itself survives.
tmp=$(mktemp)
if jq --argjson owned "$OWNED" '. * $owned' "$SETTINGS" > "$tmp"; then
  mv "$tmp" "$SETTINGS"
  echo "merged owned keys into $SETTINGS"
else
  rm -f "$tmp"
  echo "could not parse $SETTINGS - left it unchanged."
  exit 1
fi
