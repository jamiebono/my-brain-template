# Client Project Conventions

Instructions for working within client project directories. This structure is optimized for AI agent clarity with predictable paths and consistent conventions.

**Location:** `Projects/Clients/[Client-Name]/[project-name]/`

## Canonical Directory Structure

Each client follows this hierarchy:

```
[Client-Name]/
├── client-overview.md              # Client relationship brief, contacts, history, health
└── [project-name]/                 # Individual project folder (lowercase-with-hyphens)
    ├── project-brief.md            # Status, scope, risks, deliverables
    ├── project_TODO.md             # Project-specific task list (aggregated by the Strategic Advisor)
    ├── email/
    │   ├── in/                     # Incoming relevant emails
    │   └── out/                    # Outbound email drafts
    └── meetings/
        ├── meeting_notes/          # YYYY-MM-DD-title.md (structured notes)
        └── meeting_transcripts/    # scribe-YYYY-MM-DD-title.md (raw transcripts)
```

**Reference:** See `templates/tpl-client-overview.md` and `templates/tpl-project-brief.md` for structure templates.

## Before Making Changes

1. **Read `client-overview.md`** - Understand the client relationship, key contacts, and engagement history
2. **Read `project-brief.md`** - Check current status, active risks, and recent decisions
3. **Check `network/`** folder - Look up person files for anyone mentioned for context
4. **Check `project_TODO.md`** - See project-specific tasks and blockers

## File Locations & Naming

| File Type | Location | Naming Pattern |
|-----------|----------|----------------|
| Client overview | `[Client]/client-overview.md` | Always this exact name |
| Project brief | `[Client]/[project]/project-brief.md` | Always this exact name |
| Project TODO | `[Client]/[project]/project_TODO.md` | Always this exact name |
| Meeting notes | `[Client]/[project]/meetings/meeting_notes/` | `YYYY-MM-DD-descriptive-title.md` |
| Transcripts | `[Client]/[project]/meetings/meeting_transcripts/` | `scribe-YYYY-MM-DD-title.md` |
| Incoming email | `[Client]/[project]/email/in/` | `YYYY-MM-DD-from-subject.md` |
| Outgoing email | `[Client]/[project]/email/out/` | `YYYY-MM-DD-to-subject.md` |
| Deliverables | `[Client]/[project]/` (root) | `YYYY-MM-DD-deliverable-name.md` |

## Creating New Files

### New Client
```bash
# Use template: tpl-client-overview.md
# Creates: [Client]/client-overview.md
```

### New Project
```bash
# Use template: tpl-project-brief.md (creates folder structure + brief)
# Use template: tpl-project-todo.md (creates project_TODO.md)
# Structure: [Client]/[project]/
```

### Meeting Notes
```bash
# Use templates: tpl-meeting.md, tpl-discovery-session.md, or tpl-1on1.md
# Location: [project]/meetings/meeting_notes/YYYY-MM-DD-title.md
```

### Transcripts
```bash
# Processed from Scribe recordings
# Location: [project]/meetings/meeting_transcripts/scribe-YYYY-MM-DD-title.md
```

## Frontmatter Requirements

All client project files must include:
```yaml
---
tags:
  - "#client/[client-name]"
  - "#project/[project-name]"
type: project-brief | project-todo | meeting | client-overview
status: active | on-hold | completed
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
---
```

## Project TODO Conventions

Each project has its own `project_TODO.md` with:
- **🔴 Must Do (This Week)** - Critical tasks
- **🟡 Should Do (This Sprint)** - Important but not urgent
- **🟢 Could Do (Backlog)** - Nice to have
- **⏳ Waiting On** - Blocked items table

**the Strategic Advisor aggregates 🔴 items during `/daily`** - these bubble up to global awareness without duplicating into `todo.md`.

## Agent Responsibilities

| Agent | Role in Client Projects |
|-------|------------------------|
| **the Strategic Advisor** | Aggregates project TODOs, strategic overview, handoffs |
| **the Meeting Maestro** | Meeting prep/notes in `meetings/` folders |
| **the Relationship Manager** | Client research, `client-overview.md` updates |
| **Curator** | `project-brief.md` maintenance |

## Sensitive Information

- Never include passwords, API keys, or credentials in markdown files
- Use `[REDACTED]` or `[see secure storage]` for sensitive references
- Client financial details should reference external systems, not be stored here

## Updating Project Status

When project status changes:
1. Update `project-brief.md` status field and summary
2. Update `project_TODO.md` if tasks are impacted
3. Update `roadmap.md` (root) if milestones affected
4. Consider if `client-overview.md` needs a health/relationship update

## Migration Notes

Existing projects may have legacy structures (e.g., `Transcripts/` instead of `meetings/meeting_transcripts/`). During reorganization:
1. Create the standard directory structure
2. Move files to canonical locations
3. Delete empty legacy folders
4. Verify wiki-links still work
