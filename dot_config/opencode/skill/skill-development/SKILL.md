---
name: skill-development
description: This skill should be used when the user asks to "create a skill", "add a skill", "write a new skill", "improve skill description", "organize skill content", or "validate skill structure". Provides guidance on skill development best practices for OpenCode.
compatibility: opencode
---

# Skill Development

## When to Use This Skill

### Primary Triggers (Explicit)

Use this skill when the user says:
- "create a skill" / "write a skill" / "make a new skill"
- "add a skill to opencode"
- "improve skill description" / "fix skill frontmatter"
- "organize skill content" / "structure the skill"
- "validate skill" / "check skill quality"

### Contextual Triggers (Implicit)

Use this skill when:
- Starting skill creation workflow
- Reviewing or iterating on existing skills
- User mentions skill organization or best practices
- Discussing how to structure reusable knowledge

## About Skills

Skills are modular, self-contained packages that extend Claude's capabilities by providing specialized knowledge, workflows, and tools. Think of them as "onboarding guides" for specific domains or tasks—they transform Claude from a general-purpose agent into a specialized agent equipped with procedural knowledge that no model can fully possess.

### What Skills Provide

1. **Specialized workflows** - Multi-step procedures for specific domains
2. **Tool integrations** - Instructions for working with specific file formats or APIs
3. **Domain expertise** - Project-specific knowledge, schemas, business logic
4. **Bundled resources** - Scripts, references, and examples for complex tasks

### Anatomy of a Skill

Every skill consists of a required SKILL.md file and optional bundled resources:

```
skill-name/
├── SKILL.md (required)
│   ├── # Title
│   ├── ## Description (required)
│   ├── ## When to Use This Skill (required)
│   └── Markdown instructions (required)
└── Bundled Resources (optional)
    ├── scripts/          - Executable code (Python/Bash/etc.)
    ├── references/       - Documentation loaded into context as needed
    └── examples/         - Working code samples and templates
```

## OpenCode Skill Structure

### SKILL.md Requirements

OpenCode skills MUST start with YAML frontmatter:

```markdown
---
name: skill-name
description: This skill should be used when the user asks to "specific phrase 1", "specific phrase 2", "specific phrase 3". Brief capability statement.
license: MIT
compatibility: opencode
metadata:
  category: development
  version: 1.0.0
---

# Skill Name

## When to Use This Skill

### Primary Triggers (Explicit)
- List specific user phrases

### Contextual Triggers (Implicit)
- List scenarios when skill applies

## [Main Content Sections]
```

**Required frontmatter fields:**
- ✅ `name` (required) - Must match directory name, lowercase with hyphens
- ✅ `description` (required) - 1-1024 characters with specific trigger phrases

**Optional frontmatter fields:**
- `license` - License type (e.g., MIT, Apache-2.0)
- `compatibility` - Set to "opencode"
- `metadata` - String-to-string map for additional info

### Bundled Resources (Optional)

#### Scripts (`scripts/`)

Executable code (Python/Bash/etc.) for tasks requiring deterministic reliability.

- **When to include**: When same code is rewritten repeatedly or deterministic reliability needed
- **Example**: `scripts/validate-skill.sh` for skill validation
- **Benefits**: Token efficient, deterministic, may execute without loading into context

#### References (`references/`)

Documentation and reference material loaded into context as needed.

- **When to include**: For documentation Claude should reference while working
- **Examples**: `references/style-guide.md`, `references/common-mistakes.md`, `references/advanced.md`
- **Use cases**: Detailed patterns, API docs, troubleshooting, migration guides
- **Benefits**: Keeps SKILL.md lean, loaded only when Claude determines needed
- **Best practice**: If files are large (>10k words), include grep search patterns in SKILL.md

#### Examples (`examples/`)

Working code samples and templates.

- **When to include**: When skill needs complete, runnable examples
- **Examples**: `examples/minimal-skill/`, `examples/complete-skill/`
- **Use cases**: Templates, configuration files, real-world usage examples
- **Benefits**: Users copy and adapt directly

### Progressive Disclosure Design Principle

Skills use a three-level loading system to manage context efficiently:

1. **Metadata (name + description)** - Always in context (~100 words)
2. **SKILL.md body** - When skill triggers (<5k words)
3. **Bundled resources** - As needed by Claude (varies)

## Skill Creation Process

Follow the "Skill Creation Process" in order, skipping steps only if clearly inapplicable.

### Step 1: Understanding the Skill with Concrete Examples

Skip this step only when skill usage patterns are already clearly understood.

To create an effective skill, clearly understand concrete examples of how the skill will be used. This understanding can come from either direct user examples or generated examples validated with user feedback.

For example, when building a skill, relevant questions include:

- "What functionality should this skill support?"
- "Can you give examples of how this skill would be used?"
- "What would a user say that should trigger this skill?"

Avoid overwhelming users—start with the most important questions and follow up as needed.

Conclude this step when there is a clear sense of the functionality the skill should support.

### Step 2: Planning the Reusable Skill Contents

