# /setup — First-Time Vault Personalization Wizard

You are an onboarding wizard helping a new user personalize their "My Brain" vault. Walk them through each step conversationally, collecting their information, then apply all changes at once.

## Pre-Flight Check

First, check if `.claude/.setup-complete` exists:
- **If it exists:** Tell the user setup has already been run. Ask if they want to re-run (which will overwrite current values) or if they meant to use `/personalize` for targeted changes.
- **If it doesn't exist:** Proceed with setup.

## Step 1: Welcome & Identity

Greet the user and explain what this wizard does. Then collect:

1. **Full name** — Used in document headers, author fields, project briefs (currently "Your Name" in templates)
2. **Organization/company name** — Replaces "Your Organization" across the vault. If they're a solo practitioner, they can use their own name or brand.

Example prompt:
> Welcome to My Brain! Let's personalize your vault. This takes about 2 minutes.
>
> First, what's your **full name** and **organization/company name**?

## Step 2: Role & Industry Context

Collect:
1. **Role title** — e.g., "Senior Consultant", "CTO", "Freelance Developer" (used in proposal templates, agent context)
2. **Industry/domain** — e.g., "Data & Analytics Consulting", "Software Engineering" (helps agents tailor recommendations)

These are stored as a comment block in CLAUDE.md for agent reference.

## Step 3: Brand Colors (Optional)

Show the current defaults and ask if they want to customize:

> Your vault comes with default brand colors used in exported documents (PDF, HTML, presentations):
> - **Primary (dark):** `#1a5276` (headers, accents)
> - **Secondary (medium):** `#2874a6` (subheaders, links)
> - **Accent (light):** `#3498db` (info callouts)
>
> Want to use your own brand colors? Enter hex codes, or press Enter to keep defaults.

If they provide colors, validate they're valid hex format (`#` followed by 3 or 6 hex chars).

## Step 4: MCP Server Configuration (Optional)

Ask which MCP integrations they want to enable:

> My Brain supports MCP (Model Context Protocol) servers for enhanced capabilities.
> Available integrations:
> 1. **basic-memory** — Cross-session memory (indexes your vault)
> 2. **filesystem** — Enhanced file operations (batch reads, directory trees)
> 3. **markitdown** — Document conversion (DOCX, PDF, PPTX → markdown)
> 4. **GitHub** — PR, issue, and code search operations
>
> Which would you like to enable? (comma-separated numbers, or "all", or "skip")

If they select any, generate `.mcp.json` from `.mcp.json.example` with only the selected servers.

## Step 5: Agent Personas (Optional)

> Your vault has 6 AI agents with generic role names. Many users give them personalities
> that make interactions more engaging (fictional characters, mentor archetypes, etc.).
>
> Want to customize agent personas now, or keep the defaults? You can always do this
> later with `/personalize agents`.

If yes, walk through each agent briefly and ask for a name/personality trait.

## Applying Changes

After collecting all info, apply changes to these files. Use find-and-replace — do NOT rewrite entire files.

### Name replacements (`Your Name` → user's name):
- `templates/example-client-template/project_1/project-brief.md`
- `templates/tpl-project-brief.md` (if contains "Your Name")
- `templates/tpl-client-overview.md` (if contains "Your Name")
- Any other file containing the literal string "Your Name"

### Organization replacements (`Your Organization` and `your organization` → org name):
- `CLAUDE.md` — frontmatter example, export section
- `CLAUDE.local.md` — MCP descriptions, meeting workflow
- `.claude/commands/briefing.md` — all occurrences
- `.claude/commands/proposal.md` — all occurrences
- `.claude/commands/onboarding.md` — all occurrences
- `.claude/agents/relationship-manager.md`
- `utils/md_to_docx.py` — comments and footer text
- `templates/quarto-brand/README.md`
- `templates/quarto-brand/_quarto.yml`
- `templates/quarto-brand/themes/brand-theme.scss` — comment only
- `templates/quarto-brand/templates/meeting-briefing.qmd`
- `templates/tpl-sow-proposal.md`
- `templates/tpl-meeting.md`
- `templates/tpl-client-overview.md`
- `templates/snippets/quick-action.md`
- `templates/README.md`

**Important:** Replace both "Your Organization" (title case) and "your organization" (lower case) with appropriate casing of the org name.

### Brand color replacements (in `templates/quarto-brand/themes/brand-theme.scss`):
- `$brand-blue-dark: #1a5276` → `$brand-blue-dark: #[NEW_PRIMARY]`
- `$brand-blue-medium: #2874a6` → `$brand-blue-medium: #[NEW_SECONDARY]`
- `$brand-blue-light: #3498db` → `$brand-blue-light: #[NEW_ACCENT]`

Also update color references in:
- `templates/quarto-brand/README.md` (color table)
- `.claude/commands/briefing.md` (if hex values appear)
- `CLAUDE.local.md` (if hex values appear)

### Role/industry context (add to CLAUDE.md):
Add a section near the top of CLAUDE.md, after the "What This Is" paragraph:

```markdown
## Owner Context
- **Name:** [Full Name]
- **Organization:** [Org Name]
- **Role:** [Role Title]
- **Domain:** [Industry/Domain]
```

### MCP configuration:
If servers selected, read `.mcp.json.example`, filter to selected servers, write to `.mcp.json`.

### Agent personas:
If customized, update the `<!-- Customize: Give this agent a personality that motivates you! -->` comment in each agent file, replacing it with the persona description.

## Completion

After all changes are applied:

1. Create `.claude/.setup-complete` with timestamp and summary:
```
Setup completed: [ISO timestamp]
Name: [name]
Organization: [org]
Role: [role]
Colors: [primary] / [secondary] / [accent]
MCP: [list of enabled servers]
```

2. Print a summary:
```
✅ Setup complete! Here's what was personalized:

  Name:         [name] (updated in X files)
  Organization: [org] (updated in Y files)
  Brand Colors: [primary] / [secondary] / [accent]
  MCP Servers:  [list or "none — configure later with /personalize mcp"]
  Agent Personas: [customized or "defaults kept"]

📋 Recommended next steps:
  1. Update todo.md with your current tasks
  2. Update roadmap.md with your milestones
  3. Add contacts to network/ (see network/example-person.md)
  4. Run /daily for your first strategic brief
  5. Use /personalize anytime to adjust settings
```

3. Commit the changes with message: "chore: personalize vault via /setup"
