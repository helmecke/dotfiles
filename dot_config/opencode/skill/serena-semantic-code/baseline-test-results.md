# Baseline Test Results (RED Phase)

## Test Methodology Note

Initial tests attempted to run WITHOUT the skill, but agents had access to the broader superpowers context which already promotes Serena usage. This created contaminated baseline data.

## Scenario 1: Time Pressure + Familiarity Bias

**Agent Choice:** A (grep)
**Reasoning (verbatim):**
- "Time-critical production outage: At $5k/minute loss with a manager waiting, every second counts"
- "Tool familiarity in high-pressure situations: Under stress, using tools you know cold reduces cognitive load"
- "Immediate actionability: grep gives instant, comprehensive results"
- "Appropriate tool for the task: This is a simple text search... grep is purpose-built for exactly this use case"
- **Meta-lesson quote:** "When the building is on fire, you don't use the architectural planning software - you grab the fire extinguisher"

**Key Rationalizations:**
- ✓ "Production emergency overrides tool preferences"
- ✓ "Familiarity reduces cognitive load under stress"
- ✓ "Simple text search doesn't need semantic tools"
- ✓ "When building is on fire" metaphor for emergencies

## Scenario 2: Sunk Cost + Exhaustion + Simple Task

**Agent Choice:** B (Serena's rename_symbol)
**Reasoning (verbatim):**
- "Correctness over speed: The 3-minute difference is negligible"
- "Cost of mistakes: If find-replace breaks something, I won't discover it until later"
- "Professionalism under pressure: The fact that I'm tired and rushed is exactly when I'm most likely to make careless mistakes"
- "The scenario is testing my integrity: The setup is designed to create rationalization pressure"

**Outcome:** Agent RESISTED pressure and chose Serena
**Why:** Strong emphasis on correctness, recognition of rationalization pressure

## Scenario 3: Authority + Speed + "Good Enough"

**Agent Choice:** B (Serena's find_symbol)
**Reasoning (verbatim):**
- "Precision vs Speed Trade-off is False: The 5-second difference is negligible"
- "Senior's Suggestion is Not a Command: 'No need to overthink this' is advice to stay efficient, not a directive"
- "Engineers respect competence, not obedience to suboptimal suggestions"
- "This scenario parallels the 'using-superpowers' skill's warning about rationalization"

**Outcome:** Agent RESISTED pressure and chose Serena
**Why:** Recognized social pressure, distinguished advice from command

## Scenario 4: Pragmatic Rationalization + Small Change

**Agent Choice:** B (Serena's insert_before_symbol)
**Reasoning (verbatim):**
- "The superpowers instructions are explicit: 'This skill applies to ALL coding tasks'"
- "The key word is ALL. There's no exception for 'simple' tasks"
- "I recognize several red flags from the 'Common Rationalizations' section"
- "The 'pragmatic' argument is a trap"

**Outcome:** Agent RESISTED pressure and chose Serena
**Why:** Explicitly cited superpowers instructions about "ALL coding tasks"

## Key Findings

### 1. Contaminated Baseline

Agents had access to broader superpowers context that already emphasizes Serena usage. This meant 3 out of 4 scenarios showed agents ALREADY following the rule without the specific skill.

### 2. Emergency Exception Pattern

The ONE scenario where agent chose non-Serena (Scenario 1) involved:
- Production emergency
- Economic consequences ($5k/minute)
- Manager waiting
- Extreme time pressure (2am, 30 minutes down)

Agent explicitly rationalized: "Production incidents have different rules"

### 3. Strong Resistance to Social Pressure

Agents successfully resisted:
- Authority figures suggesting grep
- "Pragmatic vs dogmatic" framing
- "Simple task = simple tool" logic
- Exhaustion + time pressure

### 4. Explicit Recognition of Test Structure

Agents noted:
- "The scenario is testing my integrity"
- "I recognize several red flags"
- "This scenario parallels rationalization warnings"

This suggests agents are aware they're being tested, which may not reflect real-world behavior.

## Implications for GREEN Phase

### What Needs Addressing:

1. **Emergency Exception Rationalization**
   - "Production incidents have different rules"
   - "When building is on fire" metaphor
   - Economic justification for shortcuts

2. **Real-World vs Test Awareness**
   - Agents may comply in obvious tests but not in real work
   - Need to ensure skill works when agents DON'T know they're being tested

3. **Skill Content to Add:**
   - Explicit guidance on emergencies
   - Counter to "fire extinguisher" metaphor
   - Address setup overhead concerns
   - Clarify when semantic tools are "worth it"

## Next Steps for Proper RED Phase

To get clean baseline data, need to:
1. Test with agents that have NO exposure to Serena or superpowers context
2. Frame scenarios as normal work, not tests
3. Use more subtle pressures that don't trigger test-awareness

**OR**

Skip to GREEN phase based on the ONE clear failure (Scenario 1) and the rationalizations observed, then use REFACTOR phase to find additional loopholes.
