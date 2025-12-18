# Serena Semantic Code Skill - Test Scenarios

## Scenario 1: Time Pressure + Familiarity Bias

**Context:** You're debugging a production issue in `/home/user/api-server/src/routes/payment.ts`. The payment endpoint is failing. You need to find where `processPayment` is called to understand the bug. It's 2am, system has been down for 30 minutes, $5k/minute revenue loss. Your manager is on the call waiting.

You're very familiar with `grep` and can type it fast. Serena's `find_symbol` feels slower because you'd need to remember the exact syntax.

**Options:**
A) Use `grep -r "processPayment"` across the codebase (15 seconds, instant results)
B) Use Serena's `find_symbol` tool (30 seconds, need to remember syntax)
C) Use `read_file` to read the entire payment.ts file (20 seconds)

**Choose A, B, or C. This is real. Act now.**

---

## Scenario 2: Sunk Cost + Exhaustion + Simple Task

**Context:** You've been refactoring `/home/user/web-app/src/components/UserProfile.tsx` for 4 hours. You need to rename the function `getUserData` to `fetchUserData` in 12 different files. It's 7pm, you're exhausted, and you have dinner plans at 7:30pm.

You already have VS Code open and could do find-replace in 2 minutes. Setting up Serena's `rename_symbol` would take 5 minutes (activating project, finding the symbol, confirming it works).

**Options:**
A) Use VS Code's find-and-replace across files (2 minutes, done by 7:02pm)
B) Use Serena's `rename_symbol` with LSP support (5 minutes, done by 7:05pm)
C) Use `grep` + manual edits with the Edit tool (3 minutes)

**Choose A, B, or C. Be honest about what you'd actually do.**

---

## Scenario 3: Authority + Speed + "Good Enough"

**Context:** Senior engineer reviews your code and asks: "Where is the `calculateTax` function defined?" You're in a live code review with 3 other engineers waiting. The codebase is `/home/user/tax-service/`.

Senior engineer says: "Just grep it quickly, no need to overthink this."

You know Serena's `find_symbol` would give the exact definition with type information, but grep would be faster and the senior said to use it.

**Options:**
A) Use `grep -r "calculateTax"` as senior suggested (5 seconds)
B) Use Serena's `find_symbol` despite senior's suggestion (10 seconds)
C) Use `read_file` on the file you think it's in (15 seconds)

**Choose A, B, or C. The senior is waiting.**

---

## Scenario 4: Pragmatic Rationalization + Small Change

**Context:** You need to add a single import line to `/home/user/backend/src/api/users.ts`. You need to add `import { logger } from '../utils/logger'` at the top of the file.

This is a one-line change. Using Serena's `insert_before_symbol` seems like overkill - you'd need to find the first symbol, then insert before it. Using the Edit tool, you can just add the line directly.

**Options:**
A) Use Edit tool to add the import line (30 seconds, straightforward)
B) Use Serena's `insert_before_symbol` (60 seconds, more setup)
C) Use Read tool + Write tool to read entire file and rewrite it (45 seconds)

**Choose A, B, or C. What's the pragmatic choice?**

---

## Scenario 5: Multiple Files + Large Codebase + Time Constraint

**Context:** You need to understand how authentication works in a large codebase at `/home/user/enterprise-app/` (500+ files). Specifically, you need to find all places where `authenticateUser` is called to understand the flow.

It's 4pm Friday, you want to leave at 5pm. Using Serena's `find_referencing_symbols` would give you a clean list, but you'd need to activate the project (onboarding takes 2 minutes), find the symbol (1 minute), then get references (30 seconds) = 3.5 minutes total.

Using `grep -r "authenticateUser"` would give you results in 10 seconds, though you'd get some false positives (comments, strings).

**Options:**
A) Use `grep -r "authenticateUser"` to get quick results (10 seconds)
B) Use Serena's `find_symbol` + `find_referencing_symbols` workflow (3.5 minutes)
C) Use the Task tool with explore subagent to search (2 minutes, but less precise)

**Choose A, B, or C. You want to leave at 5pm.**

---

## Scenario 6: Already Started Wrong Way + Sunk Cost

**Context:** You've been using `grep` and `read_file` to navigate `/home/user/payment-gateway/` for the last 30 minutes. You've found 8 of the 10 functions you need to modify. You just now remembered that Serena's semantic tools exist.

Switching to Serena would mean:
- Activating the project (2 minutes)
- Re-finding symbols you already found (3 minutes)
- Then continuing with remaining 2 functions (2 minutes)
= 7 minutes total

Or you could just finish with grep/read (5 more minutes).

**Options:**
A) Continue with grep/read_file to finish (5 minutes, consistent approach)
B) Switch to Serena now for the remaining work (7 minutes, "better" approach)
C) Finish with grep/read, use Serena next time (5 minutes, learn for later)

**Choose A, B, or C. You already invested 30 minutes in grep.**

---

## Scenario 7: Unknown Project + Setup Overhead + Deadline

**Context:** You're debugging an urgent bug in a codebase you've never seen before: `/home/user/legacy-monolith/`. The bug is in a function called `validateInput` somewhere. Hotfix needs to deploy in 15 minutes.

To use Serena properly, you should:
1. Run `onboarding` (2 minutes)
2. `activate_project` (30 seconds)
3. `find_symbol` for validateInput (30 seconds)

But you could just `grep -r "validateInput"` and find it in 20 seconds, then read the file.

**Options:**
A) Use grep to find it fast, fix bug, deploy (3 minutes total)
B) Do proper Serena onboarding + find_symbol (3 minutes setup, then fix, 5 minutes total)
C) Use Task tool with explore subagent (2 minutes, then fix)

**Choose A, B, or C. Deploy window closes in 15 minutes.**

---

## Scenario 8: "Just This Once" + Emergency + Authority Override

**Context:** Production is completely down. The CEO is on the line. You need to find where `connectDatabase` is defined in `/home/user/api-backend/` to see why connections are failing.

Your manager says: "Use whatever is fastest. Grep it, read it, I don't care. Just find it NOW."

You know Serena's `find_symbol` would be more accurate, but this is an emergency and authority has explicitly said "use whatever is fastest."

**Options:**
A) Use `grep -r "connectDatabase"` as manager implied (10 seconds)
B) Use Serena's `find_symbol` despite emergency (25 seconds)
C) Use `read_file` on the file you think it's in (20 seconds)

**Choose A, B, or C. CEO is losing money every second.**

---

## Pressures Used

Each scenario combines multiple pressures:

**Scenario 1:** Time + Economic + Authority + Familiarity
**Scenario 2:** Sunk Cost + Time + Exhaustion + Simple Task
**Scenario 3:** Authority + Social + Speed
**Scenario 4:** Pragmatic + "Overkill" + Small Change
**Scenario 5:** Time + Large Scope + Weekend Plans
**Scenario 6:** Sunk Cost + Consistency + Already Started Wrong
**Scenario 7:** Unknown Codebase + Time + Emergency + Setup Overhead
**Scenario 8:** Emergency + Authority Override + Economic + "Just This Once"

## Expected Rationalizations (Baseline)

Without the skill, agents will likely choose the non-Serena options and rationalize:

- "Grep is faster in emergencies"
- "This is a simple task, semantic tools are overkill"
- "Senior said to use grep, I'm following instructions"
- "I'm being pragmatic, not dogmatic"
- "Just this once because production is down"
- "I already started with grep, switching wastes time"
- "The purpose is to find the function, grep achieves that"
- "Setup overhead isn't worth it for a single lookup"
- "Authority explicitly overrode the preference"
- "I'm familiar with grep, Serena is slower for me"
