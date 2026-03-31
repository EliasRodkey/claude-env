#!/bin/bash
set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    SKILLS_DIR="$HOME/.claude/skills"
    mkdir -p "$SKILLS_DIR"
    echo "=== Syncing custom skills ==="
    for SKILL in ./skills/*/; do
        ln -sf "$PWD/$SKILL" "$SKILLS_DIR/$(basename $SKILL)"
    done
    
else
    SKILLS_DIR="$USERPROFILE/.claude/skills"
    mkdir -p "$SKILLS_DIR"
    echo "=== Syncing custom skills ==="
    cp -r ./skills/* "$SKILLS_DIR"
fi


echo "=== Cloning/updating skills from Anthropic ==="

# Anthropic official skills — sparse checkout
ANTHROPIC_SKILLS=(
    "skill-creator"
    "frontend-design"
)

REPO="https://github.com/anthropics/skills.git"

for SKILL in "${ANTHROPIC_SKILLS[@]}"; do
  SKILL_DIR="$SKILLS_DIR/$SKILL"
  if [ -d "$SKILL_DIR/.git" ]; then
    echo "Updating $SKILL..."
    git -C "$SKILL_DIR" pull
  else
    echo "Cloning $SKILL..."
    git clone --depth 1 --filter=blob:none --sparse \
      "$REPO" "$SKILL_DIR"
    git -C "$SKILL_DIR" sparse-checkout set "$SKILL"
  fi
done

echo "=== Cloning/updating skills from Matt Pocock Official ==="

# Matt Pocock skills — sparse checkout
MATT_POCOCK_SKILLS=(
    "grill-me"
    "improve-codebase-architecture"
    "tdd"
    "write-a-prd"
)

REPO="https://github.com/mattpocock/skills.git"

for SKILL in "${MATT_POCOCK_SKILLS[@]}"; do
  SKILL_DIR="$SKILLS_DIR/$SKILL"
  if [ -d "$SKILL_DIR/.git" ]; then
    echo "Updating $SKILL..."
    git -C "$SKILL_DIR" pull
  else
    echo "Cloning $SKILL..."
    git clone --depth 1 --filter=blob:none --sparse \
      "$REPO" "$SKILL_DIR"
    git -C "$SKILL_DIR" sparse-checkout set "$SKILL"
  fi
done

echo "=== Done ==="