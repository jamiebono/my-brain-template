# Project Retrospective

Facilitated project retrospective for completed or mid-project engagements. Captures lessons learned, reusable assets, and practice-level insights in 15-20 minutes.

## Core Philosophy

- **No blame** - Focus on systems and processes, not people
- **Be specific** - "Weekly status emails stopped after week 3" not "communication was bad"
- **Quantify when possible** - "3 of 12 deliverables were late by average 5 days"
- **Practice over project** - What can the team learn, not just this engagement?
- **Time-boxed** - 15-20 minutes, not an hour. Ship the retro, don't perfect it.

## Data Sources

| Source | What to Extract |
|--------|----------------|
| `Projects/Clients/[Client]/[project]/project-brief.md` | Scope, timeline, milestones, risks, decisions, budget |
| `Projects/Clients/[Client]/[project]/project_TODO.md` | Completed items, outstanding items, waiting-on items |
| `Projects/Clients/[Client]/[project]/meetings/meeting_notes/*.md` | Key decisions, recurring themes, client feedback |
| `Projects/Clients/[Client]/[project]/*.md` | Deliverables, proposals, architecture docs |
| `network/*.md` | Client contacts and relationship context (individual person files) |

## Workflow

### 1. Identify the Project (10 seconds)

If the user specifies a project:
- Navigate directly to `Projects/Clients/[Client]/[project]/`

If the user does not specify:
- Ask: "Which project? Here are your active ones:"
- Glob `Projects/Clients/*/*/project-brief.md`
- List projects with status from frontmatter (active, completed, on-hold)
- Let user pick

### 2. Gather Evidence (30 seconds)

Read all available project artifacts:

**Required reads:**
- `project-brief.md` - Full read for scope, timeline, milestones, risks, decisions
- `project_TODO.md` - Full read for completed/incomplete items

**Optional reads (if they exist):**
- Glob `meetings/meeting_notes/*.md` - Read all meeting notes (scan for decisions, action items, client feedback)
- Glob `*.md` in project root - Identify deliverables by filename pattern (date-prefixed files)

- Compare hours logged vs budget from project-brief frontmatter

### 3. Analyze (60 seconds)

Process gathered evidence through the retrospective framework:

**Timeline Analysis:**
- Did the project hit its milestones on time?
- How did actual dates compare to target dates?
- What caused any delays?

**Budget Analysis:**
- Hours used vs hours budgeted (from project-brief frontmatter)
- Were certain phases over/under budget?
- Was scope managed effectively?

**Meeting Pattern Analysis:**
- How many meetings occurred? What cadence?
- Did meeting frequency change over the project lifecycle?
- Were decisions made efficiently or did topics recur?

**Task Completion Analysis:**
- What percentage of TODO items completed vs total?
- How many items are still in "Waiting On" status?
- Were tasks clear and actionable, or vague?

### 4. Walk Through Framework (Interactive, 10-15 minutes)

Present findings organized in the retrospective framework. For each section, share what the evidence shows and ask the user to confirm, adjust, or add context.

**Section 1: What Went Well**
- Surface successes from the evidence (completed milestones, positive meeting notes, on-time deliverables)
- Ask: "What else went well that the files don't capture? Client relationships, learning, team dynamics?"

**Section 2: What Didn't Go Well**
- Surface friction from the evidence (missed deadlines, budget overruns, stale waiting-on items, recurring meeting topics)
- Ask: "What friction points am I missing? Anything that was harder than expected?"

**Section 3: What Would We Do Differently**
- Propose concrete changes based on patterns found
- Ask: "If you started this project tomorrow, what would you change in the first week?"

**Section 4: Lessons for the Practice**
- Elevate project-specific findings to practice-level insights
- Frame as: "For the next [project type] engagement, the team should..."
- Consider: scoping, communication cadence, tooling, team structure, client management

**Section 5: Reusable Assets Created**
- Scan for templates, frameworks, code, or approaches created during the project
- Check for documents that could be generalized
- Ask: "Did you create anything during this project that could be reused?"

### 5. Update Project Brief (30 seconds)

Write findings to the "Lessons Learned" section of `project-brief.md`:

Find the existing section:
```markdown
## Lessons Learned
```

Or the template version:
```markdown
## Lessons Learned

> [!abstract]- Complete at project close
```

