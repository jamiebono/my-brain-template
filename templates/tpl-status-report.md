<%*
// ═══════════════════════════════════════════════════════════════════════════
// 📊 STATUS REPORT TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Weekly client status report for email or stakeholder delivery
// ═══════════════════════════════════════════════════════════════════════════

// Prompt for report details
const clientName = await tp.system.prompt("Client Name:", "");
const projectName = await tp.system.prompt("Project Name:", "");

// Date calculations
const reportDate = tp.date.now("YYYY-MM-DD");
const today = moment();
const monday = moment().startOf('isoWeek');
const weekLabel = monday.format("MMMM D, YYYY");
const weekNumber = today.isoWeek();

// Generate filename
const safeClient = clientName.replace(/[^a-zA-Z0-9\s]/g, '').replace(/\s+/g, '-').toLowerCase();
const filename = `${reportDate}-${safeClient}-status`;
await tp.file.rename(filename);

// Tags
const clientTag = clientName.toLowerCase().replace(/\s+/g, '-');
const currentTimestamp = tp.date.now("YYYY-MM-DD HH:mm");
_%>---
tags:
  - "#status-report"
  - "#client/<%= clientTag %>"
type: status-report
client: <%= clientName %>
project: <%= projectName %>
week_of: <%= monday.format("YYYY-MM-DD") %>
week_number: W<%= weekNumber %>
created: <%= currentTimestamp %>
---

# Status Report: <%= clientName %> / <%= projectName %>

**Week of <%= weekLabel %>** | W<%= weekNumber %>

---

## Hours This Week

| Date | Hours | Task | Notes |
|:-----|:------|:-----|:------|
| Mon  |       |      |       |
| Tue  |       |      |       |
| Wed  |       |      |       |
| Thu  |       |      |       |
| Fri  |       |      |       |
| **Total** | **0.0h** | | **(planned: Xh)** |

---

## Accomplishments

-
-
-

---

## Upcoming Work

- [ ]
- [ ]
- [ ]

---

## Risks / Blockers

| Risk/Blocker | Impact | Mitigation | Owner |
|:-------------|:-------|:-----------|:------|
| None         |        |            |       |

---

## Decisions Needed

> Items requiring client input or approval

-

---

## Next Steps

1. **This week:**
2. **Next week:**
3. **Upcoming:**

---

**Created:** <%= currentTimestamp %>
**Last Updated:** <%= currentTimestamp %>
