<%*
// ═══════════════════════════════════════════════════════════════════════════
// 📋 PROJECT BRIEF TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Single source of truth for project status, scope, and health
// Designed for consulting engagements
// ═══════════════════════════════════════════════════════════════════════════

const projectName = await tp.system.prompt("Project Name:", "");
const clientName = await tp.system.prompt("Client Name:", "");
const projectType = await tp.system.suggester(
    ["Assessment", "Implementation", "Strategy", "Migration", "Integration", "Support", "Training", "Other"],
    ["assessment", "implementation", "strategy", "migration", "integration", "support", "training", "other"]
);
const startDate = await tp.system.prompt("Start Date (YYYY-MM-DD):", tp.date.now("YYYY-MM-DD"));
const targetEnd = await tp.system.prompt("Target End Date (YYYY-MM-DD):", moment().add(3, 'months').format("YYYY-MM-DD"));
const projectLead = await tp.system.prompt("Project Lead:", "Your Name");
const budgetHours = await tp.system.prompt("Budget (hours):", "");

const safeProjectName = projectName.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '');
const safeClientTag = clientName.toLowerCase().replace(/\s+/g, '-');

// Move to project folder
await tp.file.move(`Projects/Clients/${clientName}/${safeProjectName}/project-brief`);

const today = tp.date.now("YYYY-MM-DD");

// Calculate project duration
const duration = moment(targetEnd).diff(moment(startDate), 'weeks');
-%>
---
tags:
  - "#project"
  - "#<% projectType %>"
  - "#<% safeClientTag %>"
type: project-brief
client: <% clientName %>
project: <% projectName %>
project_type: <% projectType %>
status: active
health: 🟢
start_date: <% startDate %>
target_end: <% targetEnd %>
actual_end: 
project_lead: <% projectLead %>
budget_hours: <% budgetHours %>
hours_used: 0
budget_remaining: <% budgetHours %>
created: <% tp.date.now("YYYY-MM-DD HH:mm") %>
last_updated: <% tp.date.now("YYYY-MM-DD HH:mm") %>
---

# 📋 <% projectName %>

> [!info] Project Snapshot
> **Client:** [[../client-overview|<% clientName %>]]  
> **Type:** <% projectType.charAt(0).toUpperCase() + projectType.slice(1) %>  
> **Duration:** <% duration %> weeks (<% startDate %> → <% targetEnd %>)  
> **Lead:** <% projectLead %>  
> **Health:** 🟢 On Track

**See also:** [[../client-overview]], [[../../../todo]], [[../../../roadmap]]

---

## 🎯 Project Overview

### Objective

> [!tip] What are we trying to accomplish?


### Success Criteria

> [!success] How will we know we've succeeded?

1. [ ] 
2. [ ] 
3. [ ] 

### Out of Scope

> [!warning] What are we explicitly NOT doing?

- 

---

## 📊 Status Dashboard

### Overall Health

```meta-bind
INPUT[inlineSelect(option(🟢 On Track), option(🟡 At Risk), option(🔴 Off Track), option(⏸️ On Hold), option(✅ Complete)):health]
```

### Key Metrics

| Metric | Current | Target | Status |
|:-------|--------:|-------:|:------:|
| Hours Used | 0 | <% budgetHours %> | 🟢 |
| Budget Used | 0% | 100% | 🟢 |
| Timeline | Week 0 | Week <% duration %> | 🟢 |
| Deliverables | 0/? | 100% | 🟢 |

### Progress Visualization

```
Timeline:   [░░░░░░░░░░░░░░░░░░░░] 0%
Budget:     [░░░░░░░░░░░░░░░░░░░░] 0%
Scope:      [░░░░░░░░░░░░░░░░░░░░] 0%
```

---

## 📅 Timeline & Milestones

```mermaid
gantt
    title Project Timeline
    dateFormat  YYYY-MM-DD
    section Phases
    Kickoff           :done,    p1, <% startDate %>, 1w
    Discovery         :active,  p2, after p1, 2w
    Analysis          :         p3, after p2, 2w
    Delivery          :         p4, after p3, 2w
    Closeout          :         p5, after p4, 1w
```

### Key Milestones

| Milestone | Target Date | Actual | Status |
|:----------|:------------|:-------|:------:|
| Kickoff Complete | <% startDate %> |  | ⬜ |
| Discovery Complete |  |  | ⬜ |
| Draft Deliverables |  |  | ⬜ |
| Final Delivery | <% targetEnd %> |  | ⬜ |

---

## 📦 Deliverables

### Committed Deliverables

