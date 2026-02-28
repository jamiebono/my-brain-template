# /personalize — Update Vault Personalization Settings

Update specific personalization settings without re-running the full setup wizard.

**Usage:** `/personalize $ARGUMENTS`

## Argument Routing

Parse the `$ARGUMENTS` to determine which area to personalize:

| Argument | Action |
|----------|--------|
| `colors` | Update brand colors in SCSS theme and related files |
| `agents` | Customize agent personas (names, personalities) |
| `mcp` | Reconfigure MCP server settings |
| `branding` | Update organization name/logo across all files |
| `identity` | Update name and role information |
| `all` | Full re-personalization (equivalent to `/setup`) |
| *(empty)* | Show current settings and ask what to change |

## If No Arguments

Read current personalization state from the files themselves (not from a config file):

1. **Name**: Grep for the `## Owner Context` section in `CLAUDE.md`
2. **Organization**: Read org name from CLAUDE.md Owner Context, or check if "Your Organization" still appears
3. **Colors**: Read `$brand-blue-dark`, `$brand-blue-medium`, `$brand-blue-light` values from `templates/quarto-brand/themes/brand-theme.scss`
4. **MCP**: Check if `.mcp.json` exists and list configured servers
5. **Agents**: Check each `.claude/agents/*.md` for custom persona comments

Display current values and ask which area to update.

## `colors` — Brand Color Update

1. Read current color values from `templates/quarto-brand/themes/brand-theme.scss`
2. Display them: "Current colors: Primary `#XXXXXX`, Secondary `#XXXXXX`, Accent `#XXXXXX`"
3. Ask for new values (allow partial — only change what they specify)
4. Update in these files:
   - `templates/quarto-brand/themes/brand-theme.scss` (the SCSS variables)
   - `templates/quarto-brand/README.md` (the color table)
   - `CLAUDE.local.md` (brand color references)
   - `.claude/commands/briefing.md` (if hex values appear)
5. Validate hex format before applying

## `agents` — Agent Persona Customization

For each of the 6 agents in `.claude/agents/`:
1. Read the current file
2. Show the agent's role and current persona status (default generic or customized)
3. Ask if they want to give it a persona — name, personality trait, fictional inspiration
4. If yes, update the `<!-- Customize -->` comment with the persona, and optionally weave the personality into the agent's opening description

Agent files:
- `strategic-advisor.md` — Strategy, decisions, reviews
- `meeting-maestro.md` — Meetings, transcripts, agendas
- `relationship-manager.md` — Contacts, research, relationships
- `vault-organizer.md` — Vault organization, tags, links
- `editorial-agent.md` — Document editing, proofreading
- `pragmatist-agent.md` — Perfectionism intervention, reality checks

## `mcp` — MCP Server Configuration

1. Check if `.mcp.json` exists
2. If yes, show current configuration
3. If no, explain MCP and offer to create from `.mcp.json.example`
4. Allow adding/removing individual servers
5. For new servers, ask for the command and args
6. Write updated `.mcp.json`

## `branding` — Organization Name Update

1. Ask for the new organization name
2. Find all occurrences of the current org name (read from CLAUDE.md Owner Context or search for it)
3. Replace across all files (same file list as `/setup`)
4. Update the Owner Context section in CLAUDE.md

## `identity` — Name and Role Update

1. Ask for updated name, role, domain
2. Update the Owner Context section in CLAUDE.md
3. Replace name in template files where "Your Name" or the previous name appears

## After Any Change

- Print a summary of what was changed and how many files were affected
- Update `.claude/.setup-complete` marker with new timestamp
- Suggest committing: "Run `/push` to commit these changes"