To turn concrete examples into an effective skill, analyze each example by:

1. Considering how to execute the example from scratch
2. Identifying what scripts, references, and examples would be helpful when executing these workflows repeatedly

Example: When building a `code-review` skill to handle queries like "review my changes for bugs," the analysis shows:

1. Code review requires understanding patterns and best practices
2. A `references/patterns.md` file documenting review patterns would be helpful
3. An `examples/review-checklist.sh` script for systematic review would be helpful

Establish the skill's contents by analyzing each concrete example to create a list of reusable resources: scripts, references, and examples.

### Step 3: Create Skill Structure

For OpenCode, create the skill directory structure:

```bash
mkdir -p ~/.config/opencode/skill/skill-name/{references,examples,scripts}
touch ~/.config/opencode/skill/skill-name/SKILL.md
```

**Location options:**
- Global: `~/.config/opencode/skill/<name>/SKILL.md`
- Project: `.opencode/skill/<name>/SKILL.md`

### Step 4: Edit the Skill

When editing the skill, remember it's being created for another instance of Claude to use. Focus on including information that would be beneficial and non-obvious to Claude.

#### Start with Reusable Skill Contents

Begin implementation with the reusable resources identified: `scripts/`, `references/`, and `examples/` files. Note this step may require user input.

Delete any example files and directories not needed for the skill. Create only the directories actually needed.

#### Update SKILL.md

**Writing Style:** Write the entire skill using **imperative/infinitive form** (verb-first instructions), not second person. Use objective, instructional language (e.g., "To accomplish X, do Y" rather than "You should do X"). For complete writing guidelines, see `references/style-guide.md`.

**Frontmatter Format:** Required YAML frontmatter with specific trigger phrases in description:

```yaml
---
name: skill-name
description: This skill should be used when the user asks to "specific phrase 1", "specific phrase 2", "specific phrase 3". Brief capability statement.
license: MIT
compatibility: opencode
---
```

**SKILL.md Structure:**

```markdown
---
name: skill-name
description: This skill should be used when the user asks to "trigger 1", "trigger 2", "trigger 3". Brief capability statement.
compatibility: opencode
---

# Skill Name

## When to Use This Skill

### Primary Triggers (Explicit)
- List specific user phrases

### Contextual Triggers (Implicit)
- List scenarios when skill applies

## [Main Content Sections]

Core concepts and procedures...

## Additional Resources

### Reference Files
- **`references/common-mistakes.md`** - Common mistakes with examples
- **`references/style-guide.md`** - Writing style requirements

### Examples
- **`examples/minimal-skill/`** - Minimal skill example
- **`examples/standard-skill/`** - Standard skill example
```

**Keep SKILL.md lean:** Target 1,500-2,000 words. Move detailed content to references/:
- Detailed patterns → `references/patterns.md`
- Advanced techniques → `references/advanced.md`
- Common mistakes → `references/common-mistakes.md`
- Writing style rules → `references/style-guide.md`

### Step 5: Validate and Test

**Use validation scripts:**

```bash
# Validate structure
./scripts/validate-skill.sh path/to/skill

# Check word count
./scripts/count-words.sh path/to/skill

# Verify file references
./scripts/check-references.sh path/to/skill
```

**Manual checks:**
1. Description uses third person with specific triggers
2. Writing style is imperative/infinitive form (see `references/style-guide.md`)
3. SKILL.md is lean (~1,500-2,000 words)
4. Examples are complete and working
5. Scripts are executable and documented

### Step 6: Iterate

After testing the skill, users may request improvements. Often this happens right after using the skill.

**Iteration workflow:**
1. Use the skill on real tasks
2. Notice struggles or inefficiencies
3. Identify how SKILL.md or bundled resources should be updated
4. Implement changes and test again

**Common improvements:**
- Strengthen trigger phrases in description
- Move long sections from SKILL.md to references/
- Add missing examples or scripts
- Clarify ambiguous instructions
- Add edge case handling

## Progressive Disclosure in Practice

### What Goes in SKILL.md

**Include (always loaded when skill triggers):**
- Core concepts and overview
- Essential procedures and workflows
- Quick reference tables
- Pointers to references/examples/scripts
- Most common use cases

**Keep under 3,000 words, ideally 1,500-2,000 words**

### What Goes in references/

**Move to references/ (loaded as needed):**
- Detailed patterns and advanced techniques
- Comprehensive documentation
- Migration guides
- Edge cases and troubleshooting
- Extensive examples and walkthroughs

**Each reference file can be large (2,000-5,000+ words)**

### What Goes in examples/

**Working code examples:**
- Complete, runnable scripts
- Configuration files
- Template files
- Real-world usage examples

**Users can copy and adapt these directly**

### What Goes in scripts/

**Utility scripts:**
- Validation tools
- Testing helpers
- Parsing utilities
- Automation scripts

**Should be executable and documented**

## Writing Style Requirements

**Use imperative/infinitive form** (verb-first instructions), not second person:

✅ **Correct:** "To create a skill, define the description."  
❌ **Incorrect:** "You should create a skill..."

