#!/bin/bash
# count-words.sh - Counts words in SKILL.md body (excluding frontmatter)
#
# Usage: ./count-words.sh <path-to-skill>
#
# Outputs:
# - Word count of SKILL.md body
# - Assessment against target ranges
#
# Target ranges:
# - Ideal: 1,500-2,000 words
# - Acceptable: 2,000-3,000 words
# - Too long: > 3,000 words

set -e

SKILL_PATH="${1:-.}"
SKILL_FILE="$SKILL_PATH/SKILL.md"

echo "Counting words in: $SKILL_FILE"
echo "----------------------------------------"

# Check SKILL.md exists
if [ ! -f "$SKILL_FILE" ]; then
    echo "❌ ERROR: SKILL.md not found at $SKILL_FILE"
    exit 1
fi

# Extract body (everything after second ---)
WORD_COUNT=$(awk '/^---$/,/^---$/{if (++count==2) next} count>=2' "$SKILL_FILE" | wc -w)

echo "Word count: $WORD_COUNT words"
echo ""

# Assessment
if [ "$WORD_COUNT" -ge 1500 ] && [ "$WORD_COUNT" -le 2000 ]; then
    echo "✅ IDEAL: Word count is in the ideal range (1,500-2,000 words)"
    echo "   This is the sweet spot for skill length."
    exit 0
elif [ "$WORD_COUNT" -lt 1500 ]; then
    echo "⚠️  SHORT: Word count is below ideal range (< 1,500 words)"
    echo "   Consider adding more detail or examples."
    echo "   However, if the skill is simple, this may be appropriate."
    exit 0
elif [ "$WORD_COUNT" -le 3000 ]; then
    echo "⚠️  ACCEPTABLE: Word count is in acceptable range (2,000-3,000 words)"
    echo "   Consider moving some content to references/ to improve progressive disclosure."
    exit 0
else
    echo "❌ TOO LONG: Word count exceeds recommended maximum (> 3,000 words)"
    echo "   Strongly recommend moving detailed content to references/:"
    echo "   - Detailed patterns → references/patterns.md"
    echo "   - Advanced techniques → references/advanced.md"
    echo "   - API documentation → references/api-reference.md"
    echo "   - Common mistakes → references/common-mistakes.md"
    exit 1
fi
