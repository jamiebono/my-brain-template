# Transcript Processing

Lightweight transcript-to-meeting-notes pipeline. Accepts a file path, converts if needed, and produces structured meeting notes with action items.

**Arguments:** $ARGUMENTS (file path to transcript, or "latest" to find most recent)

## Core Philosophy

- **Never truncate** — Use the FULL transcript, every word
- **Structure over summary** — Extract decisions, action items, quotes
- **Mark uncertainty** — Tag unclear items with `[verify]`
- **Update downstream** — Push action items to `todo.md`, update person files in `network/`

## Workflow

### 1. Locate the File

If `$ARGUMENTS` is a file path:
- Check if the file exists at the given path
- Try common locations if bare filename: `Transcripts/`, `Recordings/`, project `meetings/meeting_transcripts/` directories

If `$ARGUMENTS` is "latest" or empty:
- Glob `Transcripts/*.docx` and `Transcripts/*.md` — pick most recent by date prefix or modification time
- Also check `Recordings/` for recent files

### 2. Convert if Needed

**If `.docx`, `.pdf`, or other non-markdown format:**
Use MarkItDown MCP to convert:
```
mcp__markitdown__convert_to_markdown(uri="file:///[absolute-path-to-file]")
```

**If already `.md`:**
Read the file directly.

**Path encoding for WSL:** Use forward slashes, URL-encode spaces:
```
file:///path/to/your/files
```

See `.claude/instructions/transcript-conversion.md` for detailed conversion rules and format-specific handling.

### 3. Extract Metadata

From the transcript content, extract:
- **Meeting title** — From header or filename
- **Date** — From header, filename pattern `YYYY-MM-DD`, or content timestamps
- **Duration** — If stated in header
- **Attendees** — All unique speaker names
- **Client/Project** — Infer from attendees (search `network/` person files for company/project associations), meeting title, or content clues

### 4. Determine Output Location

Based on client/project identification:
```
Projects/Clients/[Client]/[project]/meetings/meeting_notes/YYYY-MM-DD-[title].md
```

If client/project unclear, ask the user or place in:
```
Transcripts/YYYY-MM-DD-[title]-notes.md
```

### 5. Generate Structured Notes

Create meeting notes following the `tpl-meeting.md` structure but adapted for transcript processing:

- Frontmatter: tags, type (meeting-notes), source (transcript), meeting_date, attendees, duration
- Executive Summary (3-5 sentences)
- Key Discussion Points (organized by topic)
- Decisions Made (table: Decision | Owner | Context)
- Action Items split into Our Commitments and Their Commitments (checkboxes with owner and due date)
- Notable Quotes (2-5 verbatim quotes worth preserving)
- Open Questions (items needing clarification, tagged with [verify] where uncertain)
- Source link and processing date footer

### Quality Rules

- **Decisions:** Extract EVERY decision, even small ones. Identify who made or approved it.
- **Action items:** Extract EVERY commitment. "I'll send that over" = action item. "We should look into that" = action item.
- **Quotes:** Preserve 2-5 notable quotes verbatim — things that capture tone, reveal priorities, or would be useful to reference later.
- **[verify] tags:** Use for anything where the transcript was unclear, a name was garbled, or context is ambiguous.
- **Wiki-links:** Link attendee names as `[[Name]]` if they have a person file in `network/`.

### 6. Update Downstream Files

**todo.md:**
- Add action items under appropriate project section or "Incoming" section
- Format as `- [ ] [Client/Project] [Action] (from [meeting date] meeting)`

**network/ person files:**
- Update `last_contact` date in YAML frontmatter for any attendee with an existing person file in `network/`
- If attendee has NO person file in `network/`, create a minimal stub file using `tpl-person-light` with company, role (if mentioned), `last_contact` date, `met_via` (meeting title), and `needs_research: true`

### 7. Output Summary

After processing, display:

```
TRANSCRIPT PROCESSED

Meeting: [Title]
Date: [Date]
Attendees: [Count] ([X] in network/, [Y] new)

Files:
- Notes: [path to generated notes file]
- Source: [path to original transcript]

Updates:
- todo.md: [X] action items added
- network/: [X] person files updated, [Y] stubs created

Items tagged [verify]: [count]
```

## Edge Cases

| Scenario | Handling |
|----------|----------|
| Multiple meetings in one transcript | Split into separate note files |
| No clear attendee names | Use "Speaker 1", "Speaker 2" and tag all with `[verify]` |
| Very short transcript (<5 min) | Still produce full structure; note brevity in summary |
| Non-English content | Process as-is; note language in frontmatter |
| Garbled audio sections | Mark with `[inaudible]` or `[verify]` |

## Examples

```
/transcript Transcripts/2026-02-10-weekly-sync.docx
/transcript latest
/transcript ~/Downloads/meeting-recording.docx
```
