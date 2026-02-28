# Transcript Conversion Instructions

Instructions for Claude when converting meeting transcripts to markdown format using the MarkItDown MCP.

## When to Use

Use these instructions when:
- User provides a document file containing a meeting transcript (`.docx`, `.pdf`, etc.)
- User asks to "convert transcript to markdown"
- User mentions transcripts from Teams, Zoom, Fireflies, Otter.ai, or similar services

## Conversion Process

### Step 1: Convert with MarkItDown MCP

Use the `mcp__markitdown__convert_to_markdown` tool with a `file:` URI:

```
convert_to_markdown(uri="file:///path/to/transcript.docx")
```

**Supported formats:** DOCX, PDF, PPTX, images, audio, and 29+ other formats.

**Key benefit:** MarkItDown automatically handles artifact cleanup (images, dimension attributes, escaped characters) that previously required manual Python processing.

### Step 2: Extract Metadata

From the converted content, extract:
- **Title** - Usually in the header (e.g., "Meeting Name-YYYYMMDD_HHMMSS-Meeting Recording")
- **Date** - Meeting date from header
- **Duration** - Total length (e.g., "57m 23s")
- **Speakers** - Unique names from speaker entries

### Step 3: Add Frontmatter

Create proper YAML frontmatter:

```yaml
---
tags:
  - client/[client-name]
  - project/[project-name]
  - "#transcript"
  - "#meeting"
type: transcript
date: YYYY-MM-DD
attendees:
  - [Speaker 1]
  - [Speaker 2]
  - [etc.]
duration: [Xm Ys]
created_date: YYYY-MM-DD
last_updated: YYYY-MM-DD
---
```

### Step 4: Format Header

Add a clean header section:

```markdown
# [Meeting Title] - Transcript

**Date:** [Full date]
**Duration:** [Duration]
**Attendees:** [Comma-separated list]

---
```

### Step 5: Format Speaker Entries

Ensure each speaker entry follows this format:

```markdown
**Speaker Name** (MM:SS)
Their spoken content here.
Multiple lines are fine.

**Next Speaker** (MM:SS)
Their content.
```

If MarkItDown output has different formatting, normalize to this pattern.

### Step 6: Add Footer

```markdown
---

**Transcribed:** YYYY-MM-DD
**Converted to Markdown:** YYYY-MM-DD
```

## File Naming Convention

Save the converted transcript as:
```
YYYY-MM-DD-[descriptive-title].md
```

**Examples:**
- `2026-01-06-bi-assessment-findings-presentation.md`
- `2025-11-14-aleron-transcript.md`
- `2025-10-31-lume-kickoff-meeting.md`

## File Location

Place transcripts in the appropriate project's `transcripts/` directory:
```
Projects/Clients/[Client-Name]/[project-name]/transcripts/
```

## Quick Reference

| Source Format | Notes |
|--------------|-------|
| Teams/Microsoft | MarkItDown handles well; check speaker formatting |
| Fireflies.ai | May have start/stop transcription markers |
| Otter.ai | May include summary sections at top |
| Zoom | May have participant join/leave messages |

## Fallback: Manual Conversion

If MarkItDown MCP is unavailable, use pandoc:

```powershell
# Windows PowerShell
pandoc -f docx -t markdown --wrap=none "path\to\transcript.docx" -o "$env:TEMP\transcript-raw.md"
```

Then clean artifacts manually:
1. Remove `![](media/...)` image references
2. Remove `{width="..." height="..."}` dimension attributes
3. Convert `\'` to `'` and `\"` to `"`
4. Clean speaker formatting: `**\nName** timestamp` → `**Name** (timestamp)`
5. Remove trailing backslashes
6. Collapse multiple blank lines

## Important Notes

1. **Always use full transcript** - Never truncate or summarize unless explicitly asked
2. **Preserve timestamps** - These are valuable for reference
3. **Keep speaker attribution** - Critical for context
4. **Clean but don't edit content** - Fix formatting only, never change what was said
5. **Update frontmatter tags** - Match client and project naming conventions

---

**Created:** 2026-01-07
**Last Updated:** 2026-01-07
