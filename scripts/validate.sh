#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_dir="$repo_root/skills"
errors=()

if [[ ! -d "$skills_dir" ]]; then
  echo "Missing skills directory: $skills_dir" >&2
  exit 1
fi

for skill_dir in "$skills_dir"/*; do
  [[ -d "$skill_dir" ]] || continue
  name="$(basename "$skill_dir")"
  skill_md="$skill_dir/SKILL.md"
  openai_yaml="$skill_dir/agents/openai.yaml"

  [[ "$name" =~ ^[a-z0-9][a-z0-9-]{0,62}[a-z0-9]$ ]] || errors+=("$name: invalid skill directory name")

  if [[ ! -f "$skill_md" ]]; then
    errors+=("$name: missing SKILL.md")
    continue
  fi

  grep -Eq "^name:[[:space:]]*\"?$name\"?[[:space:]]*$" "$skill_md" || errors+=("$name: frontmatter name must match directory")
  grep -Eq "^description:[[:space:]].{40,}$" "$skill_md" || errors+=("$name: description is missing or too short")
  ! grep -Eq "\[TODO|TODO:|Structuring This Skill" "$skill_md" || errors+=("$name: template TODO text remains")
  [[ -f "$openai_yaml" ]] || errors+=("$name: missing agents/openai.yaml")
done

if (( ${#errors[@]} > 0 )); then
  printf '%s\n' "${errors[@]}" >&2
  exit 1
fi

echo "All skills passed repository validation."
