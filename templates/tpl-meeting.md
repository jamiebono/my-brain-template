<%*
// ═══════════════════════════════════════════════════════════════════════════
// 📝 MEETING NOTES TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Comprehensive meeting capture with automatic context and follow-up tracking
// Designed for consulting professionals
// ═══════════════════════════════════════════════════════════════════════════

// Prompt for meeting details
const meetingTitle = await tp.system.prompt("Meeting Title:", "");
const clientName = await tp.system.prompt("Client/Company (leave blank for internal):", "");
const attendees = await tp.system.prompt("Attendees (comma-separated):", "");
const meetingType = await tp.system.suggester(
    ["Discovery/Kickoff", "Status Update", "Technical Deep Dive", "Strategy Session", "Stakeholder Review", "Internal Planning", "1:1", "Other"],
    ["discovery", "status", "technical", "strategy", "stakeholder", "internal", "one-on-one", "other"]
);

// Date and time
const meetingDate = tp.file.title.match(/\d{4}-\d{2}-\d{2}/) 
    ? tp.file.title.match(/\d{4}-\d{2}-\d{2}/)[0] 
    : tp.date.now("YYYY-MM-DD");
const startTime = await tp.system.prompt("Start Time (HH:MM):", tp.date.now("HH:00"));
const duration = await tp.system.suggester(
    ["30 min", "45 min", "1 hour", "90 min", "2 hours", "Half day", "Full day"],
    ["30", "45", "60", "90", "120", "240", "480"]
);

// Generate filename
const safeTitle = meetingTitle.replace(/[^a-zA-Z0-9\s]/g, '').replace(/\s+/g, '-').toLowerCase();
const filename = `${meetingDate}-${safeTitle}`;
await tp.file.rename(filename);

// Calculate end time using moment
const endTime = moment(startTime, "HH:mm").add(parseInt(duration), 'minutes').format("HH:mm");

// Attendee processing
const attendeeList = attendees.split(',').map(a => a.trim()).filter(a => a);
const attendeeLinks = attendeeList.length > 0 
    ? attendeeList.map(a => `[[${a}]]`).join(', ')
    : "TBD";

// Meeting type emoji
const typeEmoji = {
    "discovery": "🔍",
    "status": "📊",
    "technical": "🔧",
    "strategy": "🎯",
    "stakeholder": "👥",
    "internal": "🏠",
    "one-on-one": "👤",
    "other": "📝"
}[meetingType];

// Tags
const clientTag = clientName ? clientName.toLowerCase().replace(/\s+/g, '-') : "internal";
const yearTag = moment(meetingDate).format("YYYY");

// Format meeting date for display
const meetingDateFormatted = moment(meetingDate).format("dddd, MMMM D, YYYY");
const meetingDateShort = moment(meetingDate).format("MMM D");

// Meeting type capitalized
const meetingTypeCap = meetingType.charAt(0).toUpperCase() + meetingType.slice(1).replace(/-/g, ' ');

// Build attendee YAML list
let attendeeYaml = '';
for (const attendee of attendeeList) {
    attendeeYaml += `  - "${attendee}"\n`;
}

// Client or counterparty name
const counterpartyName = clientName || "Counterparty";

// Current timestamp
const currentTimestamp = tp.date.now("YYYY-MM-DD HH:mm");

// Client links section
const clientLinks = clientName 
    ? `**See also:** [[Projects/Clients/${clientName}/client-overview|${clientName} Overview]], [[todo]], [[network]]`
    : `**See also:** [[todo]], [[roadmap]], [[network]]`;
_%>---
tags:
  - meeting
  - <%= meetingType %>
  - <%= clientTag %>
  - <%= yearTag %>
client: <%= clientName || "Internal" %>
project: 
meeting_type: <%= meetingType %>
meeting_date: <%= meetingDate %>
start_time: <%= startTime %>
end_time: <%= endTime %>
duration_min: <%= duration %>
attendees:
<%= attendeeYaml %>status: completed
follow_up_required: false
action_items_count: 0
created: <%= currentTimestamp %>
---

# <%= typeEmoji %> <%= meetingTitle %>

