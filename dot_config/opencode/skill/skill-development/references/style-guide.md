# Writing Style Guide for Skills

This reference provides comprehensive guidance on writing style requirements for skill documentation.

## Core Principle

Write skills using **imperative/infinitive form** (verb-first instructions), not second person. Use objective, instructional language that maintains consistency and clarity for AI consumption.

## Imperative/Infinitive Form

Write using verb-first instructions, not second person.

### Correct (imperative):
```
To create a hook, define the event type.
Configure the MCP server with authentication.
Validate settings before use.
Parse the frontmatter using sed.
Extract fields with grep.
```

### Incorrect (second person):
```
You should create a hook by defining the event type.
You need to configure the MCP server.
You must validate settings before use.
You can parse the frontmatter...
Claude should extract fields...
```

## Third-Person in Description

The frontmatter description must use third person to describe when the skill should be used.

### Correct:
```yaml
description: This skill should be used when the user asks to "create X", "configure Y", or "validate Z". Provides comprehensive guidance for task completion.
```

### Incorrect:
```yaml
description: Use this skill when you want to create X...
description: Load this skill when user asks...
description: You should use this when...
```

## Objective, Instructional Language

Focus on what to do, not who should do it.

### Correct:
```
Parse the frontmatter using sed.
Extract fields with grep.
Validate values before use.
Run the validation script to check structure.
Create the directory structure first.
```

### Incorrect:
```
You can parse the frontmatter...
Claude should extract fields...
The user might validate values...
You'll want to run the validation script...
Users should create the directory...
```

## Structure of Instructions

### Good Pattern: Action-Oriented

```markdown
## Creating a Hook

To create a hook:

1. Define the event type (PreToolUse, PostToolUse, Stop)
2. Specify the action (modify, validate, log)
3. Implement the handler logic
4. Test with the validation script

Validate the hook configuration before use.
```

### Bad Pattern: Descriptive/Passive

```markdown
## Creating a Hook

When you create a hook, you should define the event type. You can choose from PreToolUse, PostToolUse, or Stop. Then you need to specify what action you want. After that, you'll implement the handler logic. Finally, you should test it.

You can validate the hook configuration if you want.
```

## Examples Section Format

### Correct Format:
```markdown
## Examples

### Basic Hook Example

Define a PreToolUse hook:

```json
{
  "event": "PreToolUse",
  "action": "validate"
}
```

Validate the configuration:

```bash
./scripts/validate-hook.sh hooks.json
```
```

### Incorrect Format:
```markdown
## Examples

### Basic Hook Example

You would define a PreToolUse hook like this:

```json
{
  "event": "PreToolUse",
  "action": "validate"
}
```

Then you can validate it by running:

```bash
./scripts/validate-hook.sh hooks.json
```
```

## Common Phrases to Avoid

| Avoid | Use Instead |
|-------|-------------|
| You should... | [Action verb]... |
| You need to... | [Action verb]... |
| You can... | [Action verb]... |
| You must... | [Action verb]... |
| You'll want to... | [Action verb]... |
| Users should... | [Action verb]... |
| Claude should... | [Action verb]... |
| It's recommended that you... | [Action verb]... |

## Common Phrases to Use

| Pattern | Example |
|---------|---------|
| To [accomplish X], [do Y] | To create a hook, define the event type |
| [Action verb] [object] | Validate the configuration |
| [Action verb] before/after [context] | Test the hook before deployment |
| When [condition], [action] | When validation fails, check the logs |
| For [purpose], [action] | For debugging, enable verbose logging |

## Description Writing

### Formula for Good Descriptions

```yaml
description: This skill should be used when the user asks to "[trigger 1]", "[trigger 2]", "[trigger 3]", or [general pattern]. [One sentence about what it provides].
```

### Examples of Good Descriptions

```yaml
description: This skill should be used when the user asks to "create a hook", "add a PreToolUse hook", "validate tool use", or mentions hook events (PreToolUse, PostToolUse, Stop). Provides comprehensive hooks API guidance.
```

```yaml
description: This skill should be used when the user asks to "debug a test failure", "trace root cause", "find the breaking commit", or "identify what changed". Provides systematic debugging methodology.
```

```yaml
description: This skill should be used when the user asks to "create an agent", "write agent frontmatter", "define agent triggers", or needs guidance on agent structure and best practices. Covers agent development for Claude Code plugins.
```

### Examples of Bad Descriptions

```yaml
description: Use this skill for hooks.
# Problems: Not third person, no specific triggers, too vague
```

```yaml
description: You should load this when working with agents.
# Problems: Second person, no specific triggers, unclear
```

```yaml
description: Provides guidance.
# Problems: No triggers at all, too generic
```

## Section Headers

### Correct (Noun Phrases or Gerunds):
```markdown
## Creating a Hook
## Hook Validation
## Configuration Options
## Testing Strategies
## Common Patterns
```

### Incorrect (Second Person):
```markdown
## How You Create a Hook
## What You Need to Know
## Things You Should Validate
```

## Checklist Format

### Correct (Imperative):
```markdown
## Validation Checklist

- [ ] Validate YAML frontmatter format
- [ ] Check required fields exist
- [ ] Verify file references
- [ ] Test with validation script
```

### Incorrect (Second Person):
```markdown
## Validation Checklist

- [ ] You should validate YAML frontmatter
- [ ] You need to check required fields
- [ ] You must verify file references
- [ ] You can test with validation script
```

## Quick Reference

**Always:**
- Use imperative/infinitive form (verb-first)
- Use third person in description
- Focus on actions, not actors
- Be direct and concise

**Never:**
- Use second person (you/your)
- Use "should/need/can/must" with "you"
- Make it about who does it
- Be passive or descriptive

**Test your writing:**
- Can you remove "you" and still make sense? Good.
- Does it start with an action verb? Good.
- Does it tell Claude what to do? Good.
- Does it describe who should do it? Bad.
