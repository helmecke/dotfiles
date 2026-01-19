# Plugin Skill Examples

This reference provides detailed analysis of exemplary skills from the plugin-dev ecosystem, demonstrating best practices in action.

## Overview

Study these skills as templates for creating effective plugin skills. Each demonstrates key principles: strong trigger phrases, progressive disclosure, lean SKILL.md, and comprehensive bundled resources.

## hook-development Skill

**Location:** `plugin-dev/skills/hook-development/`

**Word Count:** 1,651 words (SKILL.md body)

### Strengths

**Excellent trigger phrases:**
```yaml
description: This skill should be used when the user asks to "create a hook", "add a PreToolUse hook", "validate tool use", "implement prompt-based hooks", or mentions hook events (PreToolUse, PostToolUse, Stop).
```

**Progressive disclosure:**
- Lean SKILL.md focuses on core concepts and workflows
- 3 reference files for detailed content:
  - `references/patterns.md` - Common hook patterns
  - `references/advanced.md` - Advanced techniques
  - `references/api-reference.md` - Complete API documentation

**Working examples:**
- `examples/basic-validation.json` - Simple hook
- `examples/prompt-based-hook.json` - Advanced hook
- `examples/multi-hook.json` - Complex configuration

**Utility scripts:**
- `scripts/validate-hook-schema.sh` - Schema validation
- `scripts/test-hook.sh` - Hook testing
- `scripts/parse-hook-config.sh` - Configuration parsing

### Key Lessons

1. **Specific triggers work:** "create a hook", "add a PreToolUse hook" are phrases users actually say
2. **References keep SKILL.md lean:** Detailed API docs don't bloat the core file
3. **Examples are complete:** Users can copy and adapt working configurations
4. **Scripts provide tools:** Validation and testing utilities reduce repeated work

## agent-development Skill

**Location:** `plugin-dev/skills/agent-development/`

**Word Count:** 1,438 words (SKILL.md body)

### Strengths

**Strong trigger phrases:**
```yaml
description: This skill should be used when the user asks to "create an agent", "write agent frontmatter", "define agent triggers", "implement agent logic", or needs guidance on agent structure and best practices.
```

**Focused SKILL.md:**
- Core concepts and essential workflow only
- Pointers to references for details
- Quick reference table for common tasks

**Comprehensive references:**
- `references/agent-creation-system-prompt.md` - The actual AI generation prompt from Claude Code
- `references/system-prompt-design.md` - Principles for writing agent prompts
- `references/triggering-examples.md` - Real-world trigger patterns

**Complete examples:**
- `examples/agent-creation-prompt.md` - How to ask for agent creation
- `examples/complete-agent-examples.md` - Multiple working agents

**Validation script:**
- `scripts/validate-agent.sh` - Checks frontmatter and structure

### Key Lessons

1. **Include AI-generated content:** The system prompt reference is invaluable
2. **Show real examples:** Complete agent examples demonstrate patterns
3. **Validation matters:** Script catches common mistakes early
4. **Focused scope:** SKILL.md covers essentials, references handle depth

## plugin-settings Skill

**Location:** `plugin-dev/skills/plugin-settings/`

**Word Count:** 1,523 words (SKILL.md body)

### Strengths

**Specific triggers:**
```yaml
description: This skill should be used when the user asks about "plugin settings", ".local.md files", "YAML frontmatter", "configuration options", or needs to understand how plugins store and access settings.
```

**Real-world references:**
- `references/multi-agent-swarm-settings.md` - Complete implementation from real plugin
- `references/ralph-wiggum-settings.md` - Another real implementation
- `references/settings-patterns.md` - Common patterns extracted from real plugins

**Working parsing scripts:**
- `scripts/parse-settings.sh` - Extract settings from .local.md
- `scripts/validate-settings.sh` - Validate YAML frontmatter
- `scripts/generate-settings-template.sh` - Create boilerplate

**Complete examples:**
- `examples/basic-settings.md` - Simple .local.md
- `examples/advanced-settings.md` - Complex configuration
- `examples/settings-access.js` - How to read settings in code

### Key Lessons

1. **Show real implementations:** Actual plugin examples are more valuable than hypotheticals
2. **Provide utilities:** Parsing and validation scripts save time
3. **Multiple examples:** Basic and advanced examples cover different needs
4. **Cross-reference:** Settings skill references other plugin components

## command-development Skill

**Location:** `plugin-dev/skills/command-development/`

**Word Count:** 1,789 words (SKILL.md body)

### Strengths

**Clear triggers:**
```yaml
description: This skill should be used when the user asks to "create a command", "add a slash command", "implement command logic", or needs guidance on command structure and best practices.
```

**Critical concepts first:**
- SKILL.md focuses on essential command structure
- Frontmatter requirements clearly explained
- Core patterns with minimal examples

