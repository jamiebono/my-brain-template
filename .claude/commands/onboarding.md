# Client/Contact Onboarding

Orchestrate the full onboarding workflow for a new client or contact - from first mention to active relationship tracking.

**Arguments:** $ARGUMENTS (person name, company name, or "new client [name]")

## Variants

This skill handles two scenarios:

| Variant | Trigger | What It Creates |
|---------|---------|-----------------|
| **New Person** | Single person name | Person file in `network/` |
| **New Client** | Company name or "new client X" | Full client folder + client-overview.md + person files in `network/` |

## Variant Detection

Parse $ARGUMENTS:
- If starts with "new client" → **New Client** workflow
- If matches a company name in recent emails/calendar → **New Client** workflow
- If appears to be a person's name → **New Person** workflow
- If ambiguous → Ask user which variant

---

# VARIANT 1: New Person Onboarding

For adding a single contact to the network (not a full client relationship).

## Step 1: Gather Context

Ask user (if not provided):
- How do you know this person?
- What organization are they with?
- Any relationship context? (met at event, referral, cold outreach)

Search existing files:
- `email_and_calendar_context/` for any emails or meetings with them
- `network/` folder to confirm they don't already have a person file (glob `network/*.md`, match by filename or `aliases` in frontmatter)
- `Projects/Clients/` to see if their org is already a client

## Step 2: Research (the Relationship Manager)

Use the Relationship Manager (alicia-relationship-manager agent) to research:

1. **LinkedIn profile** - Role, company, location, background
2. **Company info** - What the organization does (brief)
3. **Expertise areas** - What they're known for
4. **Shared connections** - Any your team overlap
5. **Recent activity** - Posts, news mentions

## Step 3: Add to Network

Create a person file in `network/` using the `tpl-person-light` template:

**Filename:** `network/[firstname-lastname].md` (lowercase, hyphenated)

The person file should have YAML frontmatter with:
```yaml
---
aliases: ["Full Name", "First Last"]
role: [Role]
company: [Company]
email: [if found]
phone: [if found]
linkedin: [URL]
location: [City, State]
met_via: [context from user]
relationship_type: [contact/prospect/client/partner]
first_contact: [today's date]
last_contact: [today's date]
needs_research: false
tags:
  - "#contact"
---
```

Body content should include research summary and relationship context.

## Step 4: Output

```
NEW CONTACT ADDED

Name: [Full Name]
Role: [Title] @ [Company]
Relationship: [type]

Created: network/[firstname-lastname].md
```

---

# VARIANT 2: New Client Onboarding

For establishing a full client relationship with folder structure, overview, and contacts.

## Step 1: Gather Context

Ask user (if not provided):
- What's the client engagement about?
- Who are the key contacts?
- Is there a specific project starting, or just relationship setup?

## Step 2: Research Organization (the Relationship Manager)

Use the Relationship Manager to research the organization thoroughly:

1. **Company profile**
   - Industry, size, revenue, employee count
   - Headquarters location
   - What they do (services, products, markets)

2. **Leadership**
   - CEO, CTO, CFO (public info)
   - Any known your organization connections

3. **Recent news**
   - Funding, acquisitions, leadership changes
   - Strategic initiatives
   - Technology investments

4. **Regulatory context**
   - Industry compliance requirements
   - Relevant certifications

5. **Network affiliations**
   - Parent company / subsidiaries
   - Trade associations, IPAs, partnerships

## Step 3: Research Contacts (the Relationship Manager)

For each contact the user mentioned, research:
- Full profile (LinkedIn, role, background)
- Decision authority (buyer, influencer, user)
- Any your organization relationship history

## Step 4: Create Folder Structure (the Vault Organizer)

Create client folder at `Projects/Clients/[Client-Name]/`:

```
Projects/Clients/[Client-Name]/
├── client-overview.md      (from template)
├── email/
│   ├── in/
│   └── out/
├── meetings/
│   ├── meeting_notes/
│   └── meeting_transcripts/
└── [project-name]/         (if project specified)
    └── project-brief.md    (from template)
```

## Step 5: Create Client Overview (Curator)

Use template `templates/tpl-client-overview.md` to create `client-overview.md`:

Fill in all sections:
- Client basics (name, industry, location, size)
- Primary contacts (from research)
- Relationship health indicators
- Engagement history (starting now)
- Strategic notes

## Step 6: Create Project Brief (if applicable)

If a specific project is starting:
- Use template `templates/tpl-project-brief.md`
- Fill in known scope, contacts, timeline
- Mark status as "discovery" or "active"

## Step 7: Update Network

Create person files in `network/` for all contacts using `tpl-person-light` template:
- Full profile information in YAML frontmatter
- Organization linked to client folder
- `relationship_type: client`
- `first_contact` and `last_contact` dates

## Step 8: Output

```
CLIENT ONBOARDED

Client: [Name]
Industry: [Industry]
Folder: Projects/Clients/[Client-Name]/

Files created:
- client-overview.md
- email/in/, email/out/, meetings/ folders
- [project-brief.md if applicable]

Person files created in network/:
- [Name 1] - [Role]
- [Name 2] - [Role]

Next steps:
- Review client-overview.md for accuracy
- Schedule kickoff meeting
- Begin project work
```

---

## Relationship to Other Skills

| Skill | When to Use |
|-------|-------------|
| `/onboarding` | Setting up new client/contact for the first time |
| `/sales` | Preparing for a sales call with a prospect |
| `/briefing` | Preparing for any meeting (existing or new contact) |
| `/network` | Searching existing contacts for connections |

**Typical flow:**
1. `/onboarding new client Example Horizon` → Sets up client
2. `/sales Example Horizon meeting` → Prepares sales brief
3. `/briefing New Contact` → Prepares for specific meeting (later)

---

## Examples

```
/onboarding New Contact
/onboarding new client Example Horizon
/onboarding "the contact from Brian's email"
/onboarding Acme Corp
```