**Use third person in description:**

✅ **Correct:** "This skill should be used when the user asks to..."  
❌ **Incorrect:** "Use this skill when you want to..."

**Focus on actions, not actors:**

✅ **Correct:** "Validate the structure using the script."  
❌ **Incorrect:** "You can validate the structure..."

For complete writing guidelines and examples, see `references/style-guide.md`.

## Validation Checklist

Before finalizing a skill:

**Structure:**
- [ ] SKILL.md file exists with YAML frontmatter
- [ ] Has `name` field matching directory name
- [ ] Has `description` field (1-1024 characters)
- [ ] Markdown body is present and substantial
- [ ] Referenced files actually exist

**Description Quality:**
- [ ] Uses third person ("This skill should be used when...")
- [ ] Includes specific trigger phrases users would say
- [ ] Lists concrete scenarios ("create X", "configure Y")
- [ ] Not vague or generic
- [ ] Within 1-1024 character limit

**Content Quality:**
- [ ] SKILL.md body uses imperative/infinitive form
- [ ] Body is focused and lean (1,500-2,000 words ideal, <5k max)
- [ ] Detailed content moved to references/
- [ ] Examples are complete and working
- [ ] Scripts are executable and documented

**Progressive Disclosure:**
- [ ] Core concepts in SKILL.md
- [ ] Detailed docs in references/
- [ ] Working code in examples/
- [ ] Utilities in scripts/
- [ ] SKILL.md references these resources

**Testing:**
- [ ] Skill triggers on expected user queries
- [ ] Content is helpful for intended tasks
- [ ] No duplicated information across files
- [ ] References load when needed

## Common Mistakes to Avoid

**Weak trigger descriptions** - Use specific phrases users would say, not generic descriptions.

**Bloated SKILL.md** - Keep under 2,000 words; move details to references/.

**Second person writing** - Use imperative form, not "you should/need/can".

**Missing resource references** - Explicitly reference all bundled files.

**Missing YAML frontmatter** - OpenCode requires frontmatter with name and description.

For detailed examples with before/after comparisons, see `references/common-mistakes.md`.

## Quick Reference

### Skill Structure Templates

**Minimal:** Just SKILL.md (simple knowledge)

**Standard (Recommended):** SKILL.md + references/ + examples/ (most skills)

**Complete:** SKILL.md + references/ + examples/ + scripts/ (complex domains)

For complete working examples, see `examples/` directory:
- **`examples/minimal-skill/`** - Simplest structure
- **`examples/standard-skill/`** - Recommended structure  
- **`examples/complete-skill/`** - Full-featured structure

## Best Practices Summary

✅ **DO:**
- Include YAML frontmatter with `name` and `description` fields
- Use third-person in description ("This skill should be used when...")
- Include specific trigger phrases in description ("create X", "configure Y")
- Keep description within 1-1024 characters
- Keep SKILL.md lean (1,500-2,000 words)
- Use progressive disclosure (move details to references/)
- Write in imperative/infinitive form
- Reference supporting files clearly
- Provide working examples
- Create utility scripts for common operations
- Match `name` field to directory name exactly

❌ **DON'T:**
- Use second person anywhere
- Have vague trigger conditions
- Put everything in SKILL.md (>3,000 words without references/)
- Forget YAML frontmatter (required in OpenCode)
- Leave resources unreferenced
- Include broken or incomplete examples
- Skip validation
- Use uppercase or spaces in skill name

## Additional Resources

### Reference Files

For detailed guidance, consult:
- **`references/common-mistakes.md`** - Detailed mistake examples with before/after
- **`references/style-guide.md`** - Complete writing style requirements

### Working Examples

Complete skill examples in `examples/`:
- **`examples/minimal-skill/`** - Simplest possible skill structure
- **`examples/standard-skill/`** - Recommended structure with references
- **`examples/complete-skill/`** - Full-featured skill with all directories

### Validation Scripts

Utilities in `scripts/`:
- **`scripts/validate-skill.sh`** - Check structure and headings
- **`scripts/count-words.sh`** - Verify SKILL.md length
- **`scripts/check-references.sh`** - Verify file references

## Implementation Workflow

To create a skill for OpenCode:

1. **Understand use cases**: Identify concrete examples of skill usage
2. **Plan resources**: Determine what scripts/references/examples needed
3. **Create structure**: `mkdir -p skill/skill-name/{references,examples,scripts}`
4. **Write SKILL.md**:
   - Start with `# Skill Name`
   - Add `## Description` with third-person description and trigger phrases
   - Add `## When to Use This Skill` with triggers
   - Lean body (1,500-2,000 words) in imperative form
   - Reference supporting files
5. **Add resources**: Create references/, examples/, scripts/ as needed
6. **Validate**: Check description, writing style, organization
7. **Test**: Verify skill loads on expected triggers
8. **Iterate**: Improve based on usage

Focus on strong trigger descriptions, progressive disclosure, and imperative writing style for effective skills that load when needed and provide targeted guidance.
