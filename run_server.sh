#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "$0")" && pwd)"
mise_bin="$repo_dir/.tools/mise"

if [[ ! -x "$mise_bin" ]]; then
  if command -v mise >/dev/null 2>&1; then
    mise_bin="$(command -v mise)"
  else
    echo "mise is required. Install it from https://mise.jdx.dev/getting-started/" >&2
    exit 1
  fi
fi

"$mise_bin" install
"$mise_bin" exec -- bundle check >/dev/null 2>&1 || "$mise_bin" run setup
exec "$mise_bin" run serve
