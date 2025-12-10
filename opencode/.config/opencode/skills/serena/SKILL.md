---
name: serena
description: |
  ALWAYS ACTIVE: Serena MCP provides semantic code understanding and intelligent editing via Language Server Protocol.
  This skill applies to ALL coding tasks. Use Serena tools for: (1) navigating codebases, (2) finding symbols and references,
  (3) editing code at symbol level, (4) refactoring, (5) understanding project structure. Serena dramatically improves
  code quality and reduces token usage compared to text-based operations. Activate for any code-related work.
---

# Serena MCP Integration

Serena provides IDE-like semantic code understanding through Language Server Protocol integration. Use Serena tools instead of grep/read operations whenever possible.

## Core Principle

**Prefer semantic operations over text-based operations:**

| Instead of... | Use Serena... |
|---------------|---------------|
| Grep for function name | `find_symbol` |
| Read entire file | `get_symbols_overview` + targeted reads |
| String replace across files | `rename_symbol` |
| Manual line counting for edits | `insert_after_symbol` / `replace_symbol_body` |

## Required Setup

Before using Serena tools, ensure the project is activated:

1. **Check if onboarding was performed**: Use `check_onboarding_performed`
2. **If not**: Run `onboarding` to analyze project structure
3. **Activate project**: Use `activate_project` with project path

## Tool Categories

### Symbol Navigation (Primary Tools)

Use these for understanding code:

| Tool | Purpose | When to Use |
|------|---------|-------------|
| `find_symbol` | Locate symbols by name/substring | Finding classes, functions, variables |
| `find_referencing_symbols` | Find all usages of a symbol | Understanding impact before changes |
| `get_symbols_overview` | List top-level symbols in a file | Quick file structure understanding |

### Symbol-Level Editing (Preferred for Modifications)

Use these instead of line-based edits:

| Tool | Purpose | When to Use |
|------|---------|-------------|
| `insert_before_symbol` | Add code before a symbol | Adding imports, decorators |
| `insert_after_symbol` | Add code after a symbol | Adding related methods/functions |
| `replace_symbol_body` | Replace entire symbol definition | Rewriting functions/classes |
| `rename_symbol` | Rename across codebase | Refactoring with LSP support |

### File Operations (Fallback)

Use when symbol-level operations aren't applicable:

| Tool | Purpose |
|------|---------|
| `read_file` | Read file contents |
| `create_text_file` | Create or overwrite files |
| `list_dir` | Browse directory structure |
| `find_file` | Locate files by path |
| `delete_lines` / `insert_at_line` / `replace_lines` | Line-based edits |

### Project Management

| Tool | Purpose |
|------|---------|
| `activate_project` | Switch active project context |
| `onboarding` | Analyze project structure, find build/test commands |
| `get_current_config` | Show active configuration |
| `restart_language_server` | Reinitialize after external changes |

### Memory System

Persist information across conversations:

| Tool | Purpose |
|------|---------|
| `write_memory` | Store project-specific notes |
| `read_memory` | Retrieve stored information |
| `list_memories` | Show all stored memories |
| `edit_memory` | Update existing memory content |
| `delete_memory` | Remove obsolete memories |

**For detailed guidance on memory lifecycle management, see the `serena-memory-management` skill.**

This covers:
- When and how to create memories
- Memory content best practices
- Organizing and maintaining memories across sessions
- Anti-patterns to avoid

## Workflow Patterns

### Understanding a Codebase

```
1. activate_project → Ensure project is active
2. onboarding → Get project overview, build/test commands
3. get_symbols_overview → Understand file structures
4. find_symbol → Locate specific entities
5. find_referencing_symbols → Trace dependencies
```

### Implementing a Feature

```
1. find_symbol → Locate where to add code
2. get_symbols_overview → Understand surrounding context
3. insert_after_symbol → Add new code semantically
4. find_referencing_symbols → Verify no breaking changes
```

### Refactoring

```
1. find_symbol → Locate target symbol
2. find_referencing_symbols → Understand all usages
3. rename_symbol → Rename with LSP support (handles all references)
   OR
3. replace_symbol_body → Rewrite implementation
```

### Debugging

```
1. find_symbol → Locate problematic function/class
2. find_referencing_symbols → Trace call chain
3. read_file → Read specific sections for context
4. replace_symbol_body → Fix the issue
```

## Best Practices

### DO

- Start with `onboarding` for new projects
- Use `find_symbol` before `read_file` for targeted navigation
- Prefer `replace_symbol_body` over line-based replacements
- Use `rename_symbol` for refactoring (handles all references automatically)
- Store important findings with `write_memory` for future reference

### DON'T

- Read entire large files when you only need specific symbols
- Use grep-style searches when `find_symbol` would work
- Make line-based edits when symbol-based edits are possible
- Forget to `restart_language_server` after external file changes

## Language Support

Serena supports 30+ languages via Language Server Protocol:

- C#, C/C++, Java, Kotlin, Go, Rust
- JavaScript, TypeScript, Python, Ruby, PHP
- Elixir, Erlang, Haskell, Scala, Clojure
- And many more

## Cognitive Tools

Use these for complex tasks:

| Tool | Purpose |
|------|---------|
| `think_about_collected_information` | Verify you have enough context |
| `think_about_task_adherence` | Check you're still on track |
| `think_about_whether_you_are_done` | Assess task completion |

## Token Efficiency

Serena significantly reduces token usage by:

- Providing symbol-level navigation instead of full file reads
- Enabling precise edits without context overhead
- Offering structured code understanding

For large codebases, always prefer Serena's semantic tools over text-based alternatives.
