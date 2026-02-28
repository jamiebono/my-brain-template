---
tags:
  - "#system"
  - "#instructions"
  - "#quality"
status: active
created_date: 2026-01-03
last_updated: 2026-01-07
---

# Frontmatter Requirements

## Purpose

Validates that all markdown files include required YAML frontmatter fields according to vault conventions. Prevents documents from being committed without proper metadata for tagging, categorization, and tracking.

## Required Fields

All documents must include:

- `tags` - Array of tags (at least one)
- `status` - Document status (active, planned, completed, archived)
- `created_date` - Creation date in YYYY-MM-DD format
- `last_updated` - Last update date in YYYY-MM-DD format

## Check Logic

For each modified `.md` file in the commit:

1. **Frontmatter exists** - File begins with `---` delimiter
2. **Valid YAML** - Frontmatter parses correctly
3. **Required fields present** - All four required fields exist
4. **Tag format** - Tags array contains at least one tag
5. **Status value** - Status is one of: active, planned, completed, archived
6. **Date format** - Dates match YYYY-MM-DD pattern

## Examples

### Passing Example

```markdown
---
tags:
  - "#meetings"
  - "#consulting"
status: active
created_date: 2026-01-03
last_updated: 2026-01-03
---

# Document Title

Content here...
```

### Failing Examples

**Missing frontmatter:**
```markdown
# Document Title

No frontmatter at all - FAIL
```

**Missing required fields:**
```markdown
---
tags:
  - "#meetings"
status: active
---

# Document Title

Missing created_date and last_updated - FAIL
```

**Invalid status value:**
```markdown
---
tags:
  - "#meetings"
status: in-progress
created_date: 2026-01-03
last_updated: 2026-01-03
---

# Document Title

Status should be "active" not "in-progress" - FAIL
```

**Invalid date format:**
```markdown
---
tags:
  - "#meetings"
status: active
created_date: 01/03/2026
last_updated: 2026-01-03
---

# Document Title

Date should be YYYY-MM-DD not MM/DD/YYYY - FAIL
```

## Remediation

When this check fails:

1. **Add missing frontmatter** - Insert YAML block at top of file:
   ```yaml
   ---
   tags:
     - "#tag-name"
   status: active
   created_date: YYYY-MM-DD
   last_updated: YYYY-MM-DD
   ---
   ```

2. **Fix status values** - Use only: active, planned, completed, archived

3. **Fix date format** - Use YYYY-MM-DD (2026-01-03, not 01/03/2026)

4. **Add at least one tag** - Tag should be lowercase, hyphenated, with # prefix

## Exclusions

The following directories are excluded from this check:

- `.obsidian/` - Obsidian configuration
- `.github/` - GitHub configuration
- `.claude/` - Claude Code configuration (except agent files)
- `Assets/` - Media files
- `Excalidraw/` - Diagram files
- `templates/` - Template files (have their own structure)

## Related Documentation

- [[CLAUDE]] - Vault conventions and frontmatter standards
- [[templates/README]] - Template usage guidelines

---

**Created:** 2026-01-03
**Last Updated:** 2026-01-03
