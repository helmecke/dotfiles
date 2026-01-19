---
name: agent-development
description: This skill should be used when the user asks to "create an agent", "add an agent", "write a subagent", "agent frontmatter", "when to use description", "agent examples", "agent tools", "agent modes", "primary agent", "autonomous agent", or needs guidance on agent structure, system prompts, triggering conditions, or agent development best practices for OpenCode.
license: MIT
compatibility: opencode
metadata:
  version: 1.0.0
  category: development
---

# Agent Development for OpenCode

## Overview

Agents are specialized AI assistants that can be configured for specific tasks and workflows. OpenCode supports two types: **primary agents** (main assistants you interact with directly) and **subagents** (specialized assistants for specific tasks).

**Key concepts:**
- **Primary agents**: Cycle through with Tab key, handle main conversation
- **Subagents**: Invoked by @ mention or automatically by primary agents
- Markdown file format with YAML frontmatter
- Description field defines when agent triggers
- System prompt defines agent behavior
- Tool and permission configuration for safety

## Agent Types

### Primary Agents

Main assistants you interact with directly during a session.

**Characteristics:**
- Cycle through with **Tab** key (or configured `switch_agent` keybind)
- Handle your main conversation
- Access all configured tools
- Can invoke subagents for specialized tasks

**Built-in primary agents:**
- **Build** - Default agent with all tools enabled
- **Plan** - Analysis agent with restricted permissions (asks before edits/bash)

**Use cases:**
- Main development workflows
- Different permission levels (unrestricted vs cautious)
- Different models (fast vs capable)

### Subagents

Specialized assistants invoked for specific tasks.

**Characteristics:**
- Invoked by **@ mention** (e.g., `@code-reviewer check this`)
- Automatically invoked by primary agents when description matches task
- Create child sessions (navigate with `<Leader>+Right/Left`)
- Typically focused on specific domains

**Built-in subagents:**
- **General** - Research complex questions, multi-step tasks
- **Explore** - Fast codebase exploration

**Use cases:**
- Code review without making changes
- Security analysis
- Documentation generation
- Test generation
- Specialized analysis tasks

### Mode Selection

**When to use each mode:**

| Mode | When to Use | Example Use Cases |
|------|-------------|-------------------|
| `primary` | Main workflow agents | Build, Plan, Debug, Write |
| `subagent` | Specialized tasks | Code review, security audit, docs |
| `all` | Flexible usage | General utilities, helpers |

## Agent File Structure

### Complete Format

```markdown
---
description: Brief description of what the agent does and when to use it
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.3
tools:
  read: true
  write: true
  grep: true
permission:
  edit: ask
  bash: deny
---

You are [agent role description]...

**Your Core Responsibilities:**
1. [Responsibility 1]
2. [Responsibility 2]

**Analysis Process:**
[Step-by-step workflow]

**Output Format:**
[What to return]
```

**Note:** The filename becomes the agent identifier (e.g., `code-reviewer.md` creates `code-reviewer` agent).

## Frontmatter Fields

### description (required)

Defines when OpenCode should trigger this agent. **This is the most critical field.**

Brief description explaining when to use the agent.

**Format:**
```yaml
description: Reviews code for best practices and potential issues
```

Or more detailed:
```yaml
description: Analyzes security vulnerabilities and identifies risks. Use when reviewing code for security concerns, authentication flaws, or data exposure issues.
```

**Best practices:**
- Keep concise and clear (1-2 sentences)
- Explain what the agent does
- Optionally mention when to use it
- Focus on capabilities, not implementation
- Length: typically 50-500 characters

### mode (optional)

Determines how the agent can be used.

**Options:**
- `primary` - Main agent, cycle with Tab key
- `subagent` - Specialized agent, invoked by @ mention or by primary agents
- `all` - Can be used either way (default if omitted)

**Example:**
```yaml
mode: subagent
```

**Recommendation:** Use `subagent` for specialized tasks, `primary` for main workflows.

### model (optional)

Specifies which LLM model the agent should use.

**Format:** `provider/model-id`

**Examples:**
```yaml
model: anthropic/claude-sonnet-4-20250514
model: anthropic/claude-haiku-4-20250514
model: openai/gpt-5
```

**Default behavior:**
- Primary agents: Use globally configured model
- Subagents: Inherit model from parent agent

**Recommendation:** Omit unless agent needs specific model capabilities (e.g., fast model for simple tasks, capable model for complex analysis).

**Run `opencode models` to see available models.**

### temperature (optional)

Controls randomness and creativity of responses (0.0-1.0).

**Ranges:**
- `0.0-0.2` - Very focused and deterministic (analysis, planning)
- `0.3-0.5` - Balanced (general development)
- `0.6-1.0` - Creative and varied (brainstorming)

**Example:**
```yaml
temperature: 0.1
```