**Detailed references:**
- `references/frontmatter-reference.md` - Complete field documentation
- `references/interactive-commands.md` - Advanced interaction patterns
- `references/plugin-features-reference.md` - Integration with plugin features
- `references/marketplace-considerations.md` - Publishing guidance

**Practical examples:**
- `examples/simple-commands.md` - Basic command patterns
- `examples/plugin-commands.md` - Commands using plugin features

### Key Lessons

1. **Separate concerns:** Core concepts in SKILL.md, details in references
2. **Progressive complexity:** Simple examples first, advanced patterns in references
3. **Complete coverage:** From basics to marketplace publishing
4. **Clear structure:** Frontmatter reference is comprehensive but separate

## mcp-integration Skill

**Location:** `plugin-dev/skills/mcp-integration/`

**Word Count:** 1,612 words (SKILL.md body)

### Strengths

**Specific integration triggers:**
```yaml
description: This skill should be used when the user asks to "integrate MCP server", "connect to MCP", "configure MCP authentication", or needs guidance on Model Context Protocol integration.
```

**Comprehensive references:**
- `references/mcp-protocol-spec.md` - Complete protocol documentation
- `references/authentication-patterns.md` - Security best practices
- `references/error-handling.md` - Common issues and solutions
- `references/server-implementations.md` - Real MCP server examples

**Working examples:**
- `examples/basic-mcp-config.json` - Simple configuration
- `examples/authenticated-mcp.json` - With authentication
- `examples/multi-server-config.json` - Multiple servers

**Testing scripts:**
- `scripts/test-mcp-connection.sh` - Connection testing
- `scripts/validate-mcp-config.sh` - Configuration validation

### Key Lessons

1. **External protocols need references:** Full spec too large for SKILL.md
2. **Security patterns matter:** Authentication reference is essential
3. **Error handling reference:** Common issues documented separately
4. **Test utilities crucial:** Connection testing catches problems early

## Common Patterns Across Exemplary Skills

### Pattern 1: Strong Trigger Descriptions

All exemplary skills use this formula:
```yaml
description: This skill should be used when the user asks to "[action 1]", "[action 2]", "[action 3]", or [general pattern]. [Brief capability statement].
```

### Pattern 2: Lean SKILL.md (1,400-1,800 words)

All keep core file focused:
- Essential concepts only
- Quick reference tables
- Pointers to references
- Most common use cases

### Pattern 3: Comprehensive References

All move details to references/:
- Complete API documentation
- Advanced techniques
- Real-world examples
- Troubleshooting guides

### Pattern 4: Working Examples

All provide complete, runnable examples:
- Basic examples for common cases
- Advanced examples for complex scenarios
- Real-world examples from actual plugins

### Pattern 5: Utility Scripts

All include helpful automation:
- Validation scripts
- Testing utilities
- Parsing tools
- Generation helpers

## Anti-Patterns to Avoid

### Anti-Pattern 1: Generic Triggers

❌ **Bad:**
```yaml
description: Helps with plugin development.
```

✅ **Good:**
```yaml
description: This skill should be used when the user asks to "create a hook", "add a PreToolUse hook", "validate tool use".
```

### Anti-Pattern 2: Everything in SKILL.md

❌ **Bad:**
```
skill-name/
└── SKILL.md (5,000 words - everything included)
```

✅ **Good:**
```
skill-name/
├── SKILL.md (1,600 words - essentials)
└── references/
    ├── api-reference.md
    └── advanced.md
```

### Anti-Pattern 3: Incomplete Examples

❌ **Bad:**
```json
// Example (incomplete)
{
  "event": "PreToolUse"
  // ... rest of config
}
```

✅ **Good:**
```json
// Complete working example
{
  "event": "PreToolUse",
  "action": "validate",
  "handler": "./handlers/validate.js",
  "config": {
    "strict": true
  }
}
```

### Anti-Pattern 4: No Validation Tools

❌ **Bad:**
```
skill-name/
├── SKILL.md
└── examples/
```

✅ **Good:**
```
skill-name/
├── SKILL.md
├── examples/
└── scripts/
    └── validate.sh
```

## Summary

**Study these skills as templates:**
- hook-development - Progressive disclosure mastery
- agent-development - AI-assisted creation patterns
- plugin-settings - Real-world implementation examples
- command-development - Clear critical concepts separation
- mcp-integration - External protocol integration

**Apply these patterns:**
- Strong, specific trigger phrases
- Lean SKILL.md (1,400-1,800 words)
- Comprehensive references for details
- Complete, working examples
- Utility scripts for automation

**Avoid these anti-patterns:**
- Generic trigger descriptions
- Bloated SKILL.md files
- Incomplete examples
- Missing validation tools
