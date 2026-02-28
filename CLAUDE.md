# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

An AI-augmented personal operating system built on Obsidian. Implements "Feed the Beast" pattern - structured markdown files as single source of truth for AI agents to read and act upon. Manages consulting projects, task tracking, strategic planning, professional network, and outreach.

## Quick Start

1. **Use slash commands** for common workflows (see list below)
2. **Let agents do specialized work**: Strategic Advisor for strategy, Meeting Maestro for meetings, Relationship Manager for network, Vault Organizer for organization
3. **Follow templates**: Always use templates from `templates/` when creating new documents
4. **Keep files updated**: Core files (`todo.md`, `roadmap.md`, `network/` person files) are your single source of truth
5. **Trust the structure**: File naming, frontmatter, and directory organization enable agent intelligence

Key workflow patterns: `/daily` for strategic briefs, `/time` for time tracking, `/briefing [attendee]` for meeting prep, `/push` for git commits.

## Slash Commands (`.claude/commands/`)

- `/daily` - Daily strategic brief with priorities and friction removal. Modes: `--quick` (Pass 1 only), `standup` (read-only async standup)
- `/weekly` - Weekly review and planning with 7-phase reflection framework. Includes network refresh from email/calendar
- `/briefing` - Professional briefings (meetings, people, companies, topics, projects) with branded output. `--sales` flag for prospect/pipeline briefings, `--disc` for communication style assessment
- `/outreach` - Draft and manage outreach messages with strategic messaging guidance
- `/push` - Auto-commit and push changes with generated commit message
- `/time` - Time tracking reconciliation and reporting
- `/status` - Weekly client status report generator across active projects
- `/health` - Vault health check
- `/onboarding` - Client/project onboarding workflow
- `/transcript` - Process meeting transcripts into structured notes with action items
- `/digest` - "What did I miss?" catch-up summary for emails and calendar
- `/proposal` - Proposal / SOW generator
- `/retro` - Project retrospective
- `/setup` - First-time vault personalization wizard (name, org, brand colors, MCP config)
- `/personalize` - Update specific personalization settings (colors, agents, mcp, branding, identity)

## Skills (`.claude/skills/`)

Skills are conversational capabilities and text transformations (not file-producing workflows):

- **de-ai-ify** - Remove AI-generated jargon and restore human voice. Trigger: "de-AI-ify", "humanize this", "make this sound human"
- **thinking-partner** - Collaborative exploration of complex problems. Trigger: "think through", "brainstorm", "help me explore"
- **linkedin-post** - Draft LinkedIn posts in your authentic voice. Trigger: "write a LinkedIn post"

## Architecture

### Key Files
- `todo.md` - Daily task tracking with checkboxes
- `roadmap.md` - Strategic milestones and quarterly planning
- `network.md` - Professional network Dataview index (dashboard)
- `network/` - Individual person files (one per contact, with YAML frontmatter)
- `outreach.md` - Message drafts and tracking

### System Files (Agent Infrastructure)
- `agent-handoff-log.md` - Context preservation for agent-to-agent delegation
- `recurring-tasks.md` - Pattern definitions for automatically surfacing recurring tasks

### Directory Structure

```
.claude/                    # Claude Code configuration
  agents/                   # Specialized agent definitions
  commands/                 # Slash command implementations
  instructions/             # Processing instructions (transcripts, etc.)
  settings.local.json       # Claude Code settings

.github/
  workflows/                # GitHub Actions (vault health checks)

Projects/
  Clients/                  # Client project hierarchy
    [Client-Name]/
      client-overview.md    # Client relationship brief
      [project-name]/       # Individual project folder
        project-brief.md    # Project status brief
        project_TODO.md     # Project-specific task list
        email/
          in/               # Incoming relevant emails
          out/              # Outbound email drafts
        meetings/
          meeting_notes/    # YYYY-MM-DD-title.md (structured notes)
          meeting_transcripts/  # scribe-YYYY-MM-DD-title.md (raw)
  Internal/                 # Internal projects

network/                    # Individual person/contact files (one per contact)

templates/                  # Templater templates for Obsidian
  snippets/                 # Reusable template fragments
  quarto-brand/             # Branded document generation (PDF/HTML/DOCX, customizable)

logs/
  daily/                    # Daily briefs (YYYY-MM-DD-daily-brief.md)
  weekly/                   # Weekly reviews (YYYY-WW.md)
  quarterly/                # Quarterly reviews (YYYY-QN.md)
  maintenance/              # Auto-generated vault health reports (YYYY-MM-DD-maintenance.md)

Assets/                     # Images and media files
Excalidraw/                 # Diagrams and drawings
Recordings/                 # Audio recordings
Transcripts/                # Meeting transcripts
utils/                      # Utility scripts and tools
  md_to_docx.py             # Markdown to branded Word converter
```

## Template System

