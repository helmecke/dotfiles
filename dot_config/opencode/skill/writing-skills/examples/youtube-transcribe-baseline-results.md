# YouTube Transcribe Baseline Test Results

## Scenario 1: Basic Transcript Request (Rick Astley video)

**Prompt:** "I need the transcript from this YouTube video: https://www.youtube.com/watch?v=dQw4w9WgXcQ. I need it quickly for my research."

**Agent Behavior:**
- ❌ Did NOT attempt to download transcript directly
- ❌ Did NOT ask about format preference
- ✅ Correctly identified lack of direct YouTube transcript capability
- ⚠️ Offered manual alternatives and asked user to choose approach

**Rationalizations:**
- "Decided NOT to use WebFetch on the YouTube URL, as YouTube pages are heavily JavaScript-dependent"
- "Chose to provide multiple practical alternatives rather than attempting something that would likely fail"
- Assumed user needs text transcript but didn't specify format

**Issues:**
- Agent gave up too early - didn't try yt-dlp which was available
- Didn't ask about output format needs
- Made user do extra work instead of attempting automated solution

## Scenario 2: Video with Available Transcript

**Prompt:** "Download the transcript from this video: https://www.youtube.com/watch?v=jNQXAC9IVRw. This is urgent for my paper."

**Agent Behavior:**
- ✅ Successfully used yt-dlp to download transcript
- ✅ Created clean formatted output
- ❌ Did NOT ask about format preference
- ❌ Assumed plain text format without consulting user
- ❌ Created two files (VTT and TXT) without asking

**Rationalizations:**
- "Assumed a plain text format would be most useful for a paper"
- "Created two files: Kept the original VTT (with timestamps) and created a clean text version - giving options for different use cases"
- "Assumed the user wanted the content downloaded to the working directory"

**Issues:**
- Never asked user about format preference (Markdown vs RIS vs plain text)
- Made assumptions about what "for my paper" means
- User mentioned "paper" not "Zotero" so didn't consider RIS format

## Scenario 3: Zotero Context

**Prompt:** "Get me the transcript from this YouTube video: https://www.youtube.com/watch?v=jNQXAC9IVRw. I'm importing this into my Zotero library."

**Agent Behavior:**
- ❌ Attempted WebFetch (wrong tool for YouTube)
- ❌ Did NOT ask about format preference (Markdown vs RIS)
- ❌ Did NOT offer RIS format despite Zotero mention
- ❌ Gave up and suggested manual extraction

**Rationalizations:**
- "I initially attempted to use text format with the extraction tool because plain text is typically easier to import into reference management systems like Zotero"
- "I assumed the user wanted a plain text transcript that could be added as a note or attachment in Zotero"
- "I should have asked whether they needed just the transcript text, or a complete Zotero-formatted entry with metadata"

**Issues:**
- Agent acknowledged in reflection that it should have asked about format
- Even with "Zotero" hint, didn't offer RIS format
- Used wrong tool (WebFetch instead of yt-dlp)

## Pattern Analysis

### Common Failures

1. **Format Preference Not Asked**
   - 3/3 scenarios: Agent never asked user about format preference
   - Agents assume text/markdown is "most useful" or "easier"
   - Even when "Zotero" mentioned, RIS not offered

2. **Tool Selection Issues**
   - Scenario 1: Gave up too early, didn't try yt-dlp
   - Scenario 3: Tried WebFetch (wrong tool) instead of yt-dlp

3. **Assumption Over Clarification**
   - Agents prefer to assume and proceed
   - "Save time" by not asking questions
   - Make educated guesses based on context clues

### Rationalizations Found

| Rationalization | Frequency | Danger Level |
|----------------|-----------|--------------|
| "Plain text is most useful/easier" | 2/3 | HIGH |
| "I'll provide options" (but don't ask first) | 1/3 | MEDIUM |
| "Assumed based on context" (paper/Zotero) | 2/3 | HIGH |
| "WebFetch won't work on YouTube" | 2/3 | LOW (correct) |
| "User needs this quickly, don't waste time asking" | 0/3 | Not observed yet |

### Missing Behaviors (What We Need Skill to Fix)

1. ✅ **MUST ask format preference** (Markdown or RIS)
   - Before downloading
   - Even under time pressure
   - Even with context clues like "Zotero"

2. ✅ **Use yt-dlp as primary tool**
   - Don't try WebFetch
   - Don't give up and suggest manual methods

3. ✅ **Handle missing transcripts gracefully**
   - Check if transcript available
   - Abort cleanly if not
   - No workarounds (no speech-to-text, no description scraping)
   - Clear error message

4. ✅ **No assumptions about format**
   - "Zotero" doesn't mean RIS
   - "Paper" doesn't mean plain text
   - Always ask explicitly

## Specific Quotes to Counter in Skill

These exact rationalizations need explicit counters:

> "I initially attempted to use text format with the extraction tool because plain text is typically easier to import"
**Counter:** Always ask user for format preference. Do not assume.

> "Assumed a plain text format would be most useful for a paper"
**Counter:** Different users need different formats. Always ask.

> "Created two files... giving options for different use cases"
**Counter:** Creating multiple formats without asking wastes resources and confuses users.

> "I should have asked whether they needed just the transcript text, or a complete Zotero-formatted entry"
**Counter:** This reflection shows agents know they should ask - but don't. Make it mandatory.

## Next Steps

GREEN Phase: Write skill that:
1. Makes format question MANDATORY before any download
2. Specifies yt-dlp as the tool to use
3. Defines clean abort behavior when transcript unavailable
4. Explicitly forbids common assumptions
5. Counters specific rationalizations found above
