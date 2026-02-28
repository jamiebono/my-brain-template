# CLAUDE.local.md -- Situational Context

This file contains context that supplements CLAUDE.md. It is loaded automatically by Claude Code but contains content relevant only in specific workflows.

## Claude Code Configuration (`.claude/settings.local.json`)

Claude Code is configured with:

**Output Style:** `Explanatory` - Provides educational insights and explanations alongside code

**Pre-approved Permissions:**
- `/daily` slash command
- Git operations (fetch, add, commit, remote)
- File operations (rm, mkdir)
- Web search
- Asana task search via MCP
- Node/npm environment commands
- Bash/PowerShell operations

These permissions allow Claude to work autonomously without constant approval prompts for common operations.

## VSCode Integration

**GitDoc:** Auto-commits on save

**Editor Settings** (`.vscode/settings.json`):
- `git.enableSmartCommit: true`
- `git.postCommitCommand: "sync"`
- Autosave on focus change

**MCP Configuration** (`.mcp.json` at vault root, copy from `.mcp.json.example`):

Active MCP servers extending Claude's capabilities:

| Server | Purpose | Key Uses |
|--------|---------|----------|
| **basic-memory** | Semantic vault indexing visible in Obsidian | Cross-session memory -- indexes entire vault as source of truth |
| **Filesystem** | Enhanced file operations | Batch reads, directory trees, advanced file management |
| **MarkItDown** | Document to markdown conversion | Convert DOCX, PDF, PPTX transcripts to clean markdown |
| **GitHub** | Repository operations | PRs, issues, code search, releases |
| **Asana** (built-in) | Task management integration | Query tasks, create from meetings, track project health |

## Detailed MCP Server Integration

### basic-memory - Semantic Vault Indexing

**Purpose:** Cross-session memory by indexing the entire vault. No separate memory folder - uses existing files as the source of truth.

**Storage:** The ENTIRE vault is indexed. Key files include:

- `network.md` - Professional network Dataview index (dashboard)
- `network/*.md` - Individual person files with relationship context
- `Projects/Clients/*/client-overview.md` - Client information
- `Projects/Clients/*/*/project-brief.md` - Project details
- `roadmap.md` - Strategic milestones
- `todo.md` - Task tracking

**Key Tools:**

- `mcp__basic-memory__search_notes` - Search across the entire vault
- `mcp__basic-memory__build_context` - Build context from a memory URI
- `mcp__basic-memory__read_note` - Read a specific note
- `mcp__basic-memory__edit_note` - Edit existing notes
- `mcp__basic-memory__recent_activity` - See what's changed recently

**Semantic Links:** Use `[Entity Name](entity_type)` syntax in files to create semantic connections:

```markdown
[Jane Smith](contact) works at [Acme Corp](client)
[Example Corp](client) project lead: [John Doe](contact)
```

**Agent Usage:**

| Agent | Memory Use Case |
|-------|----------------|
| **Strategic Advisor** | Search vault for strategic patterns, project context, decision history |
| **Relationship Manager** | Search `network/` person files and client files for relationship intelligence |
| **Meeting Maestro** | Search meeting notes and project briefs for context |

### Daily Memory Routines (BOD/EOD)

**Authoritative reference:** `.claude/agents/strategic-advisor.md` Section 7.

The Strategic Advisor's Section 7 defines the complete BOD (Beginning of Day) and EOD (End of Day) memory hygiene routines, including specific tool calls, triggers, and skip conditions. All agents performing daily reviews should follow that section. Memory updates are non-negotiable — skipping EOD means tomorrow starts from scratch.

### Asana MCP - Task Management

**Purpose:** Professional task tracking with visibility and accountability.

**Sync Philosophy:**
- `todo.md` = Quick capture, daily working list
- Asana = Authoritative tracking with due dates, assignees, projects
- Reconcile during daily/weekly reviews

**Agent Usage:**
| Agent | Asana Use Case |
|-------|---------------|
| **Strategic Advisor** | Query task status, surface overdue items, project health checks |
| **Meeting Maestro** | Create tasks from meeting action items, link commitments to projects |

