# Status

Weekly client status report generator. Aggregates project activity, hours logged, accomplishments, and blockers across all active client projects for Friday afternoon status reporting.

## Core Philosophy

- **Executive-ready** - Format designed for direct paste into email
- **Evidence-based** - Pull from project_TODO.md and meeting notes
- **Per-project detail** - Each client gets a full section
- **Summary table** - Quick executive view at the bottom
- **Active language** - All items use action verbs

## Data Sources

| Source | Purpose |
|--------|---------|
| `Projects/Clients/*/*/project_TODO.md` | Completed items and upcoming work |
| `Projects/Clients/*/*/meetings/meeting_notes/` | Meeting decisions and context |
| `Projects/Clients/*/*/project-brief.md` | Current risks and status |
| `recurring-tasks.md` or hardcoded | Planned hour allocations |

## Workflow

### 1. Discover Active Projects (10 seconds)

Glob all project_TODO files:
```
Projects/Clients/*/*/project_TODO.md
```

For each file found:
- Extract Client name from path (second-to-last directory)
- Extract Project name from path (last directory) or frontmatter
- Check frontmatter `status` field — skip if `status: completed` or `status: archived`

### 2. Get Time Tracking Data (optional)

If a time tracking integration is configured, query for this week's logged hours per project. Group by project and sum hours.

### 3. Get Planned Hours (optional)

If you maintain a time planning file, read it for current weekly allocations per project.

### 4. Per-Project Intelligence (30 seconds per project)

For each active project:

**Accomplishments (from project_TODO.md):**
- Find completed checkboxes `- [x]` from this week (check git history or timestamps if available)
- If no git metadata, look for recent items in 🔴 or 🟢 sections
- Limit to 3-5 key items

**Accomplishments (from meeting notes):**
- Glob `meetings/meeting_notes/YYYY-MM-DD-*.md` for this week
- Extract key decisions from "Decisions" or "Action Items" sections
- Add significant meeting outcomes

**Next Week (from project_TODO.md):**
- Pull unchecked `- [ ]` items from 🔴 Must Do section
- Limit to top 3-5 items

**Risks/Blockers (from project-brief.md):**
- Read the "Risks" or "Issues" section
- Extract current blockers
- Check project_TODO.md "Waiting On" table for items >7 days old

### 5. Generate Per-Project Sections

Format each project section (see output format below).

### 6. Generate Summary Table

At the end, create an executive summary table with:
- Project name
- Hours logged this week
- One-liner key win
- One-liner next step

## Output Format

```
# Weekly Status Report - Week of [Date]

## [Client] / [Project]

**Hours This Week:** [X.X]h (planned: [X]h)

**Accomplishments:**
- [Completed item from project_TODO.md]
- [Key decision from meeting notes]
- [Another completed item]

**Next Week:**
- [Upcoming item from project_TODO.md]
- [Another upcoming item]

**Risks / Blockers:**
- [Risk from project-brief.md]
- [Overdue Waiting On item]
- [None if no blockers]

---

## [Client] / [Project]

**Hours This Week:** [X.X]h (planned: [X]h)

**Accomplishments:**
- [Item 1]
- [Item 2]

**Next Week:**
- [Item 1]
- [Item 2]

**Risks / Blockers:**
- None

---

**Summary:**

| Project | Hours | Key Win | Next Step |
|---------|-------|---------|-----------|
| Example Client SharePoint | 12.5h | Completed Phase 2 permissions audit | Finalize documentation for client review |
| Example Enrollment | 4.0h | Resolved edge case handling in script | Deploy to staging environment |
| Example Project Support | 7.5h | Upgraded dev environment to latest stack | Begin Phase 3 portal development |
| Example Medical Data Migration | 2.0h | Analyzed Phase 2 requirements | Schedule kickoff with stakeholders |

**Total:** 26.0h logged (planned: 24h)
```

## Formatting Rules

- **Active language throughout** - "Completed", "Resolved", "Deployed", not "Working on"
- **Hours format** - `X.X`h (one decimal place)
- **If over/under allocation** - Note variance in parentheses: `12.5h (planned: 12h, +0.5h)`
- **No emoji** - Keep it professional for email
- **Client-ready** - Assume this will be forwarded to clients
- **Summary table** - One-liners only, must fit in table cells

## Edge Cases

| Scenario | Handling |
|----------|----------|
| No project_TODO.md for a project | Skip the project silently |
| No time logged for a project this week | Show `0.0h` and flag in summary |
| No planned hours (Example Medical, BizDev) | Show `(as needed)` instead of planned value |
| No accomplishments found | Note "Ongoing work; see Next Week section" |
| No next week items | Note "Planning in progress" |
| No risks/blockers | Always show "None" — don't skip section |
| Project status is completed/archived | Skip it entirely |

## Week Date Calculation

"Week of [Date]" should be the **Monday** of the current week.

