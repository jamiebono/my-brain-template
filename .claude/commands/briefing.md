# Meeting Briefing Generator

Generate a professionally styled meeting briefing document for an upcoming meeting.

**Arguments:** $ARGUMENTS (meeting name, attendee name, or description)

**Flags:**
- `--disc` or `disc` anywhere in arguments → Include DISC Communication Style Assessment (see Step 3b)

## Step 1: Identify the Meeting

Search calendar files in `email_and_calendar_context/calendar/` for meetings matching "$ARGUMENTS":

```
Look for:
- Meeting title containing the search term
- Attendee names matching the search term
- Meetings happening today or in the near future
```

Extract from the matching meeting:
- Meeting title
- Date and time
- Duration
- Platform (Teams, Zoom, etc.)
- All attendees
- Meeting description/context if available

**If no match found:** Ask user to clarify which meeting they want a briefing for.

## Step 2: Research Attendees

For the PRIMARY contact (the person the meeting is "about"):

### If person file exists in `network/`:
- Search `network/` by name (glob `network/*.md`, match filename or `aliases` in YAML frontmatter)
- Pull their existing profile from the person file
- Check `last_contact` date in frontmatter for recent interactions
- Look for pending items in `outreach.md`
- Search for previous meeting notes with them

### If NO person file in `network/`:
Use the Relationship Manager (alicia-relationship-manager agent) to research:
1. Search web for LinkedIn profile
2. Find their role, company, location
3. Identify expertise areas and background
4. Look for recent news or posts
5. **Create a person file in `network/`** using `tpl-person-light` template with findings

## Step 3: Build Context

Gather your organization's context:
- Check `Projects/Clients/*/client-overview.md` for relationship with their organization
- Check `Projects/Clients/*/*/project-brief.md` for relevant project context
- Search for previous meetings or emails with this contact
- Check `outreach.md` for any pending communications

Answer: **Why is this meeting happening?** What's the angle for your organization?

## Step 3b: DISC Communication Style Assessment (if `--disc` flag)

When the `--disc` flag is present, perform an inferential DISC personality assessment based on all gathered research. This is NOT a formal assessment — it's an **estimated communication style profile** derived from observable behavioral signals.

### DISC Framework Quick Reference

| Style | Core Drive | Behavioral Signals | Communication Preference |
|:------|:-----------|:-------------------|:------------------------|
| **D - Dominance** | Results, control, challenge | Direct language, leadership roles, competitive career moves, decisive actions, bottom-line focus | Be direct, skip small talk, focus on outcomes, respect their time |
| **I - Influence** | Recognition, relationships, enthusiasm | Outgoing writing style, collaborative language, public-facing roles, storytelling, network-building | Be enthusiastic, use stories, acknowledge them publicly, keep energy high |
| **S - Steadiness** | Stability, harmony, support | Long tenure, team-oriented language, supportive roles, patient approach, loyalty emphasis | Be warm, provide reassurance, explain changes gradually, don't rush decisions |
| **C - Conscientiousness** | Accuracy, quality, expertise | Data-driven writing, analytical roles, detailed documentation, process-oriented career, credentials emphasis | Lead with data, provide documentation, allow analysis time, respect precision |

### How to Infer DISC Style

Analyze these observable signals from research:

**Career Pattern Indicators:**
- Rapid advancement / leadership titles / competitive moves → **D**
- Sales, BD, marketing, public speaking, community roles → **I**
- Long tenure, support roles, team coordination, mentoring → **S**
- Analytical, QA, compliance, research, technical specialist roles → **C**

**Writing & Communication Style (from articles, LinkedIn, public posts):**
- Short, direct, results-focused → **D**
- Enthusiastic, story-driven, people-focused → **I**
- Collaborative, inclusive, process-oriented → **S**
- Data-heavy, precise, evidence-based → **C**

**Role Responsibilities:**
- P&L ownership, strategic decisions, driving change → **D**
- Relationship management, team motivation, external engagement → **I**
- Operations, consistency, team support, steady execution → **S**
- Quality assurance, compliance, analysis, documentation → **C**

**Published Content Framing:**
- "We achieved X results" / "I drove this change" → **D**
- "Our amazing team" / "I'm thrilled to share" → **I**
- "We carefully built this together" / "Supporting our mission" → **S**
- "The data shows" / "Following our methodology" → **C**

### DISC Section Format (add to briefing document)

