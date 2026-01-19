# Agent Triggering Patterns

+**Critical**: Before doing anything check if there is a skills for it.

Guide for when to use each agent in OpenCode. Use these patterns to understand which agent to invoke or when the model should automatically delegate.

## Pattern Format

Each agent documents:

- **keyTrigger**: One-line summary of when to fire
- **triggers**: Domain-specific activation conditions
- **useWhen**: Example user phrases that indicate this agent

---

## Primary Agents

### Build (Default)

**keyTrigger:** Any development task requiring file changes or command execution

**triggers:**
| Domain | Trigger |
|--------|---------|
| Development | Writing, editing, or creating code files |
| Operations | Running build commands, tests, scripts |
| General | Default agent when no specialized agent matches |

**useWhen:**

- "Create a new component"
- "Fix this bug"
- "Add a feature for..."
- "Run the tests"
- "Build the project"
- Any request requiring file modifications

---

### Plan

**keyTrigger:** Analysis or planning task where changes should be reviewed first

**triggers:**
| Domain | Trigger |
|--------|---------|
| Analysis | Understanding code architecture or flow |
| Planning | Designing solutions before implementation |
| Review | Evaluating approaches without modifying |

**useWhen:**

- "Analyze this codebase"
- "How should I approach..."
- "What's the best way to..."
- "Review my plan for..."
- "Help me understand how X works"
- Any request where you want suggestions without automatic changes

---

## Subagents

### General

**keyTrigger:** Complex multi-step research or uncertain search scope

**triggers:**
| Domain | Trigger |
|--------|---------|
| Research | Complex questions requiring multiple search strategies |
| Discovery | Uncertain what files/patterns to look for |
| Multi-step | Tasks requiring sequential exploration |

**useWhen:**

- "Help me understand this system"
- "Research how to implement X"
- "Find all the places that handle Y"
- "I'm not sure where to look for..."
- Complex questions where scope is unclear

---

### Explore

**keyTrigger:** Fast codebase search with known patterns or keywords

**triggers:**
| Domain | Trigger |
|--------|---------|
| File Search | Finding files by name or pattern |
| Code Search | Finding specific code patterns or keywords |
| Quick Lookup | When you know roughly what you're looking for |

**useWhen:**

- "Where is X implemented?"
- "Find files matching \*.config.ts"
- "Which files contain Y?"
- "Find the code that does Z"
- Quick searches with specific targets

---

### Research (Custom)

**keyTrigger:** External library/source mentioned → fire `research` background

**triggers:**
| Domain | Trigger |
|--------|---------|
| Library Research | Unfamiliar packages/libraries, external library behavior questions |
| Documentation | Official docs lookup, API references |
| Implementation Examples | Finding OSS implementation patterns |

**useWhen:**

- "How do I use [library]?"
- "What's the best practice for [framework feature]?"
- "Why does [external dependency] behave this way?"
- "Find examples of [library] usage"
- "Working with unfamiliar npm/pip/cargo packages"
- Looking up code in remote repositories

---

## Decision Flow

```
User Request
    │
    ├─ External library/docs needed? → research
    │
    ├─ Quick file/code search? → explore
    │
    ├─ Complex multi-step discovery? → general
    │
    ├─ Analysis without changes? → plan
    │
    └─ Development task with changes → build (default)
```

## Writing Custom Agent Triggers

When creating new agents, define:

1. **keyTrigger**: One sentence describing the primary fire condition
2. **triggers**: Table of domain → trigger condition mappings
3. **useWhen**: 5-7 example phrases users might say

These patterns help both users understand when to invoke agents and help the model automatically delegate to the right specialist.
