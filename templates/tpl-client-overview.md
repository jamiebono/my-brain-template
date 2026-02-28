<%*
// ═══════════════════════════════════════════════════════════════════════════
// 🏢 CLIENT OVERVIEW TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Comprehensive client relationship tracker for consulting professionals
// The single source of truth for a client relationship
// ═══════════════════════════════════════════════════════════════════════════

const clientName = await tp.system.prompt("Client Name:", "");
const industry = await tp.system.suggester(
    ["Healthcare", "Financial Services", "Technology", "Manufacturing", "Environmental", "Government", "Education", "Non-Profit", "Other"],
    ["healthcare", "financial-services", "technology", "manufacturing", "environmental", "government", "education", "non-profit", "other"]
);
const relationshipOwner = await tp.system.prompt("Relationship Owner (your organization):", "Your Name");
const primaryContact = await tp.system.prompt("Primary Client Contact:", "");

// Create client folder and rename file
const folderPath = `Projects/Clients/${clientName}`;
await tp.file.move(`${folderPath}/client-overview`);

const today = tp.date.now("YYYY-MM-DD");
const safeClientTag = clientName.toLowerCase().replace(/\s+/g, '-');
-%>
---
tags:
  - "#client"
  - "#<% industry %>"
  - "#<% safeClientTag %>"
type: client-overview
client: <% clientName %>
industry: <% industry %>
relationship_owner: <% relationshipOwner %>
primary_contact: <% primaryContact %>
relationship_start: <% today %>
health: 🟢
status: active
last_engagement: <% today %>
total_revenue: $0
created: <% tp.date.now("YYYY-MM-DD HH:mm") %>
last_updated: <% tp.date.now("YYYY-MM-DD HH:mm") %>
---

# 🏢 <% clientName %>

> [!info] Client Snapshot
> **Industry:** <% industry.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') %>  
> **Relationship Owner:** <% relationshipOwner %>  
> **Primary Contact:** [[<% primaryContact %>]]  
> **Health:** 🟢 Healthy

**See also:** [[../../todo]], [[../../roadmap]], [[../../network]]

---

## 🎯 Relationship Summary

### Who They Are

**Company Overview:**


**What they do:**


**Size:** __ employees | **Location(s):** 

### Our History

**How we connected:**


**First engagement:** <% today %>

**Key milestones:**
- <% today %> — Relationship initiated

---

## 👥 Key Contacts

> [!people] Primary Stakeholders

| Name | Role | Email | Phone | Notes |
|:-----|:-----|:------|:------|:------|
| <% primaryContact %> | Primary Contact |  |  | Decision maker |
|  |  |  |  |  |
|  |  |  |  |  |

### Relationship Map

```
                    ┌─────────────────┐
                    │   Executive     │
                    │   Sponsor       │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
        ┌─────┴─────┐  ┌─────┴─────┐  ┌─────┴─────┐
        │ Technical │  │  Business │  │   Ops/    │
        │   Lead    │  │   Owner   │  │   Admin   │
        └───────────┘  └───────────┘  └───────────┘
```

### Communication Preferences

- **Preferred channel:** Email / Teams / Slack / Phone
- **Meeting frequency:** Weekly / Bi-weekly / Monthly / As needed
- **Communication style:** Formal / Casual / Technical / Executive
- **Best times:** 
- **Avoid:** 

---

## 📊 Engagement Health

```meta-bind
INPUT[inlineSelect(option(🟢 Healthy), option(🟡 Attention Needed), option(🔴 At Risk)):health]
```

### Health Indicators

| Indicator | Status | Notes |
|:----------|:------:|:------|
| Response Time | 🟢/🟡/🔴 |  |
| Engagement Level | 🟢/🟡/🔴 |  |
| Satisfaction | 🟢/🟡/🔴 |  |
| Payment/AR | 🟢/🟡/🔴 |  |
| Growth Potential | 🟢/🟡/🔴 |  |

### Recent Sentiment

**Last interaction:** 
**Their mood/feedback:** 
**Any concerns raised?** 

---

## 💼 Active Projects

| Project | Status | Lead | Started | Health |
|:--------|:-------|:-----|:--------|:------:|
|  | 🔄 Active | | | 🟢 |

### Project Links

- [[project-name/project-brief|Project Name]]

---

## 📜 Engagement History

### Completed Projects

| Project | Dates | Revenue | Outcome |
|:--------|:------|--------:|:--------|
|  |  | $ |  |

### All Interactions Timeline

```
<% today %> ─── 🤝 Relationship initiated
     │
     ▼
```

---

## 💰 Financial Overview

### Revenue Summary

| Year | Revenue | Projects | Avg Project |
|:-----|--------:|---------:|------------:|
| <% moment().format("YYYY") %> | $0 | 0 | $0 |

### Current Contracts

| Contract/SOW | Value | Start | End | Status |
|:-------------|------:|:------|:----|:------:|
|  | $ |  |  | ⬜ |

### Outstanding AR

| Invoice | Amount | Due | Status |
|:--------|-------:|:----|:------:|
|  | $ |  | ⬜ |

---

## 🎯 Growth Opportunities

### Identified Opportunities

| Opportunity | Potential Value | Timeline | Probability | Next Step |
|:------------|----------------:|:---------|:-----------:|:----------|
|  | $ |  | % |  |
|  | $ |  | % |  |

### Expansion Areas

**Services they don't use yet:**
- [ ] 

**Adjacent needs we could address:**
- [ ] 

**Referral potential:**
- [ ] Internal champions who could refer us
- [ ] Other companies they could introduce us to

---

## 🧠 Client Intelligence

### What We Know

**Their strategic priorities:**
1. 
2. 
3. 

**Pain points we solve:**
- 

**Their competition:**
- 

**Recent news/changes:**
- 

### What We Don't Know (Yet)

- [ ] Budget cycle and timing
- [ ] Decision-making process
- [ ] Other vendors they work with
- [ ] Long-term strategic plans

---

## 📝 Notes & Context

### Key Insights

> Things to remember when engaging with this client


### Sensitive Topics

> What to avoid or handle carefully


### Success Patterns

> What works well with this client


---

## ✅ Action Items

### Open Actions

- [ ] 

### Waiting On Client

- [ ] 

---

## 📎 Resources

### Internal Documents

- 

### Client-Provided Materials

- 

### Relevant Links

- 

---

**Created:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Last Updated:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Next Review:** <% moment().add(1, 'month').format("YYYY-MM-DD") %>

```button
name 📋 Add to Network
type command
action Templater: Insert templates/snippets/add-to-network.md
```

```button
name 📊 Update Health Check
type command
action Templater: Insert templates/snippets/health-check.md
```

[//begin]: # "Autogenerated link references for markdown compatibility"
[../../todo]: ../../todo.md "Todo"
[../../roadmap]: ../../roadmap.md "Roadmap"
[../../network]: ../../network.md "Network"
[//end]: # "Autogenerated link references"