Replace with populated content:
```markdown
## Lessons Learned

> Retrospective completed: [YYYY-MM-DD]

### What Went Well
- [Finding 1]
- [Finding 2]

### What Could Improve
- [Finding 1]
- [Finding 2]

### Recommendations for Next Time
- [Recommendation 1]
- [Recommendation 2]
```

### 6. Output Standalone Retro Document (30 seconds)

Create `Projects/Clients/[Client]/[project]/YYYY-MM-DD-retrospective.md` with full content.

## Output Format (Standalone Retro Document)

```yaml
---
tags:
  - "#retrospective"
  - "#project"
  - "#client/[client-tag]"
type: retrospective
client: [Client Name]
project: [Project Name]
project_status: [active|completed]
retro_date: YYYY-MM-DD
created_date: YYYY-MM-DD
last_updated: YYYY-MM-DD
---
```

```markdown
# Retrospective: [Project Name]

> **Client:** [Client Name]
> **Project Duration:** [Start Date] - [End Date or "ongoing"]
> **Hours:** [Used] / [Budgeted] ([%] of budget)
> **Retro Date:** [YYYY-MM-DD]

---

## What Went Well

- [Specific finding with evidence]
- [Specific finding with evidence]
- [Specific finding with evidence]

## What Didn't Go Well

- [Specific finding with evidence — e.g., "3 of 8 deliverables were late by average 4 days"]
- [Specific finding with evidence]
- [Specific finding with evidence]

## What Would We Do Differently

- [Concrete change — e.g., "Establish weekly written status updates from day 1, not just meetings"]
- [Concrete change]
- [Concrete change]

## Lessons for the Practice

> These insights apply beyond this project to future engagements.

- [Practice-level lesson — e.g., "For SharePoint migrations, always run a permissions audit before scoping cleanup work"]
- [Practice-level lesson]
- [Practice-level lesson]

## Reusable Assets

| Asset | Type | Location | Reuse Potential |
|:------|:-----|:---------|:----------------|
| [Asset name] | Template/Framework/Script/Approach | [Path or description] | [Where else it applies] |

## Project Metrics Summary

| Metric | Target | Actual | Delta |
|:-------|-------:|-------:|------:|
| Duration (weeks) | [X] | [X] | [+/- X] |
| Hours | [X] | [X] | [+/- X] |
| Deliverables On Time | [X/Y] | [X/Y] | |
| Meetings Held | — | [X] | |
| Scope Changes | — | [X] | |

---

**Generated:** YYYY-MM-DD
**Project Brief Updated:** Yes
```

## Edge Cases

| Scenario | Handling |
|----------|----------|
| No project-brief.md exists | Create a minimal retro without budget/timeline analysis; note the gap |
| No project_TODO.md exists | Skip task completion analysis; focus on meetings and deliverables |
| No meeting notes exist | Note absence as a finding ("No meeting notes captured — consider structured meeting workflow") |
| Project still active (mid-project retro) | Label as "Mid-Project Retrospective" and frame findings as course corrections |
| Lessons Learned section not found in project-brief | Append section at end of file before the footer |
| Multiple retros for same project | Date-prefix handles this naturally (2026-02-06-retrospective.md, 2026-03-15-retrospective.md) |

## Anti-Patterns to Avoid

| Don't | Do |
|-------|-----|
| Assign blame to individuals | Focus on process and systems |
| Use vague language ("could have been better") | Be specific ("status emails stopped after week 3") |
| List only positives to be polite | Include honest friction points — that's the value |
| Write a novel | Keep each bullet to 1-2 sentences |
| Skip the practice lessons | This is the most valuable section — elevate beyond the project |
| Spend more than 20 minutes | Time-box it. Ship the retro. |
| Create retro without reading evidence first | Always gather data before forming conclusions |

## Usage

**Standard invocation:**
```
/retro
```
Prompts for project selection, then walks through framework.

**Specify project:**
```
/retro Example Client sharepoint-cleanup-remediation
```
Jumps directly to evidence gathering for the specified project.

**Mid-project retro:**
```
/retro --mid-project
```
Frames findings as course corrections rather than final lessons.

**Quick retro (no interactive questions):**
```
/retro --quick
```
Generates retro from evidence only, no user prompts. Faster but less complete.

---

**Target runtime: 15-20 minutes (interactive), 2-3 minutes (--quick)**