Calculate Monday:
```python
from datetime import datetime, timedelta
today = datetime.now()
monday = today - timedelta(days=today.weekday())
week_label = monday.strftime("%B %d, %Y")  # e.g., "February 3, 2026"
```

- `from_date`: Monday in YYYY-MM-DD format
- `to_date`: Today in YYYY-MM-DD format

## Usage

**Standard invocation (Friday afternoon):**
```
/status
```

**Specify a week (backfill):**
```
/status --week 2026-02-03
```
Uses the provided Monday as the week start.

**Save to file:**
```
/status --save
```
Creates `logs/weekly/YYYY-WW-status.md` with frontmatter.


If a time tracking tool is configured, query it for this week's entries grouped by project.

## Project TODO Parsing

**Extract completed items from project_TODO.md:**

Look for checkbox lines:
```markdown
- [x] Completed item text
```

If git history is available, check commits from Monday to today for changes to the project_TODO.md file that show completed checkboxes.

If no git metadata:
- Assume unchecked items in 🔴 sections are this week's focus
- Assume any text in a "Completed This Week" section (if it exists)

**Extract upcoming items:**
```markdown
🔴 Must Do (This Week)
- [ ] Upcoming item text
```

## Meeting Notes Parsing

**Extract decisions from meeting notes:**

Glob this week's notes:
```
Projects/Clients/[Client]/[Project]/meetings/meeting_notes/YYYY-MM-DD-*.md
```

Look for sections:
- "Decisions"
- "Action Items"
- "Key Outcomes"
- "Next Steps"

Pull 1-2 significant bullets from these sections per meeting.

## Anti-Patterns to Avoid

| Don't | Do |
|-------|-----|
| Use passive voice | "Completed X", not "X was completed" |
| Include internal context clients shouldn't see | Client-ready language only |
| Exceed 5 items per section | Keep it concise |
| Use vague language ("made progress") | Specific outcomes ("Deployed to staging") |
| Skip the summary table | It's the most important part |
| Over-detail blockers | One line per blocker |

## Integration with Weekly Review

This command can be run as part of the `/weekly` workflow:
1. Generate `/status` report
2. Review and adjust as needed
3. Paste into weekly email to stakeholders
4. Archive in `logs/weekly/`

## Sample Full Output

```
# Weekly Status Report - Week of February 3, 2026

## Example Client / SharePoint Data Cleanup & Remediation

**Hours This Week:** 12.5h (planned: 12h)

**Accomplishments:**
- Completed Phase 2 site permissions audit across all 47 sites
- Documented remediation recommendations for ownership gaps
- Facilitated weekly sync; reviewed Phase 3 scope and timeline

**Next Week:**
- Finalize Phase 2 deliverable for client review
- Begin Phase 3 discovery: data classification framework
- Schedule kickoff with Example Client IT team for Phase 3

**Risks / Blockers:**
- None

---

## Example Health / Enrollment PFS Script Rebuild

**Hours This Week:** 4.0h (planned: 4h)

**Accomplishments:**
- Resolved edge case handling for multi-coverage scenarios
- Completed unit tests for error handling module
- Facilitated daily standups (Mon-Fri)

**Next Week:**
- Deploy updated script to staging environment
- Coordinate UAT with the client team
- Document deployment runbook

**Risks / Blockers:**
- Staging environment access pending IT approval (requested 2/4)

---

## Example Project / Ongoing Support

**Hours This Week:** 7.5h (planned: 8h)

**Accomplishments:**
- Upgraded dev environment to latest .NET stack
- Resolved SSO integration issue with client portal
- Weekly sync with the project lead; prioritized Phase 3 scope

**Next Week:**
- Begin Phase 3 portal development (authentication module)
- Review architecture with the architect
- Deploy Phase 2 hotfix to production

**Risks / Blockers:**
- None

---

## Example Medical / Data Warehouse Migration

**Hours This Week:** 2.0h (as needed)

**Accomplishments:**
- Analyzed Phase 2 requirements and dependencies
- Reviewed data lineage documentation

**Next Week:**
- Schedule Phase 2 kickoff with stakeholders
- Draft migration plan for client leadership review

**Risks / Blockers:**
- Phase 2 scope pending budget approval

---

**Summary:**

| Project | Hours | Key Win | Next Step |
|---------|-------|---------|-----------|
| Example Client SharePoint | 12.5h | Completed Phase 2 permissions audit | Finalize documentation for client review |
| Example Enrollment | 4.0h | Resolved edge case handling | Deploy to staging environment |
| Example Project Support | 7.5h | Upgraded dev environment | Begin Phase 3 portal development |
| Example Medical Data Migration | 2.0h | Analyzed Phase 2 requirements | Schedule kickoff with stakeholders |

**Total:** 26.0h logged (planned: 24h)
```

---

**Target runtime: 2-3 minutes for full report generation**
