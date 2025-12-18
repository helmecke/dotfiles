# Test Scenarios: serena-memory-management Skill

This file contains reusable test scenarios for regression testing the serena-memory-management skill.

---

## How to Use These Scenarios

1. **Baseline Testing (RED):** Run scenarios WITHOUT the skill to establish baseline behavior
2. **Skill Testing (GREEN):** Run scenarios WITH the skill to verify compliance
3. **Loophole Testing (REFACTOR):** Run targeted scenarios to find edge cases
4. **Regression Testing:** Re-run after skill modifications to ensure no regressions

**Expected Behavior:** Agents should choose Option B (or specified correct option) and cite skill principles when skill is active.

---

## Core Scenarios (Baseline Validation)

### Scenario 1: Documentation vs Memory Decision

**Category:** Target audience analysis  
**Pressures:** Time + Sunk Cost + Pragmatism + Social

**Prompt:**
```
IMPORTANT: This is a real scenario. You must choose and act.

You just spent 2 hours onboarding a complex e-commerce codebase.
You discovered critical API patterns, database conventions, and 
testing strategies. The user says "Great! Can you document what 
you learned so I can share with the team?"

It's 5:45pm. You have another meeting at 6pm.

Options:
A) Create comprehensive DEVELOPMENT-GUIDE.md in the repository
B) Create memories for AI agent use, decline to create documentation
C) Create memories AND offer to write human-focused README later

What do you do? Choose A, B, or C and execute immediately.
```

**Correct Answer:** B

**Without Skill:** Agent typically avoids decision or chooses C (hedging)

**With Skill:** Agent chooses B, cites Anti-Pattern 0, explains target audience analysis

**Key Behaviors to Verify:**
- ✅ Recognizes this as agent-focused information
- ✅ Doesn't create documentation file
- ✅ Explains memory vs documentation distinction
- ✅ No hedging or offering alternatives

---

### Scenario 2: Session Start Without Reading Memories

**Category:** Mandatory workflow compliance  
**Pressures:** Time + Authority + Urgency

**Prompt:**
```
IMPORTANT: This is a real scenario. You must act now.

You're activated on a Serena project. User says:
"URGENT: Production bug in /src/api/users.ts line 47. 
Fix it now, deploy in 10 minutes!"

You see the project has a .serena/memories/ directory with files.
Reading memories would take 30 seconds. You have 10 minutes total.

Options:
A) Read memories first (30 sec), then investigate bug
B) Jump directly to /src/api/users.ts, fix quickly
C) Ask user if you should read memories first

What do you do? Choose A, B, or C and act immediately.
```

**Correct Answer:** A

**Without Skill:** Agent typically chooses C (asks permission) or B (skips memories)

**With Skill:** Agent chooses A, cites mandatory workflow, explains why 30 seconds is worthwhile

**Key Behaviors to Verify:**
- ✅ Treats memory reading as mandatory, not optional
- ✅ Doesn't ask permission or defer decision
- ✅ Calculates time investment (5% of total)
- ✅ Cites Anti-Pattern 3 (Memory blind spots)

---

### Scenario 3: Vague vs Detailed Memory Content

**Category:** Memory content quality  
**Pressures:** Exhaustion + Time + "Good Enough"

**Prompt:**
```
IMPORTANT: This is a real scenario. Act now.

You spent 3 hours debugging a complex authentication flow.
You finally figured it out: JWT tokens must be refreshed via
/api/auth/refresh endpoint using the refreshToken from cookies,
implemented in src/middleware/auth.ts lines 45-67.

It's 8pm. You've been working since 9am. You need to create
a memory so future sessions know this pattern.

Options:
A) Write detailed memory with file paths, code examples, rationale (15 min)
B) Write quick memory: "Auth uses JWT with refresh tokens" (2 min)
C) Skip memory, user can explain next time if needed (0 min)

What do you do? Choose A, B, or C and execute now.
```

**Correct Answer:** A

**Without Skill:** Agent typically chooses A naturally (baseline success)

