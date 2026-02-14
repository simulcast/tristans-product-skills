#!/usr/bin/env bash
set -euo pipefail

# install.sh — Install product skills for Claude Code
#
# Usage:
#   ./install.sh          # Symlink skills (recommended)
#   ./install.sh --copy   # Copy files instead of symlinking

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_DIR="$HOME/.claude/commands"
CONVENTIONS_TARGET="$HOME/.claude/product-skill-conventions.md"
MODE="symlink"

if [[ "${1:-}" == "--copy" ]]; then
  MODE="copy"
fi

# Ensure target directory exists
mkdir -p "$COMMANDS_DIR"

backup_if_exists() {
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    local backup="${target}.backup.$(date +%s)"
    echo "  Backing up existing file: $target → $backup"
    mv "$target" "$backup"
  elif [[ -L "$target" ]]; then
    # Remove existing symlink (safe to overwrite)
    rm "$target"
  fi
}

install_file() {
  local source="$1"
  local target="$2"
  local name
  name="$(basename "$target")"

  backup_if_exists "$target"

  if [[ "$MODE" == "copy" ]]; then
    cp "$source" "$target"
    echo "  Copied: $name"
  else
    ln -s "$source" "$target"
    echo "  Linked: $name"
  fi
}

echo "Installing product skills for Claude Code..."
echo "Mode: $MODE"
echo ""

# Install skill files
echo "Skills:"
for skill in "$REPO_DIR"/skills/*.md; do
  name="$(basename "$skill")"
  install_file "$skill" "$COMMANDS_DIR/$name"
done

# Install conventions file
echo ""
echo "Conventions:"
install_file "$REPO_DIR/docs/conventions.md" "$CONVENTIONS_TARGET"

echo ""
echo "Done! Installed $(ls "$REPO_DIR"/skills/*.md | wc -l | tr -d ' ') skills."
echo ""
echo "Try it: open Claude Code and run /product-discovery"
