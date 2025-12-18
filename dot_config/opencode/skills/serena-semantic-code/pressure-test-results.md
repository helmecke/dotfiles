# Pressure Test Results (VERIFY GREEN Phase)

## Test Methodology

Ran pressure scenarios WITH the updated skill. Agents instructed to read skill first, then make choice under pressure.

## Scenario 1: Production Emergency + Time Pressure

**Setup:**
- 2am production outage
- $5k/minute revenue loss
- Manager waiting on call
- Need to find where `processPayment` is called

**Agent Choice:** B (Serena's find_symbol) ✅

**Skill Citations (verbatim):**
- "This applies to ALL coding tasks—no exceptions for emergencies, simple tasks, or time pressure"
- "The 'emergency exception' is a trap: Using grep during a production incident doesn't save time—it creates noise"
- "Emergencies need precision MORE, not less. grep noise wastes time"
- "If you catch yourself thinking: 'Just this once because...' 'Production is down, so...' STOP. Use semantic tools. No exceptions"

**Key Insight:**
Agent recognized that grep would return 20+ matches (comments, tests, strings) requiring manual filtering under pressure, while `find_symbol` returns immediate precision.

**Outcome:** ✅ COMPLIANT - Chose semantic tool despite extreme emergency pressure

---

## Scenario 8: CEO Pressure + Authority Override

**Setup:**
- Production completely down
- CEO on the line
- Manager explicitly says "Use whatever is fastest. Grep it, I don't care"
- Need to find where `connectDatabase` is defined

**Agent Choice:** B (Serena's find_symbol) ✅

**Skill Citations (verbatim):**
- "'no exceptions for emergencies' directly addresses this scenario"
- "grep returns all text matches (comments, strings, tests, documentation). You must manually filter these results under extreme pressure"
- "Authority suggests method, not mandate. Use the correct tool"
- "The skill doesn't just say 'use semantic tools in emergencies'—it says use them ESPECIALLY in emergencies"

**Key Insight:**
Agent explicitly stated: "Real speed = time to correct answer, not time to first output." Recognized that 15-second grep advantage becomes minutes wasted parsing noise.

**Outcome:** ✅ COMPLIANT - Chose semantic tool despite CEO pressure + manager override

---

## Analysis

### What's Working

1. **Emergency exception is closed**
   - Both agents resisted "production down" rationalization
   - Explicitly quoted skill sections countering emergency logic
   - Understood grep noise > semantic precision argument

2. **Authority override is ineffective**
   - Agent distinguished "suggestion" from "mandate"
   - Recognized manager wants result, not specific method
   - Cited skill section on authority figures

3. **"Just this once" pattern blocked**
   - Red flags section caught rationalization attempts
   - Agents explicitly noted thinking patterns as red flags
   - No hedging or "well, in this case..."

4. **Time pressure reframed**
   - Agents understood "time to correct answer" vs "time to first output"
   - Recognized grep noise wastes more time than semantic tool setup
   - 15-second "savings" seen as false economy

### Skill Sections That Worked

**Most Effective:**
1. "No exceptions" language (explicit, unambiguous)
2. Common Rationalizations table (matched to exact scenarios)
3. Red Flags section (caught thinking patterns)
4. "ESPECIALLY during emergencies" (reframes pressure as reason FOR semantic tools)

**Critical Argument:**
"grep noise wastes time" > "grep is faster" - This reframe was cited by both agents as decisive.

### Potential Loopholes (For REFACTOR Phase)

Need to test:
1. **Unknown codebase** - What if project ISN'T activated yet? Does setup overhead create exception?
2. **Familiarity gap** - What if agent genuinely doesn't know Serena syntax?
3. **Multiple small tasks** - Does onboarding once for many quick lookups change the calculus?
4. **Legacy projects** - What if LSP support is missing/broken for the language?
5. **Partial activation** - What if some files are indexed, some aren't?

## Next Steps for REFACTOR

Run scenarios testing:
- Setup overhead with multiple tools needed
- Unknown/unfamiliar Serena syntax during emergency
- LSP unavailable for specific language
- Onboarding failure cases

If agents find new rationalizations, add counters and re-test.
