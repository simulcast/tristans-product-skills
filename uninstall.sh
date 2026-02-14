#!/usr/bin/env bash
set -euo pipefail

# uninstall.sh — Remove product skills installed by this repo
#
# Only removes symlinks pointing back to this repo (safe).
# Restores .backup files if they exist.

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_DIR="$HOME/.claude/commands"
CONVENTIONS_TARGET="$HOME/.claude/product-skill-conventions.md"

removed=0
restored=0

safe_remove() {
  local target="$1"
  local name
  name="$(basename "$target")"

  if [[ -L "$target" ]]; then
    local link_target
    link_target="$(readlink "$target")"
    # Only remove if it points back to our repo
    if [[ "$link_target" == "$REPO_DIR"* ]]; then
      rm "$target"
      echo "  Removed: $name"
      removed=$((removed + 1))

      # Restore backup if one exists (use the most recent)
      local latest_backup
      latest_backup="$(ls -t "${target}.backup."* 2>/dev/null | head -1 || true)"
      if [[ -n "$latest_backup" ]]; then
        mv "$latest_backup" "$target"
        echo "  Restored: $name (from backup)"
        restored=$((restored + 1))
      fi
    else
      echo "  Skipped: $name (points elsewhere)"
    fi
  elif [[ -f "$target" ]]; then
    echo "  Skipped: $name (not a symlink — may be a --copy install or unrelated file)"
  fi
}

echo "Uninstalling product skills..."
echo ""

# Remove skill files
echo "Skills:"
for skill in "$REPO_DIR"/skills/*.md; do
  name="$(basename "$skill")"
  safe_remove "$COMMANDS_DIR/$name"
done

# Remove conventions file
echo ""
echo "Conventions:"
safe_remove "$CONVENTIONS_TARGET"

echo ""
echo "Done! Removed $removed items, restored $restored backups."