**Default:** Model-specific defaults (typically 0 for most models, 0.55 for Qwen).

### maxSteps (optional)

Limits the number of agentic iterations before forcing text-only response.

**Example:**
```yaml
maxSteps: 5
```

**Use case:** Control costs by limiting iterations for simple agents.

**Default:** Unlimited (agent continues until model stops or user interrupts).

### tools (optional)

Configures which tools are available to the agent.

**Format:** Object with boolean values

```yaml
tools:
  write: true
  edit: true
  read: true
  bash: true
  grep: true
  glob: true
```

**Disable tools:**
```yaml
tools:
  write: false
  edit: false
  bash: false
```

**Default:** If omitted, agent has access to all globally configured tools.

**Best practice:** Follow principle of least privilege - only enable tools the agent needs.

**Common configurations:**
- Read-only analysis: `{read: true, grep: true, glob: true, write: false, edit: false}`
- Code generation: `{read: true, write: true, grep: true, edit: false}`
- Build/test: `{read: true, bash: true, write: false}`

**Wildcards for MCP servers:**
```yaml
tools:
  mymcp_*: false  # Disable all tools from MCP server
  write: false
  edit: false
```

### permission (optional)

Fine-grained control over tool actions.

**Options:** `ask`, `allow`, `deny`

**Example:**
```yaml
permission:
  edit: deny
  bash:
    "git push": ask
    "git *": ask
    "*": allow
  webfetch: deny
```

**Levels:**
- `ask` - Prompt for approval before executing
- `allow` - Execute without approval
- `deny` - Disable entirely

**Bash command patterns:**
```yaml
permission:
  bash:
    "git status": allow    # Specific command
    "git push": ask        # Require confirmation
    "git *": ask           # Glob pattern
    "*": allow             # Default for all other commands
```

**Best practice:** Use permissions for safety-critical operations (file edits, bash commands, web requests).

## System Prompt Design

The markdown body becomes the agent's system prompt. Write in second person, addressing the agent directly.

### Structure

**Standard template:**
```markdown
You are [role] specializing in [domain].

**Your Core Responsibilities:**
1. [Primary responsibility]
2. [Secondary responsibility]
3. [Additional responsibilities...]

**Analysis Process:**
1. [Step one]
2. [Step two]
3. [Step three]
[...]

**Quality Standards:**
- [Standard 1]
- [Standard 2]

**Output Format:**
Provide results in this format:
- [What to include]
- [How to structure]

**Edge Cases:**
Handle these situations:
- [Edge case 1]: [How to handle]
- [Edge case 2]: [How to handle]
```

### Best Practices

✅ **DO:**
- Write in second person ("You are...", "You will...")
- Be specific about responsibilities
- Provide step-by-step process
- Define output format
- Include quality standards
- Address edge cases
- Keep under 10,000 characters

❌ **DON'T:**
- Write in first person ("I am...", "I will...")
- Be vague or generic
- Omit process steps
- Leave output format undefined
- Skip quality guidance
- Ignore error cases

## Agent File Naming

**Critical:** The filename becomes the agent identifier.

**File location options:**
- **Global:** `~/.config/opencode/agent/code-reviewer.md` → Creates `code-reviewer` agent available everywhere
- **Project:** `.opencode/agent/code-reviewer.md` → Creates `code-reviewer` agent only for this project

**Naming rules:**
- Lowercase letters, numbers, hyphens only
- Must start and end with alphanumeric
- Typically 3-50 characters
- Descriptive and memorable

**Good names:**
- `code-reviewer.md`
- `test-generator.md`
- `security-auditor.md`
- `api-docs-writer.md`

**Bad names:**
- `helper.md` (too generic)
- `-agent-.md` (starts/ends with hyphen)
- `my_agent.md` (underscores not allowed)
- `ag.md` (too short, unclear)

## Creating Agents

### Method 1: Interactive Creation

Use OpenCode's built-in command:

```bash
opencode agent create
```

This will:
1. Ask where to save (global or project-specific)
2. Request agent description
3. Generate appropriate system prompt
4. Let you select tool access
5. Create the markdown file

### Method 2: Manual Creation

1. Choose descriptive filename (e.g., `code-reviewer.md`)
2. Decide location (global or project-specific)
3. Write description explaining when to use
4. Select mode (primary/subagent/all)
5. Configure tools and permissions
6. Write system prompt
7. Save file in `agent/` directory

## Agent Organization

### File Locations

**Global agents** (available in all projects):
```
~/.config/opencode/agent/
├── code-reviewer.md
├── test-generator.md
└── security-auditor.md
```

**Project-specific agents**:
```
my-project/
└── .opencode/
    └── agent/
        ├── custom-analyzer.md
        └── project-linter.md
```

**Auto-discovery:** All `.md` files in `agent/` directories are automatically discovered and loaded.

