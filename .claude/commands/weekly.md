# Weekly Review

This should feel like a conversation between you and your chief of staff managing the weekly debrief meeting. Propose questions, help see things clearly, and work together on what comes next and how to think about the upcoming week.

Your role: help see the whole map, bring out the true story of the week, and surface how the user is feeling (which may have happened outside of these files).

## Phase 1: Mechanical Review

### Phase 1b: Network Refresh

Scan the past 7 days of email and calendar activity to keep `network/` person files current:

1. **Scan sources:**
   - `email_and_calendar_context/emails/*.md` — emails from the past 7 days
   - `email_and_calendar_context/calendar/*.md` — calendar events from the past 7 days
2. **Update contacts:** For each person interacted with:
   - Find their person file in `network/` (glob `network/*.md`, match by filename or `aliases` in YAML frontmatter)
   - Update `last_contact` date in the person file's YAML frontmatter
   - Add email addresses or contact info found in emails/calendar invites
   - Note context from recent interactions (what they're working on, interests, needs)
   - Capture relationship strength signals (responsiveness, collaboration level)
3. **Add new contacts:** Anyone appearing in emails/calendar who has no person file in `network/` — create a new person file using `tpl-person-light` template with name, company, how you connected, and `needs_research: true`
4. **Flag stale contacts:** Review stale contacts via `network.md` Dataview index or scan `network/` person files for `last_contact` >90 days ago and list them:
   ```
   STALE CONTACTS (>90 days):
   - [Name] — Last: [Date] — [Role @ Company]
   - [Name] — Last: [Date] — [Role @ Company]
   Action: Update, archive, or schedule outreach
   ```

### Phase 1a: File Review

Gather context first by reading:
- Recent git commits from past 7 days
- `todo.md` - completed vs incomplete items
- `roadmap.md` - milestones and deadlines
- `logs/weekly/` - last week's review (check predictions vs reality)
- `/email_and_calendar_context/calendar/*.md` - calendar events
- `/email_and_calendar_context/emails/*.md` - email messages
- `/email_and_calendar_context/daily-digest-*.md` - legacy digest files

**Review:**
- Git changes: Key commits and file reorganization from past 7 days
- Tasks completed vs. planned
- What got moved to archived/completed vs remains incomplete?
- Check last week's predictions vs reality
- Upcoming hard deadlines

## Phase 2: Emotional Reality Check

### Direct Questions
- What's causing the most unease right now?
- What am I afraid of doing?
- What am I unwilling to feel?
- What brought the most joy/energy this week?

## Phase 3: Constraint Analysis

### The Core Question
**"What could be cut here?"**

### Constraint Check
- Money: What's the real number? When does it hit?
- Time: What's actually locked in vs. self-imposed?
- Energy: Where am I bleeding out vs. gaining strength?
- Reputation: Real risk vs. imagined risk?

## Phase 4: Finding Unlocks

### Collaboration Opportunities
- Who could I be reaching out to for help?
- What can be delegated/automated/eliminated?

### Reframe Prompts
- What if the opposite were true?
- What would [trusted advisor] tell me to do?
- What's the 80/20 here?

## Phase 5: Energy-Aware Priorities

### Next Week's Priorities
When coming up with this list think about:
- What MUST happen (external commitment)
- What unlocks everything else
- What maintains momentum
- What preserves energy/sanity

### Energy Management
- Protected recharge time:
- Power hours for deep work:
- Batching strategy:
- Hard stops:

## Evolution Tracking

### Review Journey
**Started thinking:** [where they began]
**Ended with:** [where they landed]
**Key unlock:** [what breakthrough happened]
**Pattern to remember:** [what to watch]

## Questions When Evaluating the Prior Week's Review

- Did the unlocks work?
- What new constraint emerged?
- What pattern repeated or ended?

## Review Outputs

After completing the review, update:

1. **roadmap.md** - **MANDATORY:** Update `last_updated` field in frontmatter. Review each active project entry. Add/remove items to match current reality. This is a gate, not a suggestion — roadmap must reflect reality every week.
2. **todo.md** - Add next week's priorities as checkable items `- [ ]`
   - **Archive old completions:** Move completed items older than 2 weeks to `logs/weekly/YYYY-WW-archive.md`. Keep todo.md lean (<200 active lines). Completed sections accumulate and bloat the file — clean them out.
3. **Create weekly review log** - `logs/weekly/YYYY-WW.md` with:
   - Review summary
   - Key insights and unlocks
   - What needs to get done by next week
   - Patterns to watch

**YAML Frontmatter for weekly review log:**
```yaml
---
tags:
  - "#weekly-review"
date: YYYY-MM-DD
week: WW
---
```

**See also:** [[todo]], [[roadmap]]
