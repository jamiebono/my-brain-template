# Vault Quality Standards

This directory contains documentation defining quality standards for the Obsidian vault. These are reference documents that agents and GitHub Actions use to validate vault health.

## Standards Defined

### Frontmatter Check (`frontmatter-check.md`)
All markdown files must include proper YAML frontmatter:

**Required fields:**
- `tags` - Array with at least one tag
- `status` - One of: active, planned, completed, archived
- `created_date` - YYYY-MM-DD format
- `last_updated` - YYYY-MM-DD format

### Tag Standards (`tag-standards.md`)
All tags must follow the format: `#lowercase-with-hyphens`

**Rules:**
- Start with `#` prefix
- Lowercase only (no CamelCase or UPPERCASE)
- Hyphens for word separation (not underscores)
- No spaces or special characters

### Link Validator (`link-validator.md`)
All wiki-style links `[[filename]]` must resolve to existing files.

**Checked:**
- `[[simple-links]]`
- `[[path/to/file]]`
- `[[file#section]]`
- `[[file|Display Text]]`

## Excluded Directories

These standards do NOT apply to:
- `.obsidian/` - Obsidian configuration
- `.github/` - GitHub configuration
- `.claude/` - Claude Code configuration
- `templates/` - Template files
- `Assets/` - Media files
- `Excalidraw/` - Diagram files

## Enforcement

Standards are enforced through:

1. **Agent awareness** - Agents creating/editing files follow these rules
2. **GitHub Actions** - `vault-health.yml` runs periodic checks
3. **Weekly reviews** - the Vault Organizer (Obsidian Organizer agent) audits vault health

## Migration Notes

These documents were originally in `.claude/hooks/` but moved here because:
- Claude Code hooks require executable scripts, not markdown
- These are quality *standards*, not *hooks*
- `.claude/instructions/` is the proper home for reference documentation

---

**Last Updated:** 2026-01-07