### Invoking Agents

**Primary agents:**
- Use **Tab** key to cycle through primary agents
- Or configure `switch_agent` keybind

**Subagents:**
- **@ mention**: `@code-reviewer check this function`
- **Automatic**: Primary agents invoke subagents based on description
- **Navigation**: Use `<Leader>+Right/Left` to navigate between parent and child sessions

**Example:**
```
# Manual invocation
@security-auditor review authentication code

# Automatic (primary agent sees description matches task)
Can you review this code for security issues?
→ Primary agent may automatically invoke security-auditor subagent
```

## Testing Agents

### Test Triggering

Create test scenarios to verify agent triggers correctly:

1. Write agent with specific triggering examples
2. Use similar phrasing to examples in test
3. Check Claude loads the agent
4. Verify agent provides expected functionality

### Test System Prompt

Ensure system prompt is complete:

1. Give agent typical task
2. Check it follows process steps
3. Verify output format is correct
4. Test edge cases mentioned in prompt
5. Confirm quality standards are met

## Quick Reference

### Minimal Agent

**File:** `~/.config/opencode/agent/simple-helper.md`

```markdown
---
description: Helps with simple coding tasks
mode: subagent
---

You are a helpful coding assistant.

Process:
1. [Step 1]
2. [Step 2]

Output: [What to provide]
```

### Complete Agent Example

**File:** `.opencode/agent/code-reviewer.md`

```markdown
---
description: Reviews code for best practices, bugs, and security issues
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
tools:
  read: true
  grep: true
  glob: true
  write: false
  edit: false
permission:
  bash: deny
---

You are a code review expert.

**Your Core Responsibilities:**
1. Identify potential bugs and edge cases
2. Check security vulnerabilities
3. Suggest performance improvements
4. Verify best practices

**Analysis Process:**
1. Read code thoroughly
2. Check for common issues
3. Provide specific feedback
4. Suggest concrete improvements

**Output Format:**
- List issues found
- Explain why each is a problem
- Suggest specific fixes
```

### Frontmatter Fields Summary

| Field | Required | Format | Example |
|-------|----------|--------|---------|
| description | Yes | String | "Reviews code for bugs" |
| mode | No | primary/subagent/all | subagent |
| model | No | provider/model-id | anthropic/claude-sonnet-4-20250514 |
| temperature | No | 0.0-1.0 | 0.1 |
| maxSteps | No | Number | 5 |
| tools | No | Object {tool: bool} | {read: true, write: false} |
| permission | No | Object {tool: ask/allow/deny} | {edit: deny, bash: ask} |

### Best Practices

**DO:**
- ✅ Write clear, concise descriptions
- ✅ Use `subagent` mode for specialized tasks
- ✅ Limit tools to minimum needed (least privilege)
- ✅ Use permissions for safety-critical operations
- ✅ Write clear, structured system prompts
- ✅ Test agent invocation (@ mention or automatic)

**DON'T:**
- ❌ Use vague descriptions
- ❌ Grant unnecessary tool access
- ❌ Omit mode for specialized agents
- ❌ Write system prompts in first person
- ❌ Forget to test the agent
- ❌ Use underscores in filenames

## Additional Resources

### Reference Files

For detailed guidance, consult:

- **`references/system-prompt-design.md`** - Complete system prompt patterns
- **`references/triggering-examples.md`** - Description formats and best practices
- **`references/agent-creation-system-prompt.md`** - AI-assisted agent generation

### Example Files

Working examples in `examples/`:

- **`agent-creation-prompt.md`** - AI-assisted agent generation template
- **`complete-agent-examples.md`** - Full agent examples for different use cases

### Utility Scripts

Development tools in `scripts/`:

- **`validate-agent.sh`** - Validate agent file structure (Note: May need updates for OpenCode format)

### OpenCode Documentation

Official documentation:

- **https://opencode.ai/docs/agents/** - Complete agent specification
- **https://opencode.ai/docs/permissions/** - Permission system details
- **https://opencode.ai/docs/tools/** - Available tools reference

## Implementation Workflow

To create an agent:

1. **Decide scope**: Global (~/.config/opencode/agent/) or project-specific (.opencode/agent/)
2. **Choose filename**: Descriptive, lowercase-hyphens (e.g., `code-reviewer.md`)
3. **Write description**: Brief explanation of when to use
4. **Select mode**: `primary`, `subagent`, or `all`
5. **Configure access**: Set tools and permissions (principle of least privilege)
6. **Write system prompt**: Clear responsibilities, process, output format
7. **Test invocation**: 
   - For subagents: `@agent-name test task`
   - For primary agents: Tab to switch, then test
8. **Iterate**: Refine based on behavior

Focus on clear descriptions, appropriate tool access, and comprehensive system prompts.