**Use templates** when creating new documents. Templates live in `templates/` and use Templater syntax.

### Core Templates
| Template | Use Case | Location |
|----------|----------|----------|
| `tpl-daily-brief` | Daily strategic planning | Triggered by Calendar plugin or manually |
| `tpl-weekly-review` | 7-phase weekly reflection | Run Sundays or end of week |
| `tpl-quarterly-review` | Strategic quarterly planning | End of quarter |
| `tpl-meeting` | General meeting capture | Any meeting |
| `tpl-discovery-session` | Client discovery calls | New client/project exploration |
| `tpl-1on1` | 1:1 meetings | Recurring check-ins |
| `tpl-client-overview` | New client setup | When onboarding client |
| `tpl-project-brief` | New project setup | When starting project |
| `tpl-project-todo` | Project task tracking | With project-brief for new projects |
| `tpl-person` | Full contact profile (detailed) | Key network additions |
| `tpl-person-light` | Lightweight contact profile | Quick adds, migration |

### Snippets (Inline Templates)
Located in `templates/snippets/` - use with `Ctrl/Cmd + Shift + T`:
`update-timestamp`, `quick-action`, `quick-meeting-capture`, `standup`, `time-entry`, `decision-log-entry`, `risk-issue-entry`, `callout`

## Document Export

**HTML (preferred for deliverables with code blocks, tables, or diagrams):**
```bash
quarto render <input>.qmd --to html
```
Uses Quarto with brand SCSS theme. Produces self-contained HTML with `embed-resources: true`. Mermaid diagrams render natively via Quarto's built-in handler — do NOT inject external mermaid CDN scripts.

**Word (simple documents without code blocks):**
```bash
python utils/md_to_docx.py <input.md> <output.docx>
```
Applies corporate styles via template at `templates/quarto-brand/assets/brand-reference.docx`. Note: does not render fenced code blocks or mermaid diagrams.

**PDF:** `quarto render <input>.qmd --to pdf` (uses Typst, no LaTeX required). Mermaid diagrams in PDF require Chromium.

### Quarto QMD Frontmatter Template

When creating a `.qmd` file for export, use this frontmatter:
```yaml
---
title: "Document Title"
subtitle: "Subtitle"
author: "Your Organization"
date: "Month Year"
format:
  html:
    theme:
      - default
      - <relative-path-to>/templates/quarto-brand/themes/brand-theme.scss
    toc: true
    toc-depth: 3
    number-sections: false
    embed-resources: true
    include-after-body: []
mermaid:
  theme: neutral
---
```

**Critical:** Always include `include-after-body: []` to prevent the vault-root `_quarto.yml` from injecting scripts that conflict with Quarto's built-in mermaid renderer.

### Mermaid in Quarto

Use ```` ```{mermaid} ```` code fences (not bare ```` ```mermaid ````). Quarto handles rendering automatically. Avoid special characters (parentheses, colons) in ER diagram entity aliases — they break the parser.

See `CLAUDE.local.md` for detailed style mapping and Quarto configuration.

## Specialized Agents (`.claude/agents/`)

6 specialized AI agents, each with distinct expertise:

<!-- Customize: Give each agent a personality that motivates you! The original system uses fictional character personas. -->

### Agent Quick Reference

| Need | Agent |
|------|-------|
| Strategy, decisions, reviews | **Strategic Advisor** |
| Meetings, transcripts, agendas | **Meeting Maestro** |
| Contacts, research, relationships | **Relationship Manager** |
| Vault organization, tags, links | **Vault Organizer** |
| Document editing, proofreading | **Editorial Agent** |
| Perfectionism intervention | **Pragmatist** |

### Strategic Advisor (`strategic-advisor.md`)
Executive chief of staff and team lead. Daily/weekly strategic reviews, network management, outreach strategy, agent coordination, high-stakes decisions. Boss of the agent team. Owns BOD/EOD memory routines (Section 7).

### Meeting Maestro (`meeting-maestro.md`)
Meeting lifecycle management: prep, capture, transcript processing, action item extraction. Uses `tpl-meeting.md`, `tpl-discovery-session.md`, `tpl-1on1.md`. Creates tasks from action items.

### Relationship Manager (`relationship-manager.md`)
Network intelligence: contact research/OSINT, person file maintenance in `network/` folder, project onboarding, meeting participant briefings. Uses `tpl-client-overview.md`, `tpl-project-brief.md`, `tpl-person.md`/`tpl-person-light.md`. Maintains relationship graph and proactive research protocol.

### Vault Organizer (`vault-organizer.md`)
Vault organization: directory restructuring, tag standardization, backlink fixes, frontmatter management, orphan note handling.

### Editorial Agent (`editorial-agent.md`)
Writing review and editorial excellence: grammar, clarity, tone adjustment, proofreading client-facing communications.

