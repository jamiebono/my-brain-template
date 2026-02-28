# Digest

"What did I miss?" — Catch-up intelligence summary for after travel, PTO, or busy client days.

**Arguments:** $ARGUMENTS (optional date range, e.g., "last 3 days", "2026-02-05 to 2026-02-07", "since Monday")

## Core Philosophy

- **Triage, not strategy** — Categorize and prioritize, don't plan
- **READ-ONLY** — This command gathers intelligence but creates NO files
- **Sender-aware** — Who sent it matters as much as what they sent
- **Project-linked** — Cross-reference everything against active projects

## Default Behavior

If no date range specified, default to **last 2 days** from today.

Parse `$ARGUMENTS` to determine the date range:
- "last N days" — N days back from today
- "since Monday" / "since [day]" — Calculate from day name
- "YYYY-MM-DD to YYYY-MM-DD" — Explicit range
- "yesterday" — Just yesterday
- No argument — Last 2 days

## Workflow

### 1. Gather Emails

Glob `email_and_calendar_context/emails/*.md` for files within the date range:
- Parse date from filename prefix (YYYY-MM-DD) or frontmatter `date` field
- Read each matching email file
- Extract: sender, subject, date, TO/CC fields, body summary

### 2. Gather Calendar Events

Glob `email_and_calendar_context/calendar/*.md` for events within the date range:
- Parse date from frontmatter or content
- Extract: event title, date/time, attendees, description
- Flag any meetings that occurred (potential action items generated)

### 3. Classify Senders

Cross-reference every sender against person files in `network/` (search by name, email, or `aliases` in YAML frontmatter):

| Tier | Definition | Priority |
|------|-----------|----------|
| **Tier 1: Clients & Executives** | Contacts with `relationship_type: client` in person file, in active project client-overview.md, or with roles containing VP/Director/C-suite/Partner | Highest |
| **Tier 2: Internal & Known** | your team members, contacts with recent interactions (`last_contact` <30 days), known collaborators | High |
| **Tier 3: Standard** | Contacts with a person file in `network/` but not Tier 1 or 2 | Medium |
| **Unknown** | Senders with NO person file in `network/` | Flag for review |

### 4. Cross-Reference Against Active Projects

For each email/event:
- Check if sender is associated with an active project (via client-overview.md or `company` field in their `network/` person file)
- Check if subject or content mentions active project names
- Tag with project name if matched

### 5. Categorize Items

Sort all gathered items into four categories:

**Action Required:**
- Emails with questions directed at user
- Emails requesting decisions or approvals
- Meeting follow-ups with action items assigned to user
- Items from Tier 1 senders always elevated here if any action signal exists

**Project Updates:**
- Status updates on active projects
- Meeting notes or summaries from project meetings
- Deliverable submissions or reviews

**FYI / Informational:**
- CC'd emails
- Company-wide announcements
- Newsletter-type content
- Calendar invites for future dates

**Missed Meetings:**
- Calendar events in the date range where user was an attendee
- Flag if meeting notes exist (check project meeting_notes folders)
- Flag if transcript exists (check Transcripts/ or project transcripts folders)
- Suggest: "Run `/transcript [file]` to process" if unprocessed transcript found

### 6. Generate Prioritized Summary

## Output Format

```
DIGEST - [Start Date] to [End Date]

Covering [X] emails, [Y] calendar events over [N] days

---

ACTION REQUIRED ([count]):

[Tier 1 items first, then Tier 2, then others]
- [Sender] ([Tier]) | [Subject] | [Date]
  What's needed: [Brief description of required action]
  Project: [Project name if matched]

- [Sender] ([Tier]) | [Subject] | [Date]
  What's needed: [Brief description]

---

PROJECT UPDATES ([count]):

[Client] / [Project]:
- [Date]: [Summary of update]
- [Date]: [Summary of update]

[Client] / [Project]:
- [Date]: [Summary of update]

---

FYI ([count]):
- [Sender]: [Subject] — [One-line summary]
- [Sender]: [Subject] — [One-line summary]

---

MISSED MEETINGS ([count]):
- [Date] [Time]: [Meeting title]
  Attendees: [List]
  Notes available: [Yes — link / No]
  Transcript: [Available — run /transcript / Not found]

---

UNKNOWN SENDERS ([count]):
- [Sender email]: [Subject] — consider creating person file in network/
```

## Rules

- **No file creation** — This is read-only intelligence gathering
- **No file modification** — Don't update todo.md, network/ person files, or anything else
- **Suggest, don't do** — If action is needed (like processing a transcript), suggest the command but don't run it
- **Brevity over completeness** — One line per FYI item, 2-3 lines max per Action Required item
- **Skip empty categories** — If no items in a category, don't show it

## Edge Cases

| Scenario | Handling |
|----------|----------|
| No emails in date range | Show "No emails found for this period" |
| No calendar events | Skip Missed Meetings section |
| Very large volume (>50 emails) | Summarize Tier 3 and Unknown; detail Tier 1 and 2 only |
| Sender in multiple projects | List primary project, note secondary |
| Future calendar events in range | Include in FYI, not Missed Meetings |

## Examples

```
/digest
/digest last 3 days
/digest since Monday
/digest 2026-02-03 to 2026-02-07
/digest yesterday
```
