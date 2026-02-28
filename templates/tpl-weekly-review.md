<%*
// Simple weekly review
let weekNum = tp.date.now("WW");
let yearNum = tp.date.now("YYYY");
let weekStart = tp.date.weekday("YYYY-MM-DD", 0); 
let weekEnd = tp.date.weekday("YYYY-MM-DD", 6);
let prevWeekNum = String(Number(weekNum) - 1).padStart(2, '0');
let nextWeekNum = String(Number(weekNum) + 1).padStart(2, '0');
let newFileName = yearNum + "-W" + weekNum;

// Move to logs/weekly/ and rename
await tp.file.move("logs/weekly/" + newFileName);
-%>
---
tags:
  - weekly-review
  - reflection
  - planning
  - <% yearNum %>
week: <% yearNum %>-W<% weekNum %>
type: weekly-review
overall_rating: 
created: <% tp.date.now("YYYY-MM-DD HH:mm") %>
reviewed: 
---

# 📊 Weekly Review — Week <% weekNum %>

> [!nav] Navigation  
> ◀ [[logs/weekly/<% yearNum %>-W<% prevWeekNum %>|Week <% prevWeekNum %>]] | [[roadmap|Roadmap]] | [[logs/weekly/<% yearNum %>-W<% nextWeekNum %>|Week <% nextWeekNum %>]] ▶

**See also:** [[todo]], [[roadmap]], [[network]], [[outreach]]

---

## 📅 Week at a Glance

| Day | Brief | Highlight |
|:----|:------|:----------|
| Mon | [[logs/daily/<% tp.date.weekday("YYYY-MM-DD", 0) %>-daily-brief\|📝]] |  |
| Tue | [[logs/daily/<% tp.date.weekday("YYYY-MM-DD", 1) %>-daily-brief\|📝]] |  |
| Wed | [[logs/daily/<% tp.date.weekday("YYYY-MM-DD", 2) %>-daily-brief\|📝]] |  |
| Thu | [[logs/daily/<% tp.date.weekday("YYYY-MM-DD", 3) %>-daily-brief\|📝]] |  |
| Fri | [[logs/daily/<% tp.date.weekday("YYYY-MM-DD", 4) %>-daily-brief\|📝]] |  |

---

## 🏆 Phase 1: Wins & Accomplishments

> [!success] What went well this week?

### Major Wins 🎉

1. **Win:** 
   - *Impact:* 
   - *What made it possible:* 

2. **Win:** 
   - *Impact:* 
   - *What made it possible:* 

3. **Win:** 
   - *Impact:* 
   - *What made it possible:* 

### Promises Kept ✓
- [ ] 
- [ ] 
- [ ] 

---

## 🔍 Phase 2: Honest Assessment

> [!warning] What didn't go as planned?

### What Slipped

| Item | Why It Slipped | Lesson |
|:-----|:---------------|:-------|
|  |  |  |
|  |  |  |

### Patterns I Notice

**Positive patterns:** 

**Concerning patterns:** 

**What am I avoiding?** 

---

## 💭 Phase 3: Emotional Reality Check

> [!abstract] Beyond the tasks — how are you really doing?

**What gave me energy this week?**

**What drained my energy?**

**What am I afraid of doing?** 

**What brought genuine joy?** 

---

## 📈 Phase 4: Metrics & Numbers

### Time Investment

| Category | Hours | Target |
|:---------|------:|-------:|
| Client Work |  |  |
| Business Dev |  |  |
| Admin |  |  |
| Learning |  |  |

> [!warning] Time Entry Check
> - [ ] All hours logged for this week

---

## 🎯 Phase 5: Next Week Planning

### The ONE Thing for Next Week

**ONE Thing:** 

**Why it matters:** 

**First action Monday morning:** 

### Key Priorities

**🔴 MUST (Non-negotiable)**
- [ ] 
- [ ] 

**🟡 SHOULD (Important)**
- [ ] 
- [ ] 

**🟢 COULD (If time permits)**
- [ ] 

### Key Meetings & Deadlines

| Date | Event | Prep Needed |
|:-----|:------|:------------|
|  |  |  |
|  |  |  |

---

## 🔮 Phase 6: Strategic Lens

**What should I START doing?** 

**What should I STOP doing?** 

**What should I CONTINUE doing?** 

---

## 🧹 Phase 7: Housekeeping

- [ ] Archive completed items from todo.md
- [ ] Update roadmap
- [ ] Calendar reviewed for next 2 weeks
- [ ] Network.md updated with new contacts

---

## 🌟 Evolution Tracking

**Started thinking:** 

**Ended with:** 

**Key unlock:** 

**Pattern to remember:** 

---

## 📝 Week Rating

**Overall Week:** ⭐⭐⭐⭐⭐ (1-10)

---

**Created:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Review Completed:** 
**Next Review:** <% tp.date.now("YYYY-MM-DD", 7) %>