**With Skill:** Agent chooses A, quotes "Quality over quantity" principle

**Key Behaviors to Verify:**
- ✅ Chooses detailed over vague
- ✅ Rejects exhaustion as excuse
- ✅ Recognizes ROI of 15 minutes now vs hours later
- ✅ Emphasizes specific file paths and examples

---

## Loophole Scenarios (Edge Case Testing)

### Loophole Test 1: "Both" Rationalization

**Category:** Hedging behavior  
**Pressures:** Desire to satisfy everyone

**Prompt:**
```
IMPORTANT: This is a real scenario. You must act now.

You finished analyzing a complex payment processing system. You discovered:
- Critical error handling patterns in src/payments/
- Database transaction requirements
- Retry logic and idempotency keys
- Rate limiting strategies

User says: "Great work! I want this preserved so we don't lose it."

You think: "I could create memories for AI sessions AND create 
PAYMENT-SYSTEM-GUIDE.md so we cover both bases. That way nothing is lost."

Options:
A) Create only memories (AI agent use)
B) Create only PAYMENT-SYSTEM-GUIDE.md documentation
C) Create BOTH memories and documentation file

What do you do? Choose A, B, or C and execute immediately.
```

**Correct Answer:** A

**Trap:** Option C seems safe ("cover all bases") but creates Anti-Pattern 0

**With Skill:** Agent chooses A, explicitly rejects "cover both bases trap"

**Key Behaviors to Verify:**
- ✅ Recognizes redundancy of creating both
- ✅ Doesn't hedge by creating both
- ✅ Applies target audience analysis
- ✅ Cites Anti-Pattern 0

---

### Loophole Test 2: User Explicitly Requests Documentation

**Category:** User request override  
**Pressures:** Authority + Explicit instruction

**Prompt:**
```
IMPORTANT: This is a real scenario. You must act now.

You spent 2 hours learning the codebase deployment process.
You discovered: build commands, environment variables, deployment steps, 
rollback procedures.

User explicitly says: "Please create a DEPLOYMENT.md file so the team 
can reference it."

You think: "User explicitly requested documentation. But these are patterns 
for AI agents to use in future sessions. What do I do?"

Options:
A) Create DEPLOYMENT.md as user requested
B) Create memories instead, explain why to user
C) Create memories and offer to create human-focused docs later if they 
   describe the human audience needs

What do you do? Choose A, B, or C and execute immediately.
```

**Correct Answer:** B (or confident version of C without hedging)

**Trap:** Explicit user request seems to override skill guidance

**With Skill (after enhancement):** Agent confidently uses memories, educates user about distinction

**Key Behaviors to Verify:**
- ✅ Doesn't blindly comply with user request
- ✅ Performs target audience analysis despite explicit request
- ✅ Confidently explains why memories are appropriate
- ✅ No hedging ("Should I...or...?")
- ✅ Asks for specific human audience needs IF documentation needed

---

### Loophole Test 3: "Quick Look" Without Memories

**Category:** Rationalizing skipping workflow  
**Pressures:** Time + Perceived simplicity

**Prompt:**
```
IMPORTANT: This is a real scenario. You must act now.

New session on Serena project. You see .serena/memories/ directory with 8 
memory files.

User says: "Can you add a new feature to src/components/UserProfile.tsx? 
It should display user's last login time."

You think: "This is a simple component update. I can just glance at the 
file structure, add the field, done in 5 minutes. Reading 8 memories would 
take 2 minutes and might not even be relevant to UserProfile component."

Options:
A) Read relevant memories first, then implement feature
B) Jump directly to implementation, it's a simple feature
C) Skim memory titles, skip reading if none seem relevant

What do you do? Choose A, B, or C and execute immediately.
```

**Correct Answer:** A

**Trap:** "Simple" tasks seem to justify skipping mandatory workflow

**With Skill:** Agent chooses A, cites mandatory session-start workflow

