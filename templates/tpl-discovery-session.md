<%*
// ═══════════════════════════════════════════════════════════════════════════
// 🔍 DISCOVERY SESSION TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Structured framework for client discovery and assessment sessions
// Captures context, pain points, opportunities, and next steps
// ═══════════════════════════════════════════════════════════════════════════

const sessionTitle = await tp.system.prompt("Session Title:", "Discovery Session");
const clientName = await tp.system.prompt("Client Name:", "");
const attendees = await tp.system.prompt("Key Attendees (comma-separated):", "");
const focusArea = await tp.system.suggester(
    ["Architecture Assessment", "AI/ML Strategy", "Data Platform", "Cloud Migration", "Process Improvement", "General Discovery", "Technical Deep Dive"],
    ["architecture", "ai-strategy", "data-platform", "migration", "process", "general", "technical"]
);

const sessionDate = tp.date.now("YYYY-MM-DD");
const safeTitle = sessionTitle.replace(/[^a-zA-Z0-9\s]/g, '').replace(/\s+/g, '-').toLowerCase();
const safeClient = clientName.toLowerCase().replace(/\s+/g, '-');

await tp.file.rename(`${sessionDate}-${safeTitle}`);
-%>
---
tags:
  - "#discovery"
  - "#meeting"
  - "#<% focusArea %>"
  - "#<% safeClient %>"
type: discovery-session
client: <% clientName %>
session_title: <% sessionTitle %>
focus_area: <% focusArea %>
session_date: <% sessionDate %>
attendees: [<% attendees %>]
status: completed
follow_up_required: true
created: <% tp.date.now("YYYY-MM-DD HH:mm") %>
---

# 🔍 <% sessionTitle %>

> [!info] Session Overview
> **Client:** [[Projects/Clients/<% clientName %>/client-overview|<% clientName %>]]  
> **Date:** <% moment(sessionDate).format("dddd, MMMM D, YYYY") %>  
> **Focus:** <% focusArea.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') %>  
> **Attendees:** <% attendees %>

**See also:** [[../client-overview]], [[../../../todo]], [[../../../network]]

---

## 🎯 Session Objectives

> [!question] What did we set out to learn?

1. 
2. 
3. 

---

## 🏢 Context Setting

### Their World

**Company/Team Overview:**


**Current State Summary:**


**Recent Changes/Pressures:**


### Why Now?

**Triggering Event:**


**Urgency Level:** 🔴 Critical | 🟡 Important | 🟢 Nice to Have

**Decision Timeline:**


---

## 😫 Pain Points & Challenges

> [!warning] What's hurting them?

### Primary Pain Points

| Pain Point | Severity | Frequency | Current Workaround |
|:-----------|:--------:|:---------:|:-------------------|
|  | H/M/L | Daily/Weekly/Monthly |  |
|  |  |  |  |
|  |  |  |  |

### Root Cause Analysis

```
Pain Point 1: _______________
     │
     ├── Why? _______________
     │    │
     │    └── Why? _______________
     │         │
     │         └── Why? _______________
     │              │
     │              └── Root Cause: _______________
```

### Impact Quantification

| Impact Area | Metric | Current | Desired | Gap |
|:------------|:-------|:--------|:--------|:----|
| Time |  |  |  |  |
| Cost |  |  |  |  |
| Quality |  |  |  |  |
| Risk |  |  |  |  |

---

## 🎯 Goals & Desired Outcomes

> [!success] What does success look like for them?

### Stated Goals

1. **Goal:** 
   - *Success Metric:* 
   - *Timeline:* 

2. **Goal:** 
   - *Success Metric:* 
   - *Timeline:* 

3. **Goal:** 
   - *Success Metric:* 
   - *Timeline:* 

### Unstated/Implied Goals

> Things they didn't explicitly say but seem to want

- 

### Priority Stack Rank

```
1. [MUST HAVE]     _______________
2. [SHOULD HAVE]   _______________
3. [NICE TO HAVE]  _______________
```

---

## 🔧 Current State Assessment

### Technology Landscape

| Category | Current Solution | Pain Level | Notes |
|:---------|:-----------------|:----------:|:------|
| Data Platform |  | 🔴/🟡/🟢 |  |
| Analytics |  |  |  |
| Integration |  |  |  |
| Cloud |  |  |  |
| Security |  |  |  |

### Process Maturity

| Process | Maturity | Owner | Documentation |
|:--------|:--------:|:------|:-------------:|
|  | 1-5 |  | Y/N |

### Team & Skills

| Role | Count | Skill Level | Gaps |
|:-----|:-----:|:------------|:-----|
|  |  | Jr/Mid/Sr |  |

### Architecture Diagram (As-Is)