### Filesystem MCP - Enhanced File Operations

**Purpose:** Batch operations and directory management.

**Key Operations:**
- `read_multiple_files` - Read several files in one call
- `directory_tree` - Get vault structure overview
- `search_files` - Glob-pattern file search

Mostly used by the Vault Organizer for vault organization tasks.

### GitHub MCP - Repository Operations

**Purpose:** GitHub operations directly from Claude Code.

**Key Operations:**
- Create and manage pull requests
- View and create issues
- Search code across repositories
- Manage releases and branches

### MarkItDown MCP - Document Conversion

**Purpose:** Convert documents to clean markdown using Microsoft's MarkItDown library.

**Key Tool:**
- `convert_to_markdown(uri)` - Convert any supported file to markdown

**Supported URIs:**
- `file:///path/to/document.docx` - Local files
- `https://example.com/doc.pdf` - Remote URLs
- `data:` URIs for inline content

**Supported Formats:** DOCX, PDF, PPTX, images, audio, and 29+ other formats.

**Primary Use Case:** Transcript conversion from `.docx` files. See `.claude/instructions/transcript-conversion.md` for detailed workflow.

**Email Attachment Conversion:** When processing email attachments (SOWs, decks, reports), convert them using MarkItDown and file them to the appropriate project directory.

## Plugins

**Installed (verified):**
- mermaid-tools - Diagram rendering
- scribe - Audio transcription
- smart-connections - Semantic search
- templater-obsidian - Template engine
- obsidian-advanced-uri - Deep linking
- obsidian-local-rest-api - REST API access
- notebook-navigator - Navigation
- omnisearch - Full-text search
- marp-slides - Slide presentations

## Template Configuration

See `templates/README.md` for:
- Calendar plugin integration (auto-create daily brief on date click)
- Templater settings and folder configuration
- Usage workflows and troubleshooting

## Document Export - Detailed Style Mapping

### Branded Word Documents

The custom converter (`python utils/md_to_docx.py <input.md> <output.docx>`) applies corporate styles from a reference template:

- **Brand Header** → Main titles (H1)
- **Brand Headers** → Section headers (H2)
- **Brand Sub Title** → Sub-sections (H3)
- **Brand Paragraph** → Body text
- **Brand Bullets** → Bullet lists
- **Table Text** → Table cells
- Clickable hyperlinks preserved

The reference template is stored at `templates/quarto-brand/assets/brand-reference.docx`. Customize it with your organization's styles.

### Quarto Configuration

**Vault-root `_quarto.yml`** at repo root applies defaults to all Quarto renders in the vault. Key settings: `toc: true` for HTML, `papersize: us-letter` for PDF, and mermaid-to-image Lua filter for PDF/DOCX. **Does NOT inject external mermaid scripts** — Quarto's built-in `{mermaid}` handler manages mermaid rendering for HTML.

**`templates/quarto-brand/`** directory contains:
- `_quarto.yml` - your organization project config (used when rendering from that directory)
- `themes/brand-theme.scss` - your brand colors, table styling, code block styling, heading colors
- `assets/` - Logo (`logo.png`) and reference DOCX template (`brand-reference.docx`)
- `templates/` - Quarto document templates
- `_output/` - Rendered documents (gitignored)

**Brand SCSS theme features (customizable):**
- Brand colors: dark blue `#1a5276` (H1), medium blue `#2874a6` (H2, links) — change these to your brand colors
- Tables: dark header with white text, alternating gray rows
- Code blocks: light gray background with border
- Blockquotes: branded left border, italic

### Mermaid Diagram Handling

