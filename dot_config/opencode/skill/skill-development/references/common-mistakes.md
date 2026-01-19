# Common Mistakes to Avoid

This reference provides detailed examples of common mistakes when creating skills, with before/after comparisons to illustrate best practices.

## Mistake 1: Weak Trigger Description

❌ **Bad:**
```yaml
description: Provides guidance for working with hooks.
```

**Why bad:** Vague, no specific trigger phrases, not third person

✅ **Good:**
```yaml
description: This skill should be used when the user asks to "create a hook", "add a PreToolUse hook", "validate tool use", or mentions hook events. Provides comprehensive hooks API guidance.
```

**Why good:** Third person, specific phrases, concrete scenarios

## Mistake 2: Too Much in SKILL.md

❌ **Bad:**
```
skill-name/
└── SKILL.md  (8,000 words - everything in one file)
```

**Why bad:** Bloats context when skill loads, detailed content always loaded

✅ **Good:**
```
skill-name/
├── SKILL.md  (1,800 words - core essentials)
└── references/
    ├── patterns.md (2,500 words)
    └── advanced.md (3,700 words)
```

**Why good:** Progressive disclosure, detailed content loaded only when needed

## Mistake 3: Second Person Writing

❌ **Bad:**
```markdown
You should start by reading the configuration file.
You need to validate the input.
You can use the grep tool to search.
```

**Why bad:** Second person, not imperative form

✅ **Good:**
```markdown
Start by reading the configuration file.
Validate the input before processing.
Use the grep tool to search for patterns.
```

**Why good:** Imperative form, direct instructions

## Mistake 4: Missing Resource References

❌ **Bad:**
```markdown
# SKILL.md

[Core content]

[No mention of references/ or examples/]
```

**Why bad:** Claude doesn't know references exist

✅ **Good:**
```markdown
# SKILL.md

[Core content]

## Additional Resources

### Reference Files
- **`references/patterns.md`** - Detailed patterns
- **`references/advanced.md`** - Advanced techniques

### Examples
- **`examples/script.sh`** - Working example
```

**Why good:** Claude knows where to find additional information

## Additional Common Mistakes

### Mistake 5: Generic Trigger Phrases

❌ **Bad:**
```yaml
description: This skill helps with development tasks.
```

**Why bad:** Too generic, no specific user queries

✅ **Good:**
```yaml
description: This skill should be used when the user asks to "debug a test failure", "trace root cause", "find the breaking commit", or "identify what changed".
```

**Why good:** Specific phrases users would actually say

### Mistake 6: Missing Examples

❌ **Bad:**
```
skill-name/
├── SKILL.md
└── references/
    └── patterns.md
```

**Why bad:** Users must construct examples from descriptions

✅ **Good:**
```
skill-name/
├── SKILL.md
├── references/
│   └── patterns.md
└── examples/
    ├── basic-example.sh
    └── advanced-example.sh
```

**Why good:** Users can copy and adapt working examples

### Mistake 7: Undocumented Scripts

❌ **Bad:**
```bash
#!/bin/bash
# validate.sh
grep -q "name:" SKILL.md
```

**Why bad:** No usage information, unclear what it validates

✅ **Good:**
```bash
#!/bin/bash
# validate.sh - Validates skill structure and frontmatter
#
# Usage: ./validate.sh <path-to-skill>
# Checks: YAML frontmatter, required fields, file structure

grep -q "name:" "$1/SKILL.md" || echo "Missing name field"
```

**Why good:** Clear purpose, usage instructions, documented checks

### Mistake 8: Duplicated Content

❌ **Bad:**
```
SKILL.md contains full API documentation (3,000 words)
references/api.md contains same API documentation (3,000 words)
```

**Why bad:** Wastes context, creates maintenance burden

✅ **Good:**
```
SKILL.md contains API overview (300 words) + pointer to references/
references/api.md contains full API documentation (3,000 words)
```

**Why good:** Progressive disclosure, single source of truth

## Summary

**Key principles to avoid mistakes:**
- Use third person with specific trigger phrases in description
- Keep SKILL.md lean, move details to references/
- Write in imperative/infinitive form, never second person
- Reference all bundled resources explicitly
- Provide working examples users can copy
- Document scripts with usage information
- Avoid duplicating content across files
