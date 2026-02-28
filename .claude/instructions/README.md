# Claude Code Instructions

This directory contains reference documentation and instructions that Claude Code uses when performing specific tasks. These are NOT executable hooks - they're documentation that guides agent behavior.

## Directory Structure

```
instructions/
├── README.md              # This file
├── session-start.md       # Session initialization context loading
├── transcript-conversion.md  # How to convert meeting transcripts
└── vault-standards/       # Vault quality standards documentation
    ├── frontmatter-check.md  # Required frontmatter fields
    ├── tag-standards.md      # Tag formatting rules
    └── link-validator.md     # Wiki-link validation rules
```

## How These Are Used

Claude Code agents reference these documents when:

1. **Starting sessions** - `session-start.md` guides context loading
2. **Converting transcripts** - `transcript-conversion.md` provides conversion workflow
3. **Reviewing vault quality** - `vault-standards/` documents define the rules

## Vault Standards

The `vault-standards/` subdirectory contains documentation for vault quality rules:

| Document | Purpose |
|----------|---------|
| `frontmatter-check.md` | Required YAML frontmatter fields for all documents |
| `tag-standards.md` | Tag formatting: lowercase, hyphenated, prefixed with # |
| `link-validator.md` | Wiki-link validation: ensuring `[[links]]` resolve |

These standards are enforced by:
- Agent awareness (agents read these docs)
- GitHub Actions (`vault-health.yml`)
- Manual review during weekly cleanup

## Adding New Instructions

When adding new instruction documents:

1. Use clear, descriptive filenames
2. Include a "When to Use" section
3. Provide step-by-step procedures
4. Include examples where helpful
5. Add to this README

## Relationship to Other Directories

| Directory | Purpose |
|-----------|---------|
| `.claude/agents/` | Agent personality and capabilities |
| `.claude/commands/` | Slash command implementations |
| `.claude/instructions/` | Reference docs for specific tasks (this folder) |

---

**Last Updated:** 2026-01-07