| Deliverable | Description | Due Date | Status |
|:------------|:------------|:---------|:------:|
|  |  |  | ⬜ Not Started |
|  |  |  | ⬜ Not Started |
|  |  |  | ⬜ Not Started |

### Status Key
- ⬜ Not Started
- 🔄 In Progress
- 📝 In Review
- ✅ Complete
- ❌ Blocked

---

## 👥 Team & Stakeholders

### Project Team (your organization)

| Role | Name | Allocation | Responsibilities |
|:-----|:-----|:-----------|:-----------------|
| Project Lead | <% projectLead %> | 50% |  |
|  |  |  |  |

### Client Stakeholders

| Role | Name | Email | Decision Authority |
|:-----|:-----|:------|:------------------|
| Executive Sponsor |  |  | Budget, Strategy |
| Project Owner |  |  | Scope, Priorities |
| Technical Lead |  |  | Technical decisions |

### RACI Matrix

| Activity | <% projectLead %> | Client PM | Tech Lead | Exec Sponsor |
|:---------|:------------------|:----------|:----------|:-------------|
| Technical decisions | C | I | R | I |
| Scope changes | A | R | C | A |
| Budget approval | I | R | I | A |
| Deliverable review | R | A | C | I |

*R = Responsible, A = Accountable, C = Consulted, I = Informed*

---

## ⚠️ Risks & Issues

### Active Risks

| Risk | Likelihood | Impact | Mitigation | Owner |
|:-----|:-----------|:-------|:-----------|:------|
|  | H/M/L | H/M/L |  |  |

### Active Issues

| Issue | Impact | Status | Owner | Target Resolution |
|:------|:-------|:-------|:------|:------------------|
|  |  | 🔴 Open |  |  |

### Blockers

| Blocker | Blocked Since | Impact | Resolution Path |
|:--------|:--------------|:-------|:----------------|
|  |  |  |  |

---

## 📝 Decisions Log

| Date | Decision | Rationale | Made By | Impact |
|:-----|:---------|:----------|:--------|:-------|
| <% today %> | Project kickoff | N/A | <% projectLead %> | Baseline |

---

## 💬 Communication Plan

### Status Updates

| Audience | Format | Frequency | Owner |
|:---------|:-------|:----------|:------|
| Client PM | Email | Weekly |  |
| Executive Sponsor | Summary | Bi-weekly |  |
| Internal Team | Standup | Daily |  |

### Key Meetings

| Meeting | Attendees | Cadence | Day/Time |
|:--------|:----------|:--------|:---------|
| Status Call |  | Weekly |  |
| Technical Review |  | As needed |  |

---

## 💰 Budget & Time

### Hours Summary

| Category | Budgeted | Used | Remaining | % Used |
|:---------|:--------:|:----:|:---------:|:------:|
| Discovery |  | 0 |  | 0% |
| Analysis |  | 0 |  | 0% |
| Delivery |  | 0 |  | 0% |
| PM/Admin |  | 0 |  | 0% |
| **Total** | **<% budgetHours %>** | **0** | **<% budgetHours %>** | **0%** |

### Budget Health

```
Budget Burn Rate:
[░░░░░░░░░░░░░░░░░░░░] 0% used
                       ▲ Current: Week 0 of <% duration %>
```

---

## ✅ Action Items

### Open Actions

| Action | Owner | Due | Priority | Status |
|:-------|:------|:----|:--------:|:------:|
|  |  |  | 🔴/🟡/🟢 | ⬜ |

### Waiting On Client

| Item | Who | Since | Impact |
|:-----|:----|:------|:-------|
|  |  |  |  |

---

## 📎 Resources & Links

### Internal Documents

- [[meeting-notes/]] - All meeting notes
- 

### Client-Provided Materials

- 

### External Resources

- 

### Access & Credentials

| System | URL | Access Level | Notes |
|:-------|:----|:-------------|:------|
|  |  |  |  |

---

## 📓 Project Journal

### Latest Updates

> **<% today %>** — Project initiated


---

## 🔮 Lessons Learned

> [!abstract]- Complete at project close

### What Went Well


### What Could Improve


### Recommendations for Next Time


---

**Created:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Last Updated:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Next Review:** Weekly

```button
name 📊 Update Status
type command
action Templater: Insert templates/snippets/project-status-update.md
```

```button
name ⏱️ Log Hours
type command
action Templater: Insert templates/snippets/log-hours.md
```

[//begin]: # "Autogenerated link references for markdown compatibility"
[../client-overview]: ../client-overview.md "Client Overview"
[../../../todo]: ../../../todo.md "Todo"
[../../../roadmap]: ../../../roadmap.md "Roadmap"
[//end]: # "Autogenerated link references"
