#!/bin/bash
# validate-skill.sh - Validates skill structure and frontmatter
#
# Usage: ./validate-skill.sh <path-to-skill>
#
# Checks:
# - SKILL.md file exists
# - YAML frontmatter is present and valid
# - Required fields (name, description) exist
# - Description uses third person
# - Description includes trigger phrases
# - Referenced files exist
#
# Exit codes:
# 0 - All validations passed
# 1 - Validation failed

set -e

SKILL_PATH="${1:-.}"
SKILL_FILE="$SKILL_PATH/SKILL.md"
ERRORS=0

echo "Validating skill at: $SKILL_PATH"
echo "----------------------------------------"

# Check SKILL.md exists
if [ ! -f "$SKILL_FILE" ]; then
    echo "❌ ERROR: SKILL.md not found at $SKILL_FILE"
    exit 1
fi
echo "✅ SKILL.md exists"

# Extract frontmatter (between first and second ---)
FRONTMATTER=$(sed -n '/^---$/,/^---$/p' "$SKILL_FILE" | sed '1d;$d')

if [ -z "$FRONTMATTER" ]; then
    echo "❌ ERROR: No YAML frontmatter found"
    exit 1
fi
echo "✅ YAML frontmatter present"

# Check for required fields
if ! echo "$FRONTMATTER" | grep -q "^name:"; then
    echo "❌ ERROR: Missing 'name' field in frontmatter"
    ERRORS=$((ERRORS + 1))
else
    NAME=$(echo "$FRONTMATTER" | grep "^name:" | sed 's/^name: *//')
    echo "✅ 'name' field present: $NAME"
fi

if ! echo "$FRONTMATTER" | grep -q "^description:"; then
    echo "❌ ERROR: Missing 'description' field in frontmatter"
    ERRORS=$((ERRORS + 1))
else
    DESCRIPTION=$(echo "$FRONTMATTER" | grep "^description:" | sed 's/^description: *//')
    echo "✅ 'description' field present"
    
    # Check if description uses third person
    if echo "$DESCRIPTION" | grep -qi "This skill should be used when"; then
        echo "✅ Description uses third person format"
    else
        echo "⚠️  WARNING: Description should start with 'This skill should be used when...'"
        ERRORS=$((ERRORS + 1))
    fi
    
    # Check if description includes quoted trigger phrases
    if echo "$DESCRIPTION" | grep -q '"[^"]*"'; then
        echo "✅ Description includes quoted trigger phrases"
    else
        echo "⚠️  WARNING: Description should include specific trigger phrases in quotes"
        ERRORS=$((ERRORS + 1))
    fi
fi

# Check for version field (optional but recommended)
if echo "$FRONTMATTER" | grep -q "^version:"; then
    VERSION=$(echo "$FRONTMATTER" | grep "^version:" | sed 's/^version: *//')
    echo "✅ 'version' field present: $VERSION"
fi

# Check if body exists (content after frontmatter)
BODY_LINES=$(sed -n '/^---$/,/^---$/!p' "$SKILL_FILE" | sed '/^---$/d' | wc -l)
if [ "$BODY_LINES" -lt 10 ]; then
    echo "❌ ERROR: SKILL.md body is too short (< 10 lines)"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ SKILL.md body present ($BODY_LINES lines)"
fi

# Check for referenced files in SKILL.md
echo ""
echo "Checking referenced files..."

# Find references to files (looking for patterns like `references/file.md` or `examples/file.sh`)
REFERENCES=$(grep -oE '`(references|examples|scripts)/[^`]+`' "$SKILL_FILE" | tr -d '`' | sort -u)

if [ -n "$REFERENCES" ]; then
    while IFS= read -r ref; do
        REF_PATH="$SKILL_PATH/$ref"
        if [ -f "$REF_PATH" ]; then
            echo "✅ Referenced file exists: $ref"
        else
            echo "⚠️  WARNING: Referenced file not found: $ref"
            ERRORS=$((ERRORS + 1))
        fi
    done <<< "$REFERENCES"
else
    echo "ℹ️  No file references found in SKILL.md"
fi

# Summary
echo ""
echo "----------------------------------------"
if [ $ERRORS -eq 0 ]; then
    echo "✅ All validations passed!"
    exit 0
else
    echo "❌ Validation failed with $ERRORS error(s)"
    exit 1
fi