```
┌─────────────────────────────────────────────────────────────┐
│                     CURRENT STATE                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                                                             │
│                                                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 💡 Opportunities Identified

> [!tip] Where can we add value?

### Quick Wins (0-30 days)

| Opportunity | Effort | Impact | Confidence |
|:------------|:------:|:------:|:----------:|
|  | L/M/H | L/M/H | High/Med/Low |
|  |  |  |  |

### Strategic Initiatives (30-90 days)

| Opportunity | Investment | ROI Potential | Dependencies |
|:------------|:-----------|:--------------|:-------------|
|  |  |  |  |
|  |  |  |  |

### Transformational (90+ days)

| Opportunity | Description | Strategic Value |
|:------------|:------------|:----------------|
|  |  |  |

---

## ⚠️ Risks & Constraints

### Technical Risks

| Risk | Likelihood | Impact | Mitigation |
|:-----|:-----------|:-------|:-----------|
|  | H/M/L | H/M/L |  |

### Organizational Constraints

- **Budget:** 
- **Timeline:** 
- **Resources:** 
- **Political:** 
- **Technical Debt:** 

### Red Flags 🚩

> Things that concern me about this engagement

- 

---

## 👥 Stakeholder Map

### Power/Interest Grid

```
         High Power
              │
    ┌─────────┼─────────┐
    │ Keep    │ Manage  │
    │ Satisfied│ Closely │
    │         │         │
Low ├─────────┼─────────┤ High
Int │ Monitor │ Keep    │ Interest
    │         │ Informed│
    │         │         │
    └─────────┼─────────┘
              │
         Low Power
```

### Key Players

| Name | Role | Stance | Influence | Notes |
|:-----|:-----|:------:|:---------:|:------|
|  |  | Champion/Neutral/Skeptic | H/M/L |  |
|  |  |  |  |  |

### Decision Making Process

**Decision Maker:** 
**Influencers:** 
**Approval Process:** 
**Budget Authority:** 

---

## 💬 Key Quotes & Insights

> [!quote] Verbatim quotes that reveal priorities

> "_____________________________________________"
> — [Name], [Context]

> "_____________________________________________"
> — [Name], [Context]

---

## 🧩 Solution Hypothesis

> [!abstract] Initial thinking on approach

### Proposed Approach

**High-Level Solution:**


### Why This Approach

1. 
2. 
3. 

### Alternatives Considered

| Alternative | Pros | Cons | Why Not |
|:------------|:-----|:-----|:--------|
|  |  |  |  |

### Architecture Diagram (To-Be)

```
┌─────────────────────────────────────────────────────────────┐
│                     PROPOSED STATE                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                                                             │
│                                                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## ❓ Open Questions

### Questions for Client

| Question | Priority | Owner | Status |
|:---------|:--------:|:------|:------:|
|  | H/M/L |  | ⬜ |
|  |  |  | ⬜ |

### Questions for Internal Team

| Question | Who To Ask | Status |
|:---------|:-----------|:------:|
|  |  | ⬜ |

---

## ✅ Action Items

### Immediate Follow-ups (24-48 hrs)

- [ ] Send thank you / recap email
- [ ] 
- [ ] 

### Deliverables Promised

| Deliverable | Owner | Due Date | Status |
|:------------|:------|:---------|:------:|
|  | You |  | ⬜ |
|  |  |  | ⬜ |

### Next Steps

**Next Meeting:** 
**Agenda:** 

---

## 📊 Engagement Readiness

### Deal Qualification

| Criterion | Score | Notes |
|:----------|:-----:|:------|
| Budget | 1-5 |  |
| Authority | 1-5 |  |
| Need | 1-5 |  |
| Timeline | 1-5 |  |
| **BANT Total** | /20 |  |

### Engagement Fit

- [ ] Aligns with our capabilities
- [ ] Reasonable timeline
- [ ] Appropriate budget range
- [ ] Right stakeholder engagement
- [ ] Clear success criteria

### Recommended Next Step

⬜ Proceed to proposal
⬜ Schedule follow-up discovery
⬜ Decline gracefully
⬜ Refer to partner

---

## 📝 Raw Notes

> [!abstract]- Unstructured session capture

*Voice transcription or raw notes here*

---

**Session Date:** <% sessionDate %>
**Created:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Follow-up Due:** <% moment().add(2, 'days').format("YYYY-MM-DD") %>

```button
name 📧 Generate Recap Email
type command
action Templater: Insert templates/snippets/discovery-recap-email.md
```

```button
name 📋 Create Proposal Outline
type command
action Templater: Insert templates/snippets/proposal-outline.md
```

[//begin]: # "Autogenerated link references for markdown compatibility"
[../client-overview]: ../client-overview.md "Client Overview"
[../../../todo]: ../../../todo.md "Todo"
[../../../network]: ../../../network.md "Network"
[//end]: # "Autogenerated link references"