### Pragmatist (`pragmatist-agent.md`)
Reality checks: perfectionism intervention, decision paralysis breaking, over-engineering detection, scope creep alerts. "It's fine. Ship it."

## Agent Coordination System

Agents work as a team with the Strategic Advisor as coordinator. Context preservation is critical.

**Handoff Protocol:** The Strategic Advisor writes to `agent-handoff-log.md` before delegating (strategic context, discoveries, desired outcomes, relevant files). Receiving agent reads log, updates status to "In Progress," then completes with findings.

**Recurring Tasks:** `recurring-tasks.md` defines weekly, monthly, project-triggered, and event-triggered task patterns. The `/daily` command processes this file to surface due tasks.

**Template Auto-Population:** Use `templates/snippets/attendee-context-lookup.md` to pre-populate meeting notes with context from person files in `network/` and previous meetings.

## Document Conventions

### Frontmatter
```yaml
---
tags:
  - "#tag-name"
status: active|planned|completed
created_date: YYYY-MM-DD
last_updated: YYYY-MM-DD
---
```

### Naming
- Dates: YYYY-MM-DD format
- Client Folders: Title-Case-With-Hyphens (e.g., `Cambridge-Associates`)
- Project Folders: lowercase-with-hyphens (e.g., `box-sharepoint-analysis`)
- Files: lowercase-with-hyphens, date-prefixed where applicable
- Tags: lowercase with hyphens

### Semantic Filenames
| Type | Pattern | Example |
|------|---------|---------|
| Client Overview | `client-overview.md` | `client-overview.md` |
| Project Brief | `project-brief.md` | `project-brief.md` |
| Meeting Notes | `YYYY-MM-DD-[title].md` | `2025-11-25-sow-review-debrief.md` |
| Deliverables | `YYYY-MM-DD-[name].md` | `2025-11-20-architecture-blueprint.md` |

### Linking
Use Obsidian wiki-style links: `[[filename]]`

### Tag Taxonomy

Use these standardized tags. **Avoid creating new variations** -- consolidate under these categories.

| Category | Standard Tag | Use For |
|----------|-------------|---------|
| **Document Type** | `#meeting` | All meeting notes, interviews |
| | `#project` | Project briefs, deliverables |
| | `#todo` | Task lists |
| | `#note` | General notes |
| **Work Type** | `#consulting` | Client work |
| | `#internal` | Internal projects |
| **Technology** | `#ai` | All AI/ML topics |
| | `#data` | Data strategy, warehouses, mesh, fabric |
| | `#bi` | Business intelligence |
| | `#sharepoint` | SharePoint/M365 work |
| | `#security` | Security topics |
| **Client Tags** | `#client/[name]` | Client-specific (e.g., `#client/acme-corp`) |
| **Project Tags** | `#project/[name]` | Project-specific (e.g., `#project/data-platform-migration`) |

See CLAUDE.local.md for deprecated tag mappings.

## MCP Servers

| Server | Purpose |
|--------|---------|
| **basic-memory** | Cross-session memory — indexes entire vault as source of truth |
| **Filesystem** | Batch file reads, directory trees, advanced file management |
| **MarkItDown** | Convert DOCX, PDF, PPTX to clean markdown |
| **GitHub** | PRs, issues, code search, releases |

See `.mcp.json.example` for configuration. Add task management, calendar, or other MCP servers as needed.

See CLAUDE.local.md for detailed MCP integration guidelines, tool lists, and daily memory routines.

## Working with Projects

Projects are organized in a nested Client/Project hierarchy under `Projects/Clients/`. Each client folder has `client-overview.md` and project subfolders (lowercase, hyphenated). Each project folder has `project-brief.md` with YAML frontmatter, dated files for meetings/deliverables, and a footer with timestamps. Internal projects go under `Projects/Internal/`.

## Critical: Creating New Documents

**ALWAYS use the appropriate template from `templates/` when creating new documents.** Do not freestyle document structure.

### Template Mapping
| Request | Template to Use |
|---------|----------------|
| "prep for meeting" / "create meeting notes" | `tpl-meeting.md` |
| "discovery call" / "new client meeting" | `tpl-discovery-session.md` |
| "1:1 notes" / "check-in meeting" | `tpl-1on1.md` |
| "new project" | `tpl-project-brief.md` + `tpl-project-todo.md` |
| "project tasks" / "project todo" | `tpl-project-todo.md` |
| "new client" | `tpl-client-overview.md` |
| "daily brief" | `tpl-daily-brief.md` |
| "weekly review" | `tpl-weekly-review.md` |
| "status report" / "weekly status" | `tpl-status-report.md` |

**Never create an ad-hoc meeting document structure. Always match the template.**

Meetings follow a three-phase workflow (Before/During/After) with the Meeting Maestro and Scribe. See CLAUDE.local.md for the detailed phase descriptions.

- memo
- always use mermaid for diagrams
