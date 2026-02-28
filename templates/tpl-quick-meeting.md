<%*
// ═══════════════════════════════════════════════════════════════════════════
// 📝 QUICK MEETING TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Lightweight template for routine status calls and check-ins
// ~50 lines, designed for 30-minute meetings (70% of meetings)
// ═══════════════════════════════════════════════════════════════════════════

// Prompt for meeting details
const meetingTitle = await tp.system.prompt("Meeting Title:", "");
const clientName = await tp.system.prompt("Client/Company (leave blank for internal):", "");
const projectName = await tp.system.prompt("Project (optional):", "");
const attendees = await tp.system.prompt("Attendees (comma-separated):", "");

// Date and time
const meetingDate = tp.file.title.match(/\d{4}-\d{2}-\d{2}/)
    ? tp.file.title.match(/\d{4}-\d{2}-\d{2}/)[0]
    : tp.date.now("YYYY-MM-DD");

// Generate filename
const safeTitle = meetingTitle.replace(/[^a-zA-Z0-9\s]/g, '').replace(/\s+/g, '-').toLowerCase();
const filename = `${meetingDate}-${safeTitle}`;
await tp.file.rename(filename);

// Attendee processing
const attendeeList = attendees.split(',').map(a => a.trim()).filter(a => a);
const attendeeLinks = attendeeList.length > 0
    ? attendeeList.map(a => `[[${a}]]`).join(', ')
    : "TBD";

// Tags
const clientTag = clientName ? clientName.toLowerCase().replace(/\s+/g, '-') : "internal";

// Build attendee YAML list
let attendeeYaml = '';
for (const attendee of attendeeList) {
    attendeeYaml += `  - "${attendee}"\n`;
}

// Current timestamp
const currentTimestamp = tp.date.now("YYYY-MM-DD HH:mm");
_%>---
tags:
  - meeting
  - quick-meeting
  - <%= clientTag %>
client: <%= clientName || "Internal" %>
project: <%= projectName || "" %>
meeting_date: <%= meetingDate %>
attendees:
<%= attendeeYaml %>status: completed
created: <%= currentTimestamp %>
---

# 📝 <%= meetingTitle %>

**Date:** <%= meetingDate %>
**Attendees:** <%= attendeeLinks %>

---

## Agenda / Purpose

<% tp.file.cursor() %>

---

## Key Discussion Points

-

---

## Decisions Made

-

---

## Action Items

| Action | Owner | Due |
|:-------|:------|:----|
|        |       |     |
|        |       |     |

---

## Next Steps

-

---

**Created:** <%= currentTimestamp %>
**Last Updated:** <%= currentTimestamp %>
