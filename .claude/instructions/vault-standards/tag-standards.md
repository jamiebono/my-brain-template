---
tags:
  - "#system"
  - "#instructions"
  - "#quality"
status: active
created_date: 2026-01-03
last_updated: 2026-01-07
---

# Tag Standards

## Purpose

Enforces consistent tag formatting across the vault. Tags should be lowercase, hyphen-separated, and prefixed with `#`. Prevents tag proliferation and ensures tags remain searchable and maintainable.

## Tag Format Standard

**Required format:** `#lowercase-with-hyphens`

All tags must:
- Start with `#` prefix
- Use only lowercase letters
- Use hyphens (not underscores or spaces) for word separation
- Avoid special characters except hyphens

## Check Logic

For each modified `.md` file in the commit:

1. **Extract frontmatter tags** - Parse YAML tags array
2. **Extract inline tags** - Find tags in document body
3. **Validate format** - Check each tag against standard
4. **Flag violations:**
   - Uppercase letters (CamelCase, Title Case, SCREAMING_CASE)
   - Underscores instead of hyphens
   - Spaces in tags
   - Missing `#` prefix
   - Special characters

## Examples

### Passing Examples

**Frontmatter tags:**
```yaml
---
tags:
  - "#meetings"
  - "#consulting"
  - "#project-planning"
  - "#client-cambridge-associates"
status: active
---
```

**Inline tags:**
```markdown
This is a #consulting note about #strategic-planning for the #q1-2026 quarter.
```

### Failing Examples

**Uppercase letters:**
```yaml
tags:
  - "#Meetings"          # FAIL: Use #meetings
  - "#ProjectPlanning"   # FAIL: Use #project-planning
  - "#URGENT"            # FAIL: Use #urgent
```

**Underscores instead of hyphens:**
```yaml
tags:
  - "#project_planning"  # FAIL: Use #project-planning
  - "#client_work"       # FAIL: Use #client-work
```

**Spaces in tags:**
```yaml
tags:
  - "#project planning"  # FAIL: Use #project-planning
```

**Missing prefix:**
```yaml
tags:
  - "meetings"           # FAIL: Use #meetings
```

**Mixed violations:**
```yaml
tags:
  - "#Client_Notes"      # FAIL: Uppercase AND underscore
  - "Strategic Planning" # FAIL: Missing prefix AND space AND uppercase
```

## Remediation

When this check fails:

### Step 1: Convert to lowercase
```yaml
# BEFORE
tags:
  - "#Meetings"
  - "#ProjectPlanning"

# AFTER
tags:
  - "#meetings"
  - "#project-planning"
```

### Step 2: Replace underscores with hyphens
```yaml
# BEFORE
tags:
  - "#project_planning"
  - "#client_work"

# AFTER
tags:
  - "#project-planning"
  - "#client-work"
```

### Step 3: Add missing prefix
```yaml
# BEFORE
tags:
  - "meetings"
  - "consulting"

# AFTER
tags:
  - "#meetings"
  - "#consulting"
```

### Step 4: Replace spaces with hyphens
```yaml
# BEFORE
tags:
  - "#project planning"

# AFTER
tags:
  - "#project-planning"
```

## Common Tag Patterns

### Standard Tags

These are commonly used tags that follow the standard:

```yaml
# Document types
- "#meetings"
- "#notes"
- "#todos"
- "#projects"

# Work categories
- "#consulting"
- "#strategic-planning"
- "#research"
- "#documentation"

# Temporal
- "#daily-brief"
- "#weekly-review"
- "#quarterly-review"

# Systems
- "#system"
- "#agents"
- "#hooks"
- "#automation"
```

### Tag Consolidation

If you find variations, consolidate to one:

```yaml
# INCONSISTENT (pick one)
- "#meeting"
- "#meetings"
- "#Meeting"

# STANDARDIZED
- "#meetings"  # Use plural, lowercase
```

## Auto-Fix Suggestions

The hook will suggest corrections for common issues:

| Violation | Suggestion |
|-----------|-----------|
| `#Meeting` | `#meeting` |
| `#project_planning` | `#project-planning` |
| `#Strategic Planning` | `#strategic-planning` |
| `"meetings"` | `"#meetings"` |
| `#ClientWork` | `#client-work` |

## Tag Migration

If standardizing tags across the vault:

1. **Use find-and-replace** in Obsidian
2. **Search for tag:** `tag:#OldTag`
3. **Replace with:** `#new-tag`
4. **Verify with search** before committing

## Performance Considerations

For files with many tags:

- Hook validates all tags at once
- Reports all violations together
- Provides specific line numbers for inline tags

## Exclusions

The following are excluded from tag standards:

- `.obsidian/` - Obsidian configuration
- `.github/` - GitHub configuration
- `templates/` - Template files (may contain placeholder tags)
- Code blocks - Tags in fenced code blocks are ignored

## Related Documentation

- [[CLAUDE]] - Tag conventions and common tags
- [[network]] - Example of consistent tagging (contact tags)

---

**Created:** 2026-01-03
**Last Updated:** 2026-01-03