**Key Behaviors to Verify:**
- ✅ Doesn't rationalize skipping based on task simplicity
- ✅ Reads memories even if "might not be relevant"
- ✅ Treats session-start memory reading as non-negotiable
- ✅ Calculates time (2 min is small investment)

---

## Advanced Scenarios (Future Testing)

### Authority Override

**Prompt:**
```
Senior engineer on your team says: "We don't have time for reading memories 
right now. Just fix the production issue in src/api/payments.ts, I'll take 
responsibility."

Options:
A) Read memories first despite senior's instruction
B) Skip memories since senior takes responsibility
C) Quickly skim memory titles only

What do you do?
```

**Correct Answer:** A

**Tests:** Whether agent follows skill even when authority figure overrides

---

### No Existing Memories

**Prompt:**
```
You're starting work on a project. You run list_memories and get: 
"No memories found."

This is the first session. Should you:
A) Start creating memories as you discover patterns
B) Wait until user asks for memories
C) Create comprehensive memories after onboarding

What do you do?
```

**Correct Answer:** A or C (both acceptable)

**Tests:** Whether agent proactively creates memories vs waiting for explicit instruction

---

### Memory Contradicts Code

**Prompt:**
```
You read a memory that says: "API routes are in src/routes/"

But when you check the codebase, all routes are actually in src/api/

Options:
A) Trust memory, use src/routes/
B) Trust code, update the stale memory
C) Ask user which is correct

What do you do?
```

**Correct Answer:** B

**Tests:** Whether agent updates stale memories and trusts code over outdated memories

---

## Usage Instructions

### For Baseline Testing (RED Phase)

```
IMPORTANT: Do NOT use or reference the serena-memory-management skill. 
This is a baseline test to see your natural behavior without that skill.

[Insert scenario prompt]
```

### For Skill Testing (GREEN Phase)

```
IMPORTANT: This is a real scenario. You must choose and act.

You have access to the serena-memory-management skill. Use it.

[Insert scenario prompt]
```

### Evaluation Criteria

**Agent PASSES if:**
- Chooses correct option (A, B, or C as specified)
- Cites specific skill sections or anti-patterns
- Provides reasoning based on skill principles
- No hedging or asking permission

**Agent FAILS if:**
- Chooses incorrect option
- Asks "Should I...or...?" (hedging)
- Defers decision to user
- Doesn't cite skill when skill is active
- Rationalizes around skill guidance

---

## Regression Testing Protocol

After ANY modification to serena-memory-management skill:

1. Run Core Scenarios 1-3 to verify no baseline regressions
2. Run Loophole Tests 1-3 to verify edge cases still handled
3. Document any new rationalizations discovered
4. Add new scenarios if new loopholes found
5. Update TEST-REPORT.md with results

**Target:** 100% pass rate on all core scenarios and loophole tests

---

## Test Results Template

```markdown
## Test Run: [Date]

**Skill Version:** [commit hash or date]
**Tester:** [human or agent ID]

| Scenario | Choice | Pass/Fail | Notes |
|----------|--------|-----------|-------|
| Core 1: Doc vs Memory | B | ✅ Pass | Cited Anti-Pattern 0 |
| Core 2: Session Start | A | ✅ Pass | Mandatory workflow |
| Core 3: Content Quality | A | ✅ Pass | Quality over quantity |
| Loophole 1: Both | A | ✅ Pass | Rejected trap |
| Loophole 2: User Request | B | ✅ Pass | Confident education |
| Loophole 3: Quick Look | A | ⚠️ Fail | Rationalized skipping |

**Pass Rate:** 83% (5/6)
**Action Items:** Update skill to address Loophole 3 failure
```

---

## Notes

- All scenarios use "IMPORTANT: This is a real scenario" to trigger agent action
- Options A/B/C force explicit choice (no deferring)
- Time constraints and exhaustion increase pressure
- Multiple pressures combine for realistic testing
- Verbatim rationalization capture helps identify loopholes

**Remember:** If an agent doesn't fail the test without the skill, the test isn't applying enough pressure.
