<%*
// ═══════════════════════════════════════════════════════════════════════════
// 👥 1:1 MEETING TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Structured 1:1 meeting framework for meaningful conversations
// Designed for both manager and individual contributor perspectives
// ═══════════════════════════════════════════════════════════════════════════

const personName = await tp.system.prompt("Who are you meeting with?", "");
const relationship = await tp.system.suggester(
    ["Direct Report", "Manager", "Peer", "Mentor", "Client Contact", "Stakeholder"],
    ["direct-report", "manager", "peer", "mentor", "client", "stakeholder"]
);
const recurring = await tp.system.suggester(
    ["Yes - Weekly", "Yes - Bi-weekly", "Yes - Monthly", "No - Ad-hoc"],
    ["weekly", "biweekly", "monthly", "adhoc"]
);

const meetingDate = tp.date.now("YYYY-MM-DD");
const safeName = personName.replace(/\s+/g, '-').toLowerCase();
const firstName = personName.split(' ')[0];

await tp.file.rename(`${meetingDate}-1on1-${safeName}`);

// Calculate next meeting date
const nextMeeting = {
    "weekly": moment().add(1, 'week').format("YYYY-MM-DD"),
    "biweekly": moment().add(2, 'weeks').format("YYYY-MM-DD"),
    "monthly": moment().add(1, 'month').format("YYYY-MM-DD"),
    "adhoc": "TBD"
}[recurring];
-%>
---
tags:
  - "#1on1"
  - "#meeting"
  - "#<% relationship %>"
type: one-on-one
with: <% personName %>
relationship: <% relationship %>
cadence: <% recurring %>
meeting_date: <% meetingDate %>
next_meeting: <% nextMeeting %>
mood: 
energy: 
created: <% tp.date.now("YYYY-MM-DD HH:mm") %>
---

# 👥 1:1 with <% personName %>

> [!info] Meeting Context
> **Date:** <% moment(meetingDate).format("dddd, MMMM D, YYYY") %>  
> **Relationship:** <% relationship.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') %>  
> **Cadence:** <% recurring.charAt(0).toUpperCase() + recurring.slice(1) %>  
> **Next Meeting:** <% nextMeeting %>

**See also:** [[<% personName %>]], [[network]], [[todo]]

---

## 🎯 Meeting Purpose

> [!tip] Why are we meeting?

**Primary objective for this 1:1:**


---

## ✅ Check-In

### How are they doing?

```meta-bind
INPUT[inlineSelect(option(😊 Great), option(🙂 Good), option(😐 Okay), option(😟 Struggling), option(😰 Overwhelmed)):mood]
```

**Their energy/mood:** `VIEW[{mood}]`

**Personal check-in (life outside work):**


**Professional check-in (how's work going?):**


---

## 📋 Agenda

### Their Topics (Priority)

> [!important] What does <% firstName %> want to discuss?

- [ ] 
- [ ] 
- [ ] 

### My Topics

- [ ] 
- [ ] 

---

## 🔙 Review from Last Time

### Action Items Status

| Action | Owner | Status | Notes |
|:-------|:------|:------:|:------|
|  | <% firstName %> | ⬜/✅/🔄 |  |
|  | Me | ⬜/✅/🔄 |  |

### How did things go?

**What worked since last time:**


**What was challenging:**


---

## 💬 Discussion Notes

### Topic 1: 

**What they said:**


**What I heard/observed:**


**Agreed next steps:**


---

### Topic 2: 

**What they said:**


**What I heard/observed:**


**Agreed next steps:**


---

### Topic 3: 

**What they said:**


**What I heard/observed:**


**Agreed next steps:**


---

## 🌱 Growth & Development

### Current Focus Areas

| Area | Progress | Support Needed |
|:-----|:--------:|:---------------|
|  | ⭐⭐⭐⭐⭐ |  |

### Career Conversation

**Where do they want to go?**


**How can I help?**


**Skills to develop:**


---

## 🛡️ Support Needed

### Blockers I Can Help Remove

| Blocker | Action I'll Take | By When |
|:--------|:-----------------|:--------|
|  |  |  |

### Resources/Connections to Provide

- [ ] 

---

## 💭 Feedback Exchange

### Feedback for <% firstName %>

> [!success] What's going well

> [!warning] Opportunity for growth

### Feedback from <% firstName %>

> [!abstract] What they shared with me


---

## 📊 Relationship Health

### Trust Level

```
[████████░░] 80%
```

### Communication Quality

- [ ] Clear and open
- [ ] Could be better
- [ ] Needs work

### What would strengthen this relationship?


---

## ✅ Action Items

### <% firstName %>'s Commitments

- [ ] 

### My Commitments

- [ ] 

### Shared/Follow-up

- [ ] 

---

## 🔮 Looking Ahead

### Next 1:1 Topics to Revisit

- 

### Upcoming Important Dates

| Date | Event | Relevance |
|:-----|:------|:----------|
|  |  |  |

---

## 📝 Private Reflection

> [!abstract]- My thoughts (not shared)
> 
> **What am I sensing but not being said?**
> 
> 
> **What should I do differently next time?**
> 
> 
> **Am I being the manager/colleague they need?**
> 

---

## 📈 1:1 Effectiveness

**Did we cover what mattered?** ⬜ Yes | ⬜ Partially | ⬜ No

**Did they feel heard?** ⬜ Yes | ⬜ Unsure | ⬜ No

**Rating for this 1:1:** ⭐⭐⭐⭐⭐

**What would improve next time?**


---

**Created:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Next Meeting:** <% nextMeeting %>

```button
name 📅 Schedule Next 1:1
type command
action Templater: Insert templates/snippets/schedule-followup.md
```

[//begin]: # "Autogenerated link references for markdown compatibility"
[network]: ../../network.md "Network"
[todo]: ../../todo.md "Todo"
[//end]: # "Autogenerated link references"
