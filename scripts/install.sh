#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="${SOURCE:-"$repo_root/skills"}"
codex_home="${CODEX_HOME:-"$HOME/.codex"}"
destination="${DESTINATION:-"$codex_home/skills"}"

if [[ ! -d "$source_dir" ]]; then
  echo "Skills source not found: $source_dir" >&2
  exit 1
fi

mkdir -p "$destination"

for skill_dir in "$source_dir"/*; do
  [[ -d "$skill_dir" ]] || continue
  name="$(basename "$skill_dir")"
  rm -rf "$destination/$name"
  cp -R "$skill_dir" "$destination/$name"
  echo "Installed $name -> $destination/$name"
done

echo
echo "Done. Restart Codex or reload skills if needed."
