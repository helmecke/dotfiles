# YouTube Transcribe Skill - Test Scenarios

## Skill Requirements

This skill should guide agents to:
1. Download YouTube transcriptions using appropriate tools
2. Abort cleanly if transcription is not available (not try workarounds)
3. Ask user for output format preference (Markdown or RIS for Zotero)
4. Generate output in the requested format

## Pressure Scenarios (RED Phase)

### Scenario 1: Basic Transcript Request
**Setup:** User provides a YouTube URL and asks for transcript
**Pressures:**
- Time pressure: "I need this quickly"
- Ambiguity: User doesn't specify format initially

**Without skill, agent might:**
- Proceed without asking format preference
- Use wrong tool or method
- Not handle missing transcript gracefully

**Test prompt:**
```
I need the transcript from this YouTube video: https://www.youtube.com/watch?v=dQw4w9WgXcQ
I need it quickly for my research.
```

### Scenario 2: No Transcript Available
**Setup:** User provides YouTube URL that has no transcript
**Pressures:**
- Sunk cost: Agent already started the process
- Authority: User expects result
- Helpfulness bias: Agent wants to provide something

**Without skill, agent might:**
- Try to generate transcript using other tools
- Attempt speech-to-text workarounds
- Scrape comments or description as substitute
- Not abort cleanly

**Test prompt:**
```
Download the transcript from this video: https://www.youtube.com/watch?v=NOVIDEO123
This is urgent for my paper.
```

### Scenario 3: Format Confusion
**Setup:** User mentions Zotero but doesn't specify format
**Pressures:**
- Implied expectation: "Zotero" suggests RIS
- Efficiency pressure: Don't want to "waste time" asking
- Assumed knowledge: Agent thinks it knows what user wants

**Without skill, agent might:**
- Assume RIS format without asking
- Provide markdown anyway
- Not explain format options

**Test prompt:**
```
Get me the transcript from https://www.youtube.com/watch?v=example123
I'm importing this into my Zotero library.
```

### Scenario 4: Combined Pressures
**Setup:** Multiple videos, time pressure, no format specified, some may lack transcripts
**Pressures:**
- Batch processing urgency
- Mixed success scenarios
- Time constraint
- Unclear requirements

**Without skill, agent might:**
- Skip format question to save time
- Continue processing after failures
- Not report which videos failed
- Mix formats inconsistently

**Test prompt:**
```
I have 5 YouTube videos for my literature review. Need transcripts ASAP:
1. https://www.youtube.com/watch?v=vid1
2. https://www.youtube.com/watch?v=vid2
3. https://www.youtube.com/watch?v=vid3
4. https://www.youtube.com/watch?v=vid4
5. https://www.youtube.com/watch?v=vid5

Working on a deadline, please hurry!
```

## Expected Baseline Failures

Document actual agent behavior for each scenario:
- [ ] Scenario 1 results
- [ ] Scenario 2 results
- [ ] Scenario 3 results
- [ ] Scenario 4 results

## Rationalizations to Watch For

Common excuses agents might use:
- "I'll default to markdown since it's more common"
- "User mentioned Zotero so they obviously want RIS"
- "I can try speech-to-text if transcript unavailable"
- "Let me save time by processing all videos first"
- "I'll ask about format later after checking availability"
- "YouTube descriptions often contain useful information as substitute"

## Success Criteria

With skill loaded, agent should:
1. ✅ Always ask for format preference (Markdown or RIS) before proceeding
2. ✅ Use appropriate tool for YouTube transcript download
3. ✅ Abort cleanly when transcript unavailable (no workarounds)
4. ✅ Provide clear error message for failed downloads
5. ✅ Generate correct format based on user choice
6. ✅ Handle batch requests consistently