> [!info] Meeting Details
> **Date:** <%= meetingDateFormatted %>
> **Time:** <%= startTime %> - <%= endTime %> (<%= duration %> min)
> **Type:** <%= meetingTypeCap %>
> **Attendees:** <%= attendeeLinks %>

<%= clientLinks %>

---

## 🎯 Meeting Objectives

> [!question] What did we set out to accomplish?

1. 
2. 
3. 

**Success criteria:**

---

## 📋 Agenda

- [ ] 
- [ ] 
- [ ] 

---

## 💬 Discussion Notes

### Key Topics

#### Topic 1:

**Discussion:**

**Decisions made:**

**Open questions:**

---

#### Topic 2:

**Discussion:**

**Decisions made:**

**Open questions:**

---

#### Topic 3:

**Discussion:**

**Decisions made:**

**Open questions:**

---

## 💡 Key Insights

> [!tip] Aha moments and important realizations

1. **Insight:**
   - *Implication:*

2. **Insight:**
   - *Implication:*

3. **Insight:**
   - *Implication:*

---

## ✅ Decisions Made

| Decision | Rationale | Owner | Date Needed By |
|:---------|:----------|:------|:---------------|
|          |           |       |                |
|          |           |       |                |

---

## 📌 Action Items

> [!todo] Track all commitments made

### Our Commitments (your organization)

| Action | Owner | Due Date | Status |
|:-------|:------|:---------|:------:|
|        | You |          | ⬜     |
|        |       |          | ⬜     |
|        |       |          | ⬜     |

### Their Commitments (<%= counterpartyName %>)

| Action | Owner | Due Date | Status |
|:-------|:------|:---------|:------:|
|        |       |          | ⬜     |
|        |       |          | ⬜     |

### Shared/Joint Actions

| Action | Owners | Due Date | Status |
|:-------|:-------|:---------|:------:|
|        |        |          | ⬜     |

---

## ❓ Open Questions

> [!question] Items needing further research or clarification

| Question | Owner | Needed By | Priority |
|:---------|:------|:----------|:--------:|
|          |       |           | 🔴/🟡/🟢 |
|          |       |           |          |

---

## 📊 Risks & Concerns

> [!warning] Issues raised or identified

| Risk/Concern | Likelihood | Impact | Mitigation |
|:-------------|:-----------|:-------|:-----------|
|              | H/M/L      | H/M/L  |            |
|              |            |        |            |

---

## 🔮 Next Steps

### Immediate (Next 24-48 hrs)

- [ ] 

### Short-term (This week)

- [ ] 

### Follow-up Meeting

**Proposed Date:**

**Topics to Cover:**
- 

---

## 📝 Raw Notes

> [!abstract]- Unstructured capture (expand to view)
> *Paste voice transcription or raw notes here for later processing*
> 
> 

---

## 🎭 Meeting Effectiveness

> [!success]- Rate this meeting (complete after)

**Objectives achieved?** ⬜ Fully | ⬜ Partially | ⬜ Not at all

**Time well spent?** ⭐⭐⭐⭐⭐

**Engagement level:** ⬜ High | ⬜ Medium | ⬜ Low

**What would improve next time?**

---

## 📧 Follow-up Communication

> [!note]- Draft follow-up email (complete after)

**To:**

**Subject:** Follow-up: <%= meetingTitle %> (<%= meetingDateShort %>)

---

Hi [Name],

Thank you for taking the time to meet today. Here's a quick summary of what we discussed:

**Key Decisions:**
- 

**Action Items:**
- [ ] [You]: 
- [ ] [Us]: 

**Next Steps:**
- 

Please let me know if I've missed anything or if you have any questions.

Best regards,
You

---

---

**Created:** <%= currentTimestamp %>
**Last Updated:** <%= currentTimestamp %>
```button
name 📋 Copy Action Items to Todo
type command
action Templater: Insert templates/snippets/copy-actions-to-todo.md
```
```button
name 📧 Generate Follow-up Email
type command
action Templater: Insert templates/snippets/generate-followup.md
```

[//begin]: # "Autogenerated link references for markdown compatibility"
[todo]: ../../todo.md "Todo"
[roadmap]: ../../roadmap.md "Roadmap"
[network]: ../../network.md "Network"
[//end]: # "Autogenerated link references"