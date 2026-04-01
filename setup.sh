#!/bin/bash
set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    SKILLS_DIR="$HOME/.claude/skills"
else
    SKILLS_DIR="$USERPROFILE/.claude/skills"
fi

mkdir -p "$SKILLS_DIR"
echo "=== Syncing custom skills ==="
cp -r ./skills/* "$SKILLS_DIR"

echo "=== Cloning/updating skills from Anthropic ==="

# Anthropic official skills — sparse checkout
ANTHROPIC_SKILLS=(
    "skill-creator"
    "frontend-design"
)

REPO="https://github.com/anthropics/skills.git"

for SKILL in "${ANTHROPIC_SKILLS[@]}"; do
  SKILL_DIR="$SKILLS_DIR/$SKILL"
  if [ -d "$SKILL_DIR/SKILL.md" ] || [ -f "$SKILL_DIR/SKILL.md" ]; then
    echo "Updating $SKILL..."
    # pull logic here
  else
    echo "Cloning $SKILL..."
    TEMP_DIR=$(mktemp -d)
    git clone --depth 1 "$REPO" "$TEMP_DIR"
    ls $TEMP_DIR
    mv "$TEMP_DIR/skills/$SKILL" "$SKILL_DIR"
    rm -rf "$TEMP_DIR"
  fi
done

echo "=== Cloning/updating skills from Matt Pocock Official ==="

# Matt Pocock skills — sparse checkout
MATT_POCOCK_SKILLS=(
    "grill-me"
    "improve-codebase-architecture"
    "tdd"
    "write-a-prd"
    "prd-to-plan"
)

REPO="https://github.com/mattpocock/skills.git"

for SKILL in "${MATT_POCOCK_SKILLS[@]}"; do
  SKILL_DIR="$SKILLS_DIR/$SKILL"
  if [ -d "$SKILL_DIR/SKILL.md" ] || [ -f "$SKILL_DIR/SKILL.md" ]; then
    echo "Updating $SKILL..."
    # pull logic here
  else
    echo "Cloning $SKILL..."
    TEMP_DIR=$(mktemp -d)
    git clone --depth 1 "$REPO" "$TEMP_DIR"
    mv "$TEMP_DIR/$SKILL" "$SKILL_DIR"
    rm -rf "$TEMP_DIR"
  fi
done

echo "=== Done ==="