```markdown
## Communication Style Assessment (DISC)

> **Note:** This is an *estimated* communication profile based on publicly observable
> behavioral signals — not a formal DISC assessment. Use as a conversation preparation
> tool, not a definitive personality classification.

### Estimated Primary Style: [X - Name]
### Estimated Secondary Style: [Y - Name] (if evident)

**Confidence Level:** [High / Moderate / Low] — based on amount of observable data

### Evidence

| Signal | Observation | Indicates |
|:-------|:------------|:----------|
| Career pattern | [specific observation] | [D/I/S/C] |
| Writing style | [specific observation] | [D/I/S/C] |
| Role focus | [specific observation] | [D/I/S/C] |
| Public content | [specific observation] | [D/I/S/C] |

### How to Communicate with This Person

**Do:**
- [3-4 specific recommendations based on their style]

**Don't:**
- [2-3 things to avoid based on their style]

### Meeting Approach Recommendation

[1-2 sentences on how to structure the conversation, what to lead with,
and how to build rapport based on their estimated DISC style]
```

### Important Disclaimers

- **Always present as estimated/inferred**, never as definitive
- **Blend styles are normal** — most people are a mix of 2 styles
- **Context matters** — people behave differently in different settings
- **Never use DISC to make negative judgments** — all styles have strengths
- **More data = higher confidence** — published articles and career patterns are stronger signals than a job title alone

## Step 4: Generate Quarto Document

Create the briefing at: `templates/quarto-brand/_output/briefing-[DATE]-[slug].qmd`

Use this structure (based on `templates/quarto-brand/templates/meeting-briefing.qmd`):

```yaml
---
title: "Meeting Briefing"
subtitle: "[Meeting Title]"
author: "Prepared by Your Organization"
date: [today's date]
title-block-banner: "#1a5276"
title-block-banner-color: white
format:
  pdf:
    toc: false
  html:
    toc: true
  docx:
    toc: false
---
```

Fill in ALL sections:

### Quick Facts (callout-info)
- Role, Company, Location
- Email, LinkedIn

### Meeting Details (table)
- Meeting name, Date/Time, Duration, Platform, Attendees

### Background
- Professional background
- Key experience bullets
- Relevant expertise table

### Why This Meeting? (callout-highlight)
- your organization context and relationship
- What's at stake or opportunity

### Conversation Hooks (3 items)
- Specific topics to discuss
- Questions to ask
- Common ground opportunities

### Strategic Notes (callout-warning)
- Important reminders
- Relationship dynamics
- Things to listen for

### Research Sources
- Links to profiles, articles referenced

### Footer
- logo: `![](../assets/logo.png){width=150 fig-align="center"}`
- Attribution line

## Step 5: Export to Word

Use the your organization document converter for properly styled Word output:

```powershell
python utils/md_to_docx.py [source-file].md [output-file].docx
```

This applies your organization template styles:
- **your organization Header** → Main title (H1)
- **your organization Headers** → Section headers (H2)
- **your organization Sub Title** → Sub-sections (H3)
- **your organization Paragraph** → Body text
- **your organization Bullets** → Bullet lists
- **Table Text** → Table cells

### Alternative: Quarto (PDF/HTML)

For PDF or HTML output, use Quarto:
```powershell
quarto render [source-file].qmd --to pdf
quarto render [source-file].qmd --to html
```

## Output Summary

After completion, report:
```
✅ BRIEFING GENERATED

Meeting: [Title]
Date: [Date/Time]
Primary Contact: [Name] - [Role]

Files created:
- [project-path]/[DATE]-meeting-briefing.md (source)
- [project-path]/[DATE]-meeting-briefing.docx (branded Word)

Network updated: [Yes/No - if new contact added]
DISC Assessment: [Included / Not requested]
```

## Sales Mode (`--sales` flag)

When invoked with `--sales` flag OR when auto-detected (see below), activate sales-specific sections.

**Auto-detection:** Activate sales mode automatically when:
- No existing project folder exists for the contact's organization under `Projects/Clients/`
- Contact's person file in `network/` has `relationship_type: prospect` in YAML frontmatter
- User explicitly passes `--sales` flag

**When sales mode is active, add these sections after Step 3:**

### Step 3c: Sales Context Analysis

Build sales intelligence for the briefing:

**Decision Dynamics:**
- Who is the economic buyer? (Controls budget, can sign)
- Who influences the decision? (Evaluates solutions, recommends)
- Is there an existing relationship we can leverage?
- What's the buying process? (RFP, informal, sole source)

**Why your organization Wins This:**
- Competitive advantage for THIS specific opportunity
- Relevant past work / case studies
- Team expertise alignment
- Relationship leverage (existing trust)
- Right-sized (not too big, not too small)

