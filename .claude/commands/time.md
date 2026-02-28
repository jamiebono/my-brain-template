---
description: Time tracking reconciliation and reporting. Customize this command for your time tracking tool.
---

# Time Tracking Reconciliation

## Purpose

Review and reconcile your time tracking for the current week. This command helps you:
- Identify gaps in logged time
- Reconcile actual work with logged entries
- Ensure accurate billing/tracking

## Customization Required

This command is a **template** — you need to configure it for your time tracking setup.

### Supported Patterns

**If you use a time tracking MCP server:**
1. Query your time tracking tool for this week's entries
2. Compare against your calendar and daily logs
3. Identify missing entries
4. Draft entries for unlogged work

**If you track time manually:**
1. Review `todo.md` completed items this week
2. Check `logs/daily/` for this week's briefs
3. Cross-reference with calendar events
4. Summarize hours by project

## Process

### 1. Gather Evidence
- Read `todo.md` for completed tasks
- Read this week's daily briefs from `logs/daily/`
- Check calendar events (if available)
- Query time tracking tool (if configured)

### 2. Reconcile
For each active project in `Projects/Clients/`:
- What work was done?
- How many hours estimated?
- What's already logged vs. missing?

### 3. Output

```
TIME TRACKING - Week of [date]

| Project | Logged | Estimated | Gap | Notes |
|---------|--------|-----------|-----|-------|
| [Client A / Project] | Xh | Yh | Zh | [context] |
| [Client B / Project] | Xh | Yh | Zh | [context] |

TOTAL: X / Y hours

Missing entries:
- [Day]: [Project] - [description] (~Xh)
```

### 4. Remediation
- Draft time entries for any gaps identified
- Flag any weeks that need attention