**HTML:** Quarto embeds the mermaid library and renders ```` ```{mermaid} ```` code fences client-side. No CDN scripts needed. Self-contained with `embed-resources: true`.

**PDF:** Requires Chromium to convert mermaid to PNG. If Chromium is unavailable (e.g., WSL2 snap sandbox), render to HTML instead or pre-render diagrams to images.

**DOCX:** Uses `utils/quarto-filters/mermaid-to-image.lua` filter (referenced in vault-root `_quarto.yml`).

**Syntax rules for mermaid in QMD files:**
- Use ```` ```{mermaid} ```` (Quarto executable fence), not ```` ```mermaid ```` (bare markdown)
- Avoid parentheses `()` and colons `:` in ER diagram entity aliases — they break the parser
- Keep entity names as plain identifiers; add a caption line below for source table names

**Subdirectory override pattern:** If a subdirectory needs to block inherited vault-root `_quarto.yml` settings, create a local `_quarto.yml` with:
```yaml
project:
  type: default
format:
  html:
    include-after-body: []
```

## Meeting Workflow (Three-Phase with Scribe)

Meetings follow a **three-phase workflow** integrating the Meeting Maestro (AI agent) with Scribe (transcription plugin):

```
+------------------+----------------------+--------------------------------------+
|   PHASE 1        |      PHASE 2         |           PHASE 3                    |
|   BEFORE         |      DURING          |           AFTER                      |
+------------------+----------------------+--------------------------------------+
|   the Meeting Maestro       |      You              |           the Meeting Maestro                   |
|   creates        |      free capture    |           completes notes            |
|   capture        |      + records       |           from transcript            |
|   template       |      with Scribe     |                                      |
+------------------+----------------------+--------------------------------------+
```

**Phase 1 - Before (the Meeting Maestro):**
1. Read the relevant template (`tpl-meeting.md`, `tpl-discovery-session.md`, `tpl-1on1.md`)
2. Create capture file in correct location: `Projects/Clients/[Client]/[project]/YYYY-MM-DD-meeting-title.md`
3. Pre-populate with context from person files in `network/`, `project-brief.md`, previous meetings, `todo.md`
4. Use full template structure - do not simplify or abbreviate

**Phase 2 - During (You):**
- Takes free-form notes in the prepared document
- Records meeting using Scribe plugin
- Focuses on the conversation, not formatting

**Phase 3 - After (the Meeting Maestro):**
1. Process transcript from Scribe
2. Reconcile free capture notes with transcript
3. Complete meeting document to template standard
4. Extract action items to `todo.md` and Asana
5. Update person files in `network/` with interaction dates if needed

**Invocation:**
- "Prep me for my 2pm meeting" -> Phase 1
- "Here's the transcript" / "Complete the notes" -> Phase 3

> Full workflow details: `.claude/agents/meeting-maestro.md`

## Transcript Conversion (.docx -> Markdown)

When users provide transcript files (from Teams, Zoom, Fireflies, Otter.ai, etc.):

1. Use MarkItDown MCP: `convert_to_markdown(uri="file:///path/to/transcript.docx")`
2. Add proper frontmatter with attendees, duration, tags
3. Normalize speaker formatting if needed
4. Save to project's `transcripts/` folder with date prefix

**Critical:** Always use the FULL transcript. Never truncate or summarize unless explicitly asked.

> Full conversion instructions: `.claude/instructions/transcript-conversion.md`

## Email Attachment Handling

Configure your own email attachment workflow. Common approaches:
- **Power Automate** → OneDrive folder → MarkItDown MCP for conversion
- **Manual download** → Convert with MarkItDown → File to project directory

**Common attachment types and where they go:**
| Type | Destination |
|------|-------------|
| SOW / Proposal | `Projects/Clients/[Client]/[project]/` |
| Meeting transcript | `Projects/Clients/[Client]/[project]/meetings/meeting_transcripts/` |
| Deliverable / Report | `Projects/Clients/[Client]/[project]/` with date prefix |
| Reference document | `Projects/Clients/[Client]/[project]/` or relevant subfolder |

## Deprecated Tags

Consolidate these when encountered:
- `#ai-strategy`, `#ai-enablement`, `#ai-governance`, `#agentic-ai`, `#agentic-workflows` -> `#ai`
- `#data-strategy`, `#data-warehouse`, `#data-mesh`, `#data-fabric` -> `#data`
- `#business-intelligence`, `#bi-assessment` -> `#bi`

