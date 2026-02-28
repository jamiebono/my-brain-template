<%*
// ═══════════════════════════════════════════════════════════════════════════
// 📄 SOW / PROPOSAL TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Statement of Work template for consulting engagements
// Designed to be tight, quantified, and impact-led
// ═══════════════════════════════════════════════════════════════════════════

const clientName = await tp.system.prompt("Client Name:", "");
const projectName = await tp.system.prompt("Project Name:", "");
const preparedBy = await tp.system.prompt("Prepared By:", "Your Name");
const engagementType = await tp.system.suggester(
    ["Assessment", "Implementation", "Strategy", "Migration", "Integration", "Support", "Advisory", "Other"],
    ["assessment", "implementation", "strategy", "migration", "integration", "support", "advisory", "other"]
);

const safeProjectName = projectName.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '');
const safeClientTag = clientName.toLowerCase().replace(/\s+/g, '-');
const today = tp.date.now("YYYY-MM-DD");

// Move to project folder
await tp.file.move(`Projects/Clients/${clientName}/${safeProjectName}/${today}-sow-${safeProjectName}`);
-%>
---
tags:
  - "#proposal"
  - "#<% safeClientTag %>"
  - "#<% engagementType %>"
type: sow-proposal
client: <% clientName %>
project: <% projectName %>
status: draft
value: $
created_date: <% today %>
last_updated: <% today %>
---

# Statement of Work: <% projectName %>

**Prepared for:** <% clientName %>
**Prepared by:** <% preparedBy %>, Your Organization
**Date:** <% tp.date.now("MMMM D, YYYY") %>
**Document Status:** DRAFT

---

## 1. Executive Summary

> *2-3 sentences: What business problem does this solve and what outcome will the client achieve?*

<% tp.file.cursor() %>

---

## 2. Engagement Overview

| Field | Detail |
|:------|:-------|
| Client | <% clientName %> |
| Project | <% projectName %> |
| Type | <% engagementType.charAt(0).toUpperCase() + engagementType.slice(1) %> |
| Prepared By | <% preparedBy %> |
| Date | <% tp.date.now("MMMM D, YYYY") %> |
| Duration | *TBD* |

---

## 3. Scope of Work

### Phase 1: *[Phase Name]*

**Objective:** *What this phase achieves*

**Activities:**
- your organization will...
- your organization will...

### Phase 2: *[Phase Name]*

**Objective:** *What this phase achieves*

**Activities:**
- your organization will...
- your organization will...

### Out of Scope

- *Explicitly list what is NOT included*

---

## 4. Deliverables

| # | Deliverable | Description | Format | Timing |
|:-:|:------------|:------------|:-------|:-------|
| 1 |  |  | Document / Presentation | Phase 1 |
| 2 |  |  | Document / Presentation | Phase 2 |
| 3 |  |  | Document / Presentation | Phase 2 |

---

## 5. Timeline & Milestones

| Milestone | Target Date | Dependencies |
|:----------|:------------|:-------------|
| Kickoff |  | SOW execution |
| Phase 1 Complete |  |  |
| Phase 2 Complete |  |  |
| Final Delivery |  |  |

---

## 6. Team & Roles

### your organization Team

| Name | Role | Responsibilities |
|:-----|:-----|:-----------------|
| <% preparedBy %> | Project Lead | Overall delivery, client communication |
|  |  |  |

### Client Team

| Name | Role | Responsibilities |
|:-----|:-----|:-----------------|
|  | Executive Sponsor | Approvals, strategic direction |
|  | Project Owner | Day-to-day coordination, access |

---

## 7. Pricing

### Option A: Time & Materials

| Role | Rate | Est. Hours | Est. Total |
|:-----|-----:|-----------:|-----------:|
| Senior Consultant | $/hr |  | $ |
| Consultant | $/hr |  | $ |
| **Total** | | | **$** |

*Billed monthly based on actual hours. Not-to-exceed: $*

### Assumptions

- Client provides timely access to systems, data, and personnel
- Meetings and reviews are scheduled within agreed timeframes
- Change requests outside defined scope will be scoped separately

---

## 8. Assumptions & Dependencies

### Assumptions

1. Client will assign a dedicated project owner for the duration
2. Required systems access will be provisioned within 5 business days of kickoff
3. Client stakeholders are available for scheduled reviews
4.

### Dependencies

1. SOW execution and kickoff scheduling
2. Access to relevant systems and documentation
3.

---

## 9. Terms & Conditions

- This SOW is governed by the Master Services Agreement between <% clientName %> and Your Organization.
- Payment terms: Net 30 from invoice date
- Either party may terminate with 30 days written notice
- All work product delivered becomes property of <% clientName %> upon payment

---

**Accepted By:**

| | Client | your organization |
|:--|:-------|:----|
| **Name** | | <% preparedBy %> |
| **Title** | | |
| **Date** | | |
| **Signature** | | |

---

**Created:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Last Updated:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