**Competitive Landscape:**
- Who else might they be talking to?
- Local and national competitors
- Their weaknesses vs your organization

**Budget Signals to Listen For:**
- Is this funded or exploratory?
- FY timing — current budget or next year?
- Has the buyer gotten approval to engage outside help?
- Are they comparing multiple vendors?

**Discovery Questions:**
Frame questions that uncover:
1. Timeline urgency ("When do you need this done by?")
2. Budget reality ("Have you allocated budget for this?")
3. Decision process ("How will you decide on a partner?")
4. Success criteria ("What does success look like?")
5. Competitive pressure ("Are you evaluating other firms?")

### Sales-Specific Output Template

When `--sales` is active, replace the standard briefing output with this structure:

```markdown
---
tags:
  - "#meeting"
  - "#briefing"
  - "#sales"
  - "#client/[client-name]"
type: sales-brief
client: [Client Name]
meeting_date: [YYYY-MM-DD]
---

# Sales Brief: [Short Title]

**[Date] | [Time]**

---

## The Opportunity

[1-3 sentences: What they want, why they reached out]

---

## Attendees

| Name | Role | Why They Matter |
|:-----|:-----|:----------------|
| [Name](LinkedIn-URL) | Title @ Company | **Role type.** Key context. |

---

## Why your organization Wins

- [Advantage 1]
- [Advantage 2]
- [Advantage 3]

---

## [Company] Quick Facts

| | |
|:--|:--|
| **Size** | [Employees, revenue, locations] |
| **Focus** | [What they do] |
| **Key context** | [Anything relevant] |

---

## Decision Dynamics

| Role | Person |
|:-----|:-------|
| **Economic Buyer** | [Name] |
| **Technical Influencer** | [Name] |

**Budget signals to listen for:** [Key questions]

---

## Discovery Questions

- [3-5 key questions oriented toward closing]

---

## Next Steps (Expected)

1. Today: [Goal]
2. Follow-up: [What]
3. Win: [Engagement type]

---

## Competitors to Know

- [Key competitor] — [Why they matter]

---

*Internal | [Date]*
```

### Step 5b: Update Pipeline (Sales Mode Only)

After generating the sales brief, update `roadmap.md` Sales Pipeline table:

1. Find the row matching this opportunity (by client name or opportunity description)
2. If no row exists, add a new row: Opportunity name, Client, estimated value (if known), Stage (Discovery/Proposal Sent/Proposal Pending/Negotiation/Closed Won), Next Step, today's date as Last Activity
3. If row exists, update: Stage (if changed), Next Step, Last Activity (today's date)
4. Update the Pipeline Summary counts at the bottom of the table

**Do not remove rows** — only update or add. Closed opportunities should have Stage updated to "Closed Won" or "Closed Lost".

### Sales Mode Output Summary

```
SALES BRIEF GENERATED

Meeting: [Title]
Date: [Date/Time]
Prospect: [Company]
Decision Maker: [Name/Role]

Files created:
- Projects/Clients/[Client]/[DATE]-sales-brief.md
- Projects/Clients/[Client]/[DATE]-sales-brief.docx (branded)

Network updated: [Yes/No — new contacts added]
Pipeline updated: [Yes/No — roadmap.md Sales Pipeline]
```

## Improvement Backlog

> Captured from 2026-01-29 Alex Kim briefing lessons. Implement as bandwidth allows.

- [ ] **Internal/external contact detection** — Auto-detect when the contact is an internal your organization colleague (e.g., person file in `network/` has `company: Your Organization` in frontmatter). Adapt template: "Personnel Briefing" framing, working relationship focus, no conversation hooks section.
- [ ] **Personnel briefing template variant** — Create a lighter template for internal contacts: interaction history replaces meeting details, shared projects replaces "Why This Meeting?"
- [ ] **Stale data detection** — When briefing an existing `network/` contact, compare web research findings against stored person file data. Flag and auto-correct stale fields (title, location, org).
- [ ] **python-docx setup documentation** — Document `pip install python-docx` requirement in utils/ README or CLAUDE.md setup section.
- [ ] **Title validation on existing contacts** — Auto-search RocketReach/LinkedIn to validate current title for contacts already in `network/`, not just new contacts.

## Examples

```
/briefing Jane Smith
/briefing "Example Consulting Discussion" --disc
/briefing tomorrow's client call
/briefing John Doe --disc
/briefing on Sarah Example from Example Health Services Services --disc
/briefing Example Horizon --sales
/briefing "workflow automation" meeting --sales --disc
```
