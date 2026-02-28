---
tags:
  - "#system"
  - "#automation"
  - "#recurring"
status: active
created_date: 2026-01-01
last_updated: 2026-01-01
permalink: recurring-tasks
---

# Recurring Tasks

**Purpose:** Define repeating task patterns that should be automatically surfaced in `/daily` briefs and `todo.md`. Prevents dropped balls and reduces cognitive load.

**See also:** [[todo]], [[roadmap]], [[CLAUDE]]

---

## How This Works

1. **Define patterns** in the sections below
2. **`/daily` command** reads this file and checks what's due
3. **If not already in todo.md**, the task is added to Today's Priority
4. **Completed tasks** are tracked normally in todo.md

---

## Daily Recurring

| Task | Time | Template | Condition |
|------|------|----------|-----------|
| Review priorities | 9:00 AM | `- [ ] Review todo.md and calendar for today` | Weekdays |

---

## Weekly Recurring

| Task | Day | Template | Project | Condition |
|------|-----|----------|---------|-----------|
| Weekly review | Sunday | `- [ ] Complete weekly review → [[logs/weekly/\|weekly log]]` | - | Always |
| Inbox zero pass | Monday | `- [ ] Process email inbox to zero` | - | Always |
| Network check-in | Friday | `- [ ] Review stale contacts in network.md` | - | Always |

---

## Monthly Recurring

| Task | Day of Month | Template | Project | Condition |
|------|--------------|----------|---------|-----------|
| Network maintenance | 1st | `- [ ] Monthly network review - update person files in network/ with recent contacts` | - | Always |
| Roadmap review | 15th | `- [ ] Monthly roadmap review - assess Q progress, adjust priorities` | - | Always |

---

## Project-Triggered Recurring

> [!info] These tasks recur while a specific project is active. Add your own below.

### Example Client — Data Platform Assessment
| Task | Frequency | Template | End Condition |
|------|-----------|----------|---------------|
| Weekly sync prep | Weekly (Wed) | `- [ ] Example Client: Prep weekly sync - review deliverables, blockers` | Project complete |

*Delete the example above and add your own project-triggered tasks.*

---

## Automation Recurring

> [!robot] System health and automation tasks

| Task | Frequency | Template | Owner | Condition |
|------|-----------|----------|-------|-----------|
| Vault health check | Daily | `- [ ] Review vault maintenance report in logs/maintenance/` | Vault Organizer | GitHub Actions |
| Handoff backlog check | Daily | `- [ ] Check agent-handoff-log for stuck handoffs` | Strategic Advisor | Always |
| Orphan note cleanup | Weekly (Fri) | `- [ ] Review orphan notes from health report` | Vault Organizer | If orphans found |
| Tag consistency review | Monthly (1st) | `- [ ] Standardize non-compliant tags` | Vault Organizer | If issues found |

---

## Event-Triggered Tasks

> [!tip] Tasks that should be created when certain events occur

| Trigger | Task Template | Notes |
|---------|---------------|-------|
| New client meeting scheduled | `- [ ] Prep meeting: [Meeting Name] - pull attendee context from network/` | Meeting Maestro handles |
| Project milestone reached | `- [ ] Update project-brief.md with milestone completion` | Vault Organizer handles |
| End of quarter | `- [ ] Quarterly review - use tpl-quarterly-review template` | Always |

---

## Configuration

```yaml
# Settings for /daily processing
recurring_config:
  lookahead_days: 3          # Surface tasks this many days ahead
  overdue_highlight: true    # Mark missed recurring tasks as overdue
  dedup_check: true          # Don't add if similar task exists in todo.md
  project_status_check: true # Only add project tasks if project is active
```

---

## Rollover Rules

> [!warning] What happens when a recurring task is missed?

| Task Type | Behavior |
|-----------|----------|
| Weekly admin | Marks as OVERDUE, surfaces daily until done |
| Weekly review | Skips if 3+ days late, waits for next week |
| Project check-ins | Accumulates context, surfaces with "catch-up" note |
| Monthly reviews | Surfaces immediately next day, high priority |

---

**Created:** 2026-01-01
**Last Updated:** 2026-01-01
