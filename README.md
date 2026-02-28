---
tags:
- '#documentation'
- '#readme'
- '#setup-guide'
- '#documentation'
status: active
created_date: 2025-11-12
last_updated: 2026-02-28
permalink: readme
---

# My Brain 🧠

> An AI-augmented personal operating system built on Obsidian and Claude Code. Structured markdown files serve as a single source of truth for AI agents to read, analyze, and act upon.

**My Brain** is a knowledge management and productivity system that combines the power of **Obsidian** (a markdown-based knowledge management tool) with **Claude Code** (an AI assistant with file system access) to create a "second brain" that actively helps manage consulting projects, strategic planning, task tracking, professional networking, and client relationship management.

---

## Table of Contents

1. [Overview](#overview)
2. [Core Philosophy](#core-philosophy)
3. [Getting Started](#getting-started)
4. [Directory Structure](#directory-structure)
5. [Key Files](#key-files)
6. [Slash Commands](#slash-commands)
7. [AI Agents](#ai-agents)
8. [Template System](#template-system)
9. [Obsidian Integration](#obsidian-integration)
10. [Document Conventions](#document-conventions)
11. [VSCode & Git Integration](#vscode--git-integration)
12. [MCP Configuration](#mcp-configuration)
13. [Workflows](#workflows)
14. [Customization Guide](#customization-guide)
15. [Troubleshooting](#troubleshooting)

---

## Overview

My Brain implements the **"Feed the Beast"** pattern—a methodology where structured text files become the foundation for AI-assisted workflows. Rather than keeping information siloed in your head or scattered across apps, everything lives in markdown files that AI agents can read, cross-reference, and use to provide intelligent recommendations.

### What It Does

| Capability | Description |
|------------|-------------|
| **Strategic Planning** | Daily and weekly reviews with prioritization and pattern recognition |
| **Task Management** | Central task tracking integrated with roadmap milestones |
| **Project Management** | Hierarchical client/project structure with standardized documentation |
| **Network Management** | Professional contact tracking with relationship context |
| **Outreach Assistance** | AI-assisted message drafting and communication strategy |
| **Knowledge Capture** | Meeting notes, transcripts, and documentation templates |
| **Git Operations** | Automated commits with intelligent message generation |

### Technology Stack

- **Obsidian** — Visual markdown editor with linking, plugins, and graph visualization
- **Claude Code** — AI assistant with file system access for reading/editing documents
- **Git/GitHub** — Version control with automatic commits via GitDoc
- **VSCode** — Code editor (optional, for power users and MCP integration)

---

## Core Philosophy

### The "Feed the Beast" Pattern

1. **Single Source of Truth**: All critical information lives in markdown files—not in your head, not in scattered apps
2. **Structured for AI**: Files use consistent formatting, YAML frontmatter, and wiki-links so AI agents can parse and understand context
3. **Action-Oriented**: Every review, every analysis leads to concrete next steps
4. **Context-Aware**: AI agents read across multiple files to understand the full picture before providing recommendations
5. **Human-First**: AI removes friction but doesn't replace decision-making—you remain in control

### Design Principles

- **Progressive Disclosure**: Important info first, details available when needed
- **Visual Hierarchy**: Emojis, callouts, and formatting for scannability
- **Actionable Structure**: Clear action items, decisions, and follow-ups
- **Context Preservation**: Rich metadata for future reference
- **Integration Ready**: DataView queries, Smart Connections, Calendar integration

---

## Getting Started

### Prerequisites

1. **Obsidian** — [Download](https://obsidian.md) (free)
2. **Claude Code** — [Subscribe](https://claude.ai/claude-code) ($20/month minimum)
3. **Git** — For version control ([Download](https://git-scm.com))

### Initial Setup

1. Clone or download this repository to your local machine
2. Open the folder in Obsidian as a vault
3. Enable community plugins in Obsidian (Settings → Community plugins → Turn on)
4. Install recommended plugins (see [Obsidian Integration](#obsidian-integration))
5. Open a terminal in the repository folder
6. Run `claude` to start Claude Code
7. **Run `/setup` to personalize your vault** — walks you through name, organization, brand colors, and MCP configuration
8. Test with `/daily` to generate your first strategic brief

> **Without Claude Code?** Run `bash scripts/setup.sh` for interactive command-line setup. Use `--dry-run` to preview changes first.

### First Steps

After running `/setup`:

1. Update `todo.md` — Add your current tasks and priorities
2. Update `roadmap.md` — Add your milestones and deadlines
3. Add contacts to `network/` — See `network/example-person.md` for the format
4. Run `/daily` — Get your first AI-generated strategic brief
5. Use `/personalize` anytime to adjust colors, agents, MCP servers, or branding

---

## Directory Structure

```
my-brain/
├── .claude/
│   ├── agents/                    # AI agent definitions (6 agents)
│   │   ├── strategic-advisor.md
│   │   ├── meeting-maestro.md
│   │   ├── relationship-manager.md
│   │   ├── vault-organizer.md
│   │   ├── editorial-agent.md
│   │   └── pragmatist-agent.md
│   ├── commands/                  # Slash commands (15 commands)
│   │   ├── setup.md              # First-time personalization wizard
│   │   ├── daily.md              # Daily strategic brief
│   │   ├── weekly.md             # Weekly review
│   │   ├── briefing.md           # Meeting/person/company briefings
│   │   ├── outreach.md           # Outreach message drafting
│   │   ├── push.md               # Auto-commit and push
│   │   ├── time.md               # Time tracking
│   │   ├── status.md             # Client status reports
│   │   ├── health.md             # Vault health check
│   │   ├── onboarding.md         # Client/project onboarding
│   │   ├── transcript.md         # Transcript processing
│   │   ├── digest.md             # Catch-up summary
│   │   ├── proposal.md           # SOW/proposal generator
│   │   ├── retro.md              # Project retrospective
│   │   └── personalize.md        # Update personalization settings
│   ├── instructions/              # Processing instructions
│   ├── skills/                    # Conversational skills (3 skills)
│   │   ├── de-ai-ify/
│   │   ├── linkedin-post/
│   │   └── thinking-partner/
│   └── settings.local.json        # Claude Code permissions
├── Projects/
│   ├── Clients/                   # Client project hierarchy
│   │   └── [Client-Name]/
│   │       ├── client-overview.md
│   │       └── [project-name]/
│   │           ├── project-brief.md
│   │           ├── project_TODO.md
│   │           ├── email/in/      # Incoming emails
│   │           ├── email/out/     # Outbound drafts
│   │           └── meetings/      # Meeting notes & transcripts
│   └── Internal/                  # Internal projects
├── templates/                     # Obsidian Templater templates (15+)
│   ├── snippets/                  # Reusable template fragments
│   ├── example-client-template/   # Example project hierarchy
│   ├── quarto-brand/              # Branded document generation
│   │   ├── themes/brand-theme.scss
│   │   ├── assets/                # Logo, reference DOCX
│   │   └── templates/             # QMD templates
│   ├── tpl-daily-brief.md
│   ├── tpl-weekly-review.md
│   ├── tpl-meeting.md
│   └── ... (15 templates total)
├── network/                       # Individual contact files
│   └── example-person.md          # Example contact format
├── logs/
│   ├── daily/                     # Daily briefs
│   ├── weekly/                    # Weekly reviews
│   ├── quarterly/                 # Quarterly reviews
│   ├── eod/                       # End-of-day logs
│   ├── meetings/                  # Meeting logs
│   └── maintenance/               # Vault health reports
├── scripts/
│   └── setup.sh                   # CLI setup wizard (non-Claude alternative)
├── utils/
│   ├── md_to_docx.py              # Markdown → branded Word converter
│   └── quarto-filters/            # Quarto rendering filters
├── config/                        # Tool configuration files
├── .mcp.json.example              # MCP server template (copy to .mcp.json)
├── todo.md                        # Central task tracking
├── roadmap.md                     # Strategic milestones
├── network.md                     # Professional contacts (Dataview index)
├── outreach.md                    # Outreach tracking
├── recurring-tasks.md             # Recurring task patterns
├── agent-handoff-log.md           # Agent coordination context
├── CLAUDE.md                      # AI context file (the "brain")
├── CLAUDE.local.md                # Supplemental context
└── README.md                      # This file
```

---

## Key Files

| File | Purpose | Update Frequency |
|------|---------|------------------|
| `todo.md` | Daily task tracking with checkboxes | Daily |
| `roadmap.md` | Strategic milestones and quarterly planning | Weekly |
| `network.md` | Professional contacts with context | As contacts are made |
| `outreach.md` | Message drafts and follow-up tracking | As needed |
| `CLAUDE.md` | Context file telling AI about the repository | When structure changes |

### todo.md Structure

```markdown
## 🔥 Today's Priority
- [ ] Most important task
- [ ] Second priority

## 📋 In Progress
- [ ] Active work items

## 📋 On Deck
- [ ] Coming up next

## 💡 Someday/Maybe
- [ ] Ideas and future items
```

### network.md Structure

```markdown
## Person Name
Role @ Company
Email: email@example.com
Last: YYYY-MM-DD - Context of last interaction
Notes: Relationship context, what they're working on, how you can help each other
```

---

## Slash Commands

Slash commands are AI prompts that execute specific workflows. Run them by typing the command in Claude Code (e.g., `/daily`).

### Setup & Configuration

| Command | Purpose |
|---------|---------|
| `/setup` | First-time vault personalization wizard (name, org, colors, MCP) |
| `/personalize` | Update specific settings: `colors`, `agents`, `mcp`, `branding`, `identity` |

### Daily Operations

| Command | Purpose |
|---------|---------|
| `/daily` | Strategic daily brief with priorities, blockers, and ONE THING. Modes: `--quick`, `standup` |
| `/weekly` | 7-phase weekly review: mechanical → emotional → constraints → unlocks → priorities → evolution → outputs |
| `/push` | Auto-commit and push changes with generated commit message |
| `/digest` | "What did I miss?" catch-up summary from emails and calendar |
| `/time` | Time tracking reconciliation and reporting |
| `/health` | Vault health check — broken links, orphan notes, stale files |

### Client & Project Work

| Command | Purpose |
|---------|---------|
| `/briefing` | Professional briefings: meetings, people, companies, topics, projects. Flags: `--sales`, `--disc` |
| `/outreach` | Draft and manage outreach messages with strategic guidance |
| `/onboarding` | Client/project onboarding — creates folder structure and initial docs |
| `/status` | Weekly client status report across active projects |
| `/proposal` | SOW/proposal generator mining vault for context |
| `/transcript` | Process meeting transcripts into structured notes with action items |
| `/retro` | Project retrospective — what worked, what didn't, lessons learned |

### Command Details

**`/daily`** reads `todo.md`, `roadmap.md`, calendar events, and recent activity to produce:
- Today's calendar overview and state of affairs
- Key opportunities and blockers
- ONE THING: Your single highest-leverage action
- Prioritized action list

**`/weekly`** runs a multi-phase strategic review:
1. Mechanical Review → 2. Emotional Reality Check → 3. Constraint Analysis → 4. Finding Unlocks → 5. Energy-Aware Priorities → 6. Evolution Tracking → 7. Outputs to `roadmap.md`, `todo.md`, weekly log

**`/briefing`** generates branded PDF/HTML/DOCX briefing documents using the Quarto pipeline. Auto-detects briefing type (meeting, person, company, topic, project) or specify with `--type`.

**`/push`** checks `git status` and `git diff`, generates a descriptive commit message, stages, commits, and pushes

---

## AI Agents

Agents are specialized AI personas with defined capabilities and behaviors. They're defined in `.claude/agents/`.

<!-- Customize: Give each agent a personality that motivates you! -->

### Strategic Advisor (`strategic-advisor.md`)

**Primary agent for daily operations.** Acts as a strategic partner who:
- Conducts daily and weekly reviews
- Manages network and relationships
- Drafts outreach messages
- Coordinates other agents
- Executes git operations

### Meeting Maestro (`meeting-maestro.md`)

**Meeting lifecycle specialist.** Handles:
- Meeting prep and context gathering
- Transcript processing
- Action item extraction
- Meeting note completion

### Relationship Manager (`relationship-manager.md`)

**Network and contact specialist.** Manages:
- Contact research and profiling
- Company and individual OSINT
- Meeting preparation
- Project onboarding
- Network maintenance

### Vault Organizer (`vault-organizer.md`)

**Vault maintenance specialist.** Handles:
- Directory structure organization
- Tag standardization
- Backlink creation and maintenance
- Frontmatter consistency

### Editorial Agent (`editorial-agent.md`)

**Writing review specialist.** Provides:
- Grammar and clarity review
- Tone adjustment
- Proofreading client-facing communications

### Pragmatist (`pragmatist-agent.md`)

**Anti-perfectionism agent.** Delivers:
- Reality checks on scope creep
- Decision paralysis breaking
- Over-engineering detection

---

## Template System

Templates live in `templates/` and use Obsidian's Templater plugin syntax.

### Core Templates

| Template | Purpose | Output Location |
|----------|---------|-----------------|
| `tpl-daily-brief` | Daily strategic planning | `logs/daily/` |
| `tpl-daily-standup` | Quick async standup format | `logs/daily/` |
| `tpl-weekly-review` | 7-phase weekly reflection | `logs/weekly/` |
| `tpl-quarterly-review` | Strategic quarterly planning | `logs/quarterly/` |
| `tpl-meeting` | General meeting capture | Project folder |
| `tpl-quick-meeting` | Rapid lightweight meeting notes | Project folder |
| `tpl-discovery-session` | Client discovery calls | Client project folder |
| `tpl-1on1` | 1:1 meetings | Appropriate folder |
| `tpl-client-overview` | New client setup | `Projects/Clients/[Client]/` |
| `tpl-project-brief` | New project setup | Project folder |
| `tpl-project-todo` | Project-specific task tracking | Project folder |
| `tpl-sow-proposal` | SOW/proposal document | Project folder |
| `tpl-status-report` | Client status report | Project folder |
| `tpl-person` | Detailed contact profile | `network/` |
| `tpl-person-light` | Lightweight contact profile | `network/` |

### Snippets

Quick-insert fragments in `templates/snippets/`:
- `update-timestamp` — Update "Last Updated" field
- `quick-action` — Insert action item
- `quick-meeting-capture` — Rapid meeting notes
- `standup` — Daily standup format
- `time-entry` — Billable time tracking
- `decision-log-entry` — Document decisions
- `risk-issue-entry` — Track risks/issues
- `callout` — Styled callout blocks

### Template Features

- **Smart Date Handling**: Automatic date generation and navigation links
- **Meta Bind Integration**: Interactive sliders, toggles, and inputs
- **Buttons Plugin**: Action buttons for common operations
- **Automatic Linking**: Wiki-links to related documents

### Using Templates

1. **Command Palette**: `Ctrl/Cmd + P` → "Templater: Insert template"
2. **Calendar Click**: Click a date to auto-create daily brief
3. **Hotkeys**: Configure in Settings → Hotkeys

---

## Obsidian Integration

### Required Plugins

| Plugin | Purpose |
|--------|---------|
| **Templater** | Advanced template system |
| **Calendar** | Date navigation and daily note creation |
| **Dataview** | Query and display data from notes |

### Recommended Plugins

| Plugin | Purpose |
|--------|---------|
| **Smart Connections** | AI-powered semantic search |
| **Meta Bind** | Interactive form elements |
| **Buttons** | Clickable action buttons |
| **Excalidraw** | Visual diagramming |
| **Mermaid Tools** | Diagram creation |

### Plugin Configuration

**Templater Settings:**
- Template folder location: `templates`
- Trigger on new file creation: Enabled

**Daily Notes Settings:**
- Date format: `YYYY-MM-DD-[daily-brief]`
- New file location: `logs/daily`
- Template file: `templates/tpl-daily-brief`

**Calendar Plugin:**
- Uses core Daily Notes configuration
- Show week numbers: Enabled (for weekly review links)

---

## Document Conventions

### YAML Frontmatter

All documents should include:

```yaml
---
tags:
  - "#tag-name"
client: Client Name          # For client work
project: project-name        # For project work
status: active|planned|completed
created_date: YYYY-MM-DD
last_updated: YYYY-MM-DD
---
```

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Client Folders | Title-Case-With-Hyphens | `Acme-Corp/` |
| Project Folders | lowercase-with-hyphens | `data-platform-migration/` |
| Files | lowercase-with-hyphens | `project-brief.md` |
| Dated Files | YYYY-MM-DD prefix | `2025-11-25-meeting-notes.md` |
| Tags | lowercase with hyphens | `#project-management` |

### Semantic Filenames

| Type | Pattern | Example |
|------|---------|---------|
| Client Overview | `client-overview.md` | `client-overview.md` |
| Project Brief | `project-brief.md` | `project-brief.md` |
| Meeting Notes | `YYYY-MM-DD-[title].md` | `2025-11-25-sow-review.md` |
| Deliverables | `YYYY-MM-DD-[name].md` | `2025-11-20-architecture.md` |

### Linking

Use Obsidian wiki-style links: `[[filename]]` or `[[filename|display text]]`

Add backlinks at the top of documents:
```markdown
**See also:** [[todo]], [[roadmap]], [[network]]
```

### Footer

Include at the bottom of every document:
```markdown
---

**Created:** YYYY-MM-DD
**Last Updated:** YYYY-MM-DD
```

### Tag Taxonomy

| Category | Tags |
|----------|------|
| **Document Type** | `#meeting`, `#project`, `#todo`, `#note` |
| **Work Type** | `#consulting`, `#internal` |
| **Technology** | `#ai`, `#data`, `#bi`, `#sharepoint`, `#security` |
| **Client** | `#client/[name]` (e.g., `#client/acme-corp`) |
| **Project** | `#project/[name]` (e.g., `#project/data-platform-migration`) |

---

## VSCode & Git Integration

### GitDoc Auto-Commit (Optional)

For automatic version control, configure VSCode with GitDoc:
- Install the GitDoc extension
- Commits on save, smart commit, auto-sync after commit

**Recommended `.vscode/settings.json`:**
```json
{
  "gitdoc.enabled": true,
  "git.enableSmartCommit": true,
  "git.postCommitCommand": "sync",
  "files.autoSave": "onFocusChange"
}
```

### Claude Code Permissions

Local permissions are configured in `.claude/settings.local.json`:
- Allowed slash commands and bash operations
- Permitted git operations
- Web search capability
- Add MCP server access as needed

---

## MCP Configuration

Model Context Protocol (MCP) servers extend Claude's capabilities. Configuration lives in `.mcp.json` at the vault root.

### Setup

1. Copy the example config: `cp .mcp.json.example .mcp.json`
2. Or run `/setup` which configures MCP servers interactively

### Included Integrations

| Server | Purpose | Command |
|--------|---------|---------|
| **basic-memory** | Cross-session memory — indexes your vault as source of truth | `uvx basic-memory mcp` |
| **filesystem** | Batch file reads, directory trees, advanced file management | `npx -y @anthropic/mcp-filesystem` |
| **markitdown** | Convert DOCX, PDF, PPTX to clean markdown | `uvx markitdown-mcp` |

### Adding More Servers

Edit `.mcp.json` to add servers. Common additions include GitHub, Asana, calendar integrations:

```json
{
  "mcpServers": {
    "server-name": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@package/name"]
    }
  }
}
```

Use `/personalize mcp` to reconfigure servers interactively.

---

## Workflows

### Daily Workflow

```
Morning:
1. Open Obsidian
2. Run `/daily` in Claude Code
3. Review calendar and priorities
4. Set your ONE THING

Throughout Day:
5. Check off tasks in todo.md
6. Capture meeting notes using templates
7. Update relevant project briefs

End of Day:
8. Run `/push` to commit changes
9. Preview tomorrow's calendar
```

### Weekly Workflow

```
Friday/Sunday:
1. Run `/weekly` in Claude Code
2. Complete all 7 phases of review
3. Update roadmap.md with new milestones
4. Add next week's priorities to todo.md
5. Create weekly log in logs/weekly/
6. Run `/push` to commit changes
```

### Meeting Workflow

```
Before Meeting:
1. Create note from tpl-meeting template
2. Set objectives and agenda

During Meeting:
3. Capture notes, decisions, action items

After Meeting:
4. Summarize key decisions
5. Extract action items to todo.md
6. Send follow-up if needed
7. Run `/push` to save
```

### New Client Workflow

```
1. Create client folder: Projects/Clients/[Client-Name]/
2. Create client-overview.md from template
3. Research client using relationship manager agent
4. Create project subfolder
5. Create project-brief.md from template
6. Add key contacts to network.md
7. Update roadmap.md with milestones
```

---

## Customization Guide

### Adding New Commands

1. Create a new `.md` file in `.claude/commands/`
2. Define the command behavior and output format
3. Reference relevant files to read
4. Specify expected outputs

### Creating New Templates

1. Add file to `templates/` with `tpl-` prefix
2. Include Templater logic block at top
3. Add standard YAML frontmatter
4. Include navigation and backlinks
5. Document in `templates/README.md`

### Modifying Agent Behavior

1. Edit the agent file in `.claude/agents/`
2. Adjust capabilities, output formats, or personality
3. Update the description for proper invocation

### Extending the System

- **New project types**: Add templates and folder structures
- **New integrations**: Configure MCP servers
- **New workflows**: Create slash commands
- **New agents**: Define specialized personas

---

## Troubleshooting

### Claude Code Issues

| Issue | Solution |
|-------|----------|
| Commands not running | Check `.claude/commands/` exists and files are valid markdown |
| Agent not invoked | Verify agent file has proper frontmatter with name and description |
| Permission denied | Check `.claude/settings.local.json` for allowed operations |

### Obsidian Issues

| Issue | Solution |
|-------|----------|
| Templates not rendering | Verify Templater plugin enabled and folder path set |
| Calendar not creating daily | Check Daily Notes plugin configuration |
| Broken links | Run obsidian-janitor agent for link maintenance |

### Git Issues

| Issue | Solution |
|-------|----------|
| Push fails | Check SSH keys or authentication |
| Conflicts | Resolve manually or use git commands |
| GitDoc not auto-committing | Verify workspace settings |

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on submitting issues, feature requests, and pull requests.

---

## Credits

Based on the ["Feed the Beast"](https://dtlarson.com/feed-the-beast) pattern by Derek Larson, significantly extended with AI agents, slash commands, and structured templates.

---

**See also:** [[todo]], [[roadmap]], [[network]], [[CLAUDE]]

**Created:** 2025-11-12
**Last Updated:** 2026-02-28
**Template by:** [Jamie Bono](https://github.com/jamiebono)


[todo]: todo.md "Todo"
[roadmap]: roadmap.md "Roadmap"
[network]: network.md "Network"
[CLAUDE]: CLAUDE.md "CLAUDE"