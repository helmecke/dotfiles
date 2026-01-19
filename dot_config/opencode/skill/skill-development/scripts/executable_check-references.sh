#!/bin/bash
# check-references.sh - Verifies that all referenced files exist
#
# Usage: ./check-references.sh <path-to-skill>
#
# Checks:
# - Files mentioned in SKILL.md exist
# - Directories mentioned exist
# - No broken references
#
# Exit codes:
# 0 - All references valid
# 1 - Broken references found

set -e

SKILL_PATH="${1:-.}"
SKILL_FILE="$SKILL_PATH/SKILL.md"
ERRORS=0

echo "Checking file references in: $SKILL_FILE"
echo "----------------------------------------"

# Check SKILL.md exists
if [ ! -f "$SKILL_FILE" ]; then
    echo "❌ ERROR: SKILL.md not found at $SKILL_FILE"
    exit 1
fi

# Find all references to files in backticks
# Patterns: `references/file.md`, `examples/file.sh`, `scripts/file.py`
echo "Checking file references..."
REFERENCES=$(grep -oE '`(references|examples|scripts|assets)/[^`]+`' "$SKILL_FILE" | tr -d '`' | sort -u)

if [ -z "$REFERENCES" ]; then
    echo "ℹ️  No file references found in SKILL.md"
    echo "   This is fine for minimal skills, but consider adding:"
    echo "   - references/ for detailed documentation"
    echo "   - examples/ for working code examples"
    echo "   - scripts/ for utility tools"
    exit 0
fi

echo ""
while IFS= read -r ref; do
    REF_PATH="$SKILL_PATH/$ref"
    if [ -f "$REF_PATH" ]; then
        echo "✅ $ref"
    elif [ -d "$REF_PATH" ]; then
        echo "✅ $ref (directory)"
    else
        echo "❌ $ref (NOT FOUND)"
        ERRORS=$((ERRORS + 1))
    fi
done <<< "$REFERENCES"

# Check for common directories
echo ""
echo "Checking common directories..."

for dir in "references" "examples" "scripts" "assets"; do
    DIR_PATH="$SKILL_PATH/$dir"
    if [ -d "$DIR_PATH" ]; then
        FILE_COUNT=$(find "$DIR_PATH" -type f | wc -l)
        echo "✅ $dir/ exists ($FILE_COUNT files)"
    fi
done

# Summary
echo ""
echo "----------------------------------------"
if [ $ERRORS -eq 0 ]; then
    echo "✅ All references are valid!"
    exit 0
else
    echo "❌ Found $ERRORS broken reference(s)"
    echo ""
    echo "To fix:"
    echo "1. Create the missing files"
    echo "2. Remove references to non-existent files"
    echo "3. Check for typos in file paths"
    exit 1
fi
