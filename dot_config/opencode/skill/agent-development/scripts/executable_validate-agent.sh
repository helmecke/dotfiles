#!/bin/bash
# OpenCode Agent File Validator
# Validates agent markdown files for correct OpenCode structure and content

set -euo pipefail

# Usage
if [ $# -eq 0 ]; then
  echo "Usage: $0 <path/to/agent.md>"
  echo ""
  echo "Validates OpenCode agent file for:"
  echo "  - YAML frontmatter structure"
  echo "  - Required fields (description)"
  echo "  - OpenCode-specific format (no 'name' or 'color' fields)"
  echo "  - Optional fields (mode, model, temperature, tools, permission)"
  echo "  - System prompt presence and length"
  echo "  - Filename format (lowercase, hyphens)"
  exit 1
fi

AGENT_FILE="$1"

echo "🔍 Validating OpenCode agent file: $AGENT_FILE"
echo ""

# Check 1: File exists
if [ ! -f "$AGENT_FILE" ]; then
  echo "❌ File not found: $AGENT_FILE"
  exit 1
fi
echo "✅ File exists"

# Check 2: Filename format
FILENAME=$(basename "$AGENT_FILE" .md)
if ! [[ "$FILENAME" =~ ^[a-z0-9][a-z0-9-]*[a-z0-9]$ ]]; then
  echo "❌ Filename must be lowercase with hyphens only: $FILENAME"
  exit 1
fi
echo "✅ Filename format valid: $FILENAME"

# Check 3: Starts with ---
FIRST_LINE=$(head -1 "$AGENT_FILE")
if [ "$FIRST_LINE" != "---" ]; then
  echo "❌ File must start with YAML frontmatter (---)"
  exit 1
fi
echo "✅ Starts with frontmatter"

# Check 4: Has closing ---
if ! tail -n +2 "$AGENT_FILE" | grep -q '^---$'; then
  echo "❌ Frontmatter not closed (missing second ---)"
  exit 1
fi
echo "✅ Frontmatter properly closed"

# Extract frontmatter and system prompt
FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$AGENT_FILE")
SYSTEM_PROMPT=$(awk '/^---$/{i++; next} i>=2' "$AGENT_FILE")

# Check 5: OpenCode format compliance
echo ""
echo "Checking OpenCode compliance..."

error_count=0
warning_count=0

# Check for INVALID fields (from Claude Code)
if echo "$FRONTMATTER" | grep -q '^name:'; then
  echo "❌ 'name' field should not exist in OpenCode (filename becomes agent ID)"
  ((error_count++))
fi

if echo "$FRONTMATTER" | grep -q '^color:'; then
  echo "❌ 'color' field does not exist in OpenCode"
  ((error_count++))
fi

# Check for array-style tools (Claude Code format)
if echo "$FRONTMATTER" | grep -q 'tools: \['; then
  echo "❌ 'tools' should be object format {tool: true/false}, not array"
  ((error_count++))
fi

# Check for old model format
if echo "$FRONTMATTER" | grep -qE '^model: (inherit|sonnet|opus|haiku)$'; then
  echo "❌ 'model' should use provider/model-id format (e.g., anthropic/claude-sonnet-4-20250514)"
  ((error_count++))
fi

echo ""
echo "Checking required fields..."

# Check description field (REQUIRED)
DESCRIPTION=$(echo "$FRONTMATTER" | grep '^description:' | sed 's/description: *//' | sed 's/^"\(.*\)"$/\1/')

if [ -z "$DESCRIPTION" ]; then
  echo "❌ Missing required field: description"
  ((error_count++))
else
  echo "✅ description: ${DESCRIPTION:0:80}..."
  
  # Validate description length
  desc_length=${#DESCRIPTION}
  if [ $desc_length -lt 10 ]; then
    echo "⚠️  description is quite short (${desc_length} chars, recommend 50-500)"
    ((warning_count++))
  elif [ $desc_length -gt 1000 ]; then
    echo "⚠️  description is very long (${desc_length} chars, recommend <500)"
    ((warning_count++))
  fi
fi

echo ""
echo "Checking optional fields..."

# Check mode field
MODE=$(echo "$FRONTMATTER" | grep '^mode:' | sed 's/mode: *//')
if [ -n "$MODE" ]; then
  echo "✅ mode: $MODE"
  if ! [[ "$MODE" =~ ^(primary|subagent|all)$ ]]; then
    echo "❌ mode must be 'primary', 'subagent', or 'all'"
    ((error_count++))
  fi
else
  echo "ℹ️  mode not specified (defaults to 'all')"
fi

# Check model field
MODEL=$(echo "$FRONTMATTER" | grep '^model:' | sed 's/model: *//')
if [ -n "$MODEL" ]; then
  echo "✅ model: $MODEL"
  if ! [[ "$MODEL" =~ ^[a-z0-9]+\/[a-z0-9.-]+$ ]]; then
    echo "❌ model should use provider/model-id format (e.g., anthropic/claude-sonnet-4-20250514)"
    ((error_count++))
  fi
else
  echo "ℹ️  model not specified (will inherit from global config or parent agent)"
fi

# Check temperature field
TEMPERATURE=$(echo "$FRONTMATTER" | grep '^temperature:' | sed 's/temperature: *//')
if [ -n "$TEMPERATURE" ]; then
  echo "✅ temperature: $TEMPERATURE"
  if ! [[ "$TEMPERATURE" =~ ^[0-9]+\.?[0-9]*$ ]]; then
    echo "❌ temperature must be a number between 0.0 and 1.0"
    ((error_count++))
  fi
else
  echo "ℹ️  temperature not specified (will use model default)"
fi

# Check maxSteps field
MAX_STEPS=$(echo "$FRONTMATTER" | grep '^maxSteps:' | sed 's/maxSteps: *//')
if [ -n "$MAX_STEPS" ]; then
  echo "✅ maxSteps: $MAX_STEPS"
  if ! [[ "$MAX_STEPS" =~ ^[0-9]+$ ]]; then
    echo "❌ maxSteps must be a positive integer"
    ((error_count++))
  fi
else
  echo "ℹ️  maxSteps not specified (unlimited iterations)"
fi

# Check tools field (should be object format)
if echo "$FRONTMATTER" | grep -q '^tools:'; then
  echo "✅ tools configured"
  # Check if it's object format (has indented lines after "tools:")
  if ! echo "$FRONTMATTER" | awk '/^tools:/{getline; if ($0 ~ /^  [a-z]+:/) print "object"}' | grep -q "object"; then
    echo "⚠️  tools format unclear - should be object with boolean values"
    ((warning_count++))
  fi
else
  echo "ℹ️  tools not specified (all globally configured tools available)"
fi

# Check permission field
if echo "$FRONTMATTER" | grep -q '^permission:'; then
  echo "✅ permission configured"
else
  echo "ℹ️  permission not specified (uses global permission settings)"
fi

# Check 6: System prompt validation
echo ""
echo "Checking system prompt..."

if [ -z "$SYSTEM_PROMPT" ]; then
  echo "❌ Missing system prompt (body after frontmatter)"
  ((error_count++))
else
  prompt_length=${#SYSTEM_PROMPT}
  if [ $prompt_length -lt 20 ]; then
    echo "❌ System prompt too short ($prompt_length chars, minimum 20)"
    ((error_count++))
  elif [ $prompt_length -lt 500 ]; then
    echo "⚠️  System prompt is quite brief ($prompt_length chars, recommend 500-3000)"
    ((warning_count++))
  elif [ $prompt_length -gt 10000 ]; then
    echo "⚠️  System prompt is very long ($prompt_length chars, consider being more concise)"
    ((warning_count++))
  else
    echo "✅ System prompt length: $prompt_length chars"
  fi
  
  # Check if written in second person
  if echo "$SYSTEM_PROMPT" | head -20 | grep -qi "You are"; then
    echo "✅ System prompt uses second person ('You are...')"
  else
    echo "⚠️  System prompt should address agent in second person ('You are...')"
    ((warning_count++))
  fi
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $error_count -eq 0 ]; then
  echo "✅ Validation passed!"
  if [ $warning_count -gt 0 ]; then
    echo "⚠️  $warning_count warning(s) found"
  fi
  exit 0
else
  echo "❌ Validation failed with $error_count error(s)"
  if [ $warning_count -gt 0 ]; then
    echo "⚠️  $warning_count warning(s) found"
  fi
  exit 1
fi
