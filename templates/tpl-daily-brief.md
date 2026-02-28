<%*
// Simple daily brief - extract date from filename or use today
let targetDate = tp.file.title.match(/\d{4}-\d{2}-\d{2}/) ? tp.file.title.match(/\d{4}-\d{2}-\d{2}/)[0] : tp.date.now("YYYY-MM-DD");
let yesterday = tp.date.now("YYYY-MM-DD", -1, targetDate, "YYYY-MM-DD");
let tomorrow = tp.date.now("YYYY-MM-DD", 1, targetDate, "YYYY-MM-DD");
let weekNum = tp.date.now("WW", 0, targetDate, "YYYY-MM-DD");
let displayDate = tp.date.now("dddd, MMMM D, YYYY", 0, targetDate, "YYYY-MM-DD");
let yearNum = tp.date.now("YYYY", 0, targetDate, "YYYY-MM-DD");
let newFileName = targetDate + "-daily-brief";

// Move to logs/daily/ and rename
await tp.file.move("logs/daily/" + newFileName);
-%>
---
tags:
  - daily-brief
  - planning
  - <% yearNum %>
  - week-<% weekNum %>
date: <% targetDate %>
week: <% weekNum %>
type: daily-brief
energy: 
focus: 
created: <% tp.date.now("YYYY-MM-DD HH:mm") %>
---

# 📅 BRIEF — <% displayDate %>

> [!nav] Navigation
> ◀ [[logs/daily/<% yesterday %>-daily-brief|Yesterday]] | [[logs/weekly/<% yearNum %>-W<% weekNum %>|Week <% weekNum %>]] | [[logs/daily/<% tomorrow %>-daily-brief|Tomorrow]] ▶

**See also:** [[todo]], [[roadmap]], [[network]]

---

## 📊 Day at a Glance

**Energy Level:** 🔋 High / ⚡ Medium / 🪫 Low

**Focus Type:** 🎯 Deep Work / 📞 Meetings / 📝 Admin / �� Mixed

---

## 📅 Today's Calendar

| Time | Event | Prep Needed |
|:-----|:------|:------------|
|  |  |  |
|  |  |  |
|  |  |  |

---

## 🎯 The ONE Thing

> If I could only accomplish ONE thing today, what would make everything else easier?

**Today's ONE Thing:** 

**Why it matters:** 

**First action:** 

---

## 📋 Today's Priorities

### �� Must Do
- [ ] 

### 🟡 Should Do
- [ ] 
- [ ] 

### 🟢 Could Do
- [ ] 

---

## 🌊 State of Affairs

**What's Working:** 

**What's Stuck:** 

**What's Emerging:** 

---

## ⚡ Quick Capture

### 💡 Ideas
- 

### 📞 Follow-ups
- [ ] 

---

## 🌙 End of Day Review

> [!success]- Wins
> - 

> [!warning]- Lessons  
> - 

> [!todo]- Carry Forward
> - [ ] 

**Day Rating:** ⭐⭐⭐⭐⭐ (1-5)

---

## 🔮 Tomorrow Preview

**Top Priority:** 

**Prep needed:** 

---

**Created:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Last Updated:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
