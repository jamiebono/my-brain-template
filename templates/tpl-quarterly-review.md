<%*
// ═══════════════════════════════════════════════════════════════════════════
// 📅 QUARTERLY REVIEW TEMPLATE
// ═══════════════════════════════════════════════════════════════════════════
// Strategic quarterly planning and reflection
// The big picture view of your consulting practice
// ═══════════════════════════════════════════════════════════════════════════

const year = await tp.system.prompt("Year:", moment().format("YYYY"));
const quarter = await tp.system.suggester(
    ["Q1 (Jan-Mar)", "Q2 (Apr-Jun)", "Q3 (Jul-Sep)", "Q4 (Oct-Dec)"],
    ["Q1", "Q2", "Q3", "Q4"]
);

const quarterMonths = {
    "Q1": ["January", "February", "March"],
    "Q2": ["April", "May", "June"],
    "Q3": ["July", "August", "September"],
    "Q4": ["October", "November", "December"]
}[quarter];

const quarterStart = {
    "Q1": `${year}-01-01`,
    "Q2": `${year}-04-01`,
    "Q3": `${year}-07-01`,
    "Q4": `${year}-10-01`
}[quarter];

const quarterEnd = {
    "Q1": `${year}-03-31`,
    "Q2": `${year}-06-30`,
    "Q3": `${year}-09-30`,
    "Q4": `${year}-12-31`
}[quarter];

const prevQuarter = quarter === "Q1" ? "Q4" : `Q${parseInt(quarter[1]) - 1}`;
const prevYear = quarter === "Q1" ? parseInt(year) - 1 : year;
const nextQuarter = quarter === "Q4" ? "Q1" : `Q${parseInt(quarter[1]) + 1}`;
const nextYear = quarter === "Q4" ? parseInt(year) + 1 : year;

await tp.file.rename(`${year}-${quarter}-review`);
-%>
---
tags:
  - "#quarterly-review"
  - "#strategy"
  - "#planning"
  - "#<% year %>"
  - "#<% quarter.toLowerCase() %>"
type: quarterly-review
year: <% year %>
quarter: <% quarter %>
period: <% quarterStart %> to <% quarterEnd %>
months: [<% quarterMonths.join(", ") %>]
status: in-progress
created: <% tp.date.now("YYYY-MM-DD HH:mm") %>
reviewed: 
---

# 📅 <% quarter %> <% year %> — Quarterly Review

## <% quarterMonths[0] %> - <% quarterMonths[2] %> <% year %>

> [!nav] Navigation
> ◀ [[<% prevYear %>-<% prevQuarter %>-review|<% prevQuarter %> <% prevYear %>]] | [[roadmap|Roadmap]] | [[<% nextYear %>-<% nextQuarter %>-review|<% nextQuarter %> <% nextYear %>]] ▶

**See also:** [[todo]], [[roadmap]], [[network]]

---

## 🎯 Quarter at a Glance

### The Big Numbers

| Metric | Target | Actual | % | Trend |
|:-------|-------:|-------:|--:|:-----:|
| Revenue | $ | $ | % | ↑/↓/→ |
| Billable Hours |  |  | % |  |
| New Clients |  |  | % |  |
| Projects Completed |  |  | % |  |
| Utilization Rate | % | % | % |  |

### Quarter Rating

```meta-bind
INPUT[slider(minValue(1), maxValue(10)):quarterRating]
```

**One-sentence summary of this quarter:**


---

## 🏆 Wins & Accomplishments

### Top 3 Wins

> [!success] The highlights that defined this quarter

#### 🥇 Win #1: 

**What happened:**

**Impact:**

**What made it possible:**


#### 🥈 Win #2: 

**What happened:**

**Impact:**

**What made it possible:**


#### 🥉 Win #3: 

**What happened:**

**Impact:**

**What made it possible:**


### All Accomplishments

#### <% quarterMonths[0] %>

- 

#### <% quarterMonths[1] %>

- 

#### <% quarterMonths[2] %>

- 

---

## 📊 Goals Review

### <% quarter %> Goals — How Did We Do?

| Goal | Target | Actual | Status | Reflection |
|:-----|:-------|:-------|:------:|:-----------|
|  |  |  | ✅/⚠️/❌ |  |
|  |  |  |  |  |
|  |  |  |  |  |

### Goal Analysis

**Goals Achieved:** _ / _

**Why goals were met:**


**Why goals were missed:**


---

## 💰 Financial Review

### Revenue by Client

| Client | Revenue | Hours | Avg Rate | % of Total |
|:-------|--------:|------:|---------:|-----------:|
|  | $ |  | $ | % |
|  | $ |  | $ | % |
|  | $ |  | $ | % |
| **Total** | **$** | **** | **$** | **100%** |

### Revenue by Month

```
<% quarterMonths[0] %>:  [██████████] $___
<% quarterMonths[1] %>:  [████████░░] $___
<% quarterMonths[2] %>:  [███████░░░] $___
```

### Pipeline Review

| Opportunity | Value | Stage | Close Date | Probability |
|:------------|------:|:------|:-----------|:-----------:|
|  | $ |  |  | % |
|  | $ |  |  | % |
| **Pipeline Total** | **$** |  |  |  |

---

## 👥 Relationship Capital

### Client Health Summary

| Client | Revenue | Health | Trend | Action Needed |
|:-------|--------:|:------:|:-----:|:--------------|
|  | $ | 🟢/🟡/🔴 | ↑/↓/→ |  |
|  |  |  |  |  |

### Network Growth

**New Meaningful Connections:** 

**Relationships Deepened:**


**Relationships Cooled:**


### Referrals

| From | To | Status | Notes |
|:-----|:---|:-------|:------|
|  |  |  |  |

---

## 🧠 Learning & Growth

### Skills Developed

| Skill | Before | After | How I Learned |
|:------|:------:|:-----:|:--------------|
|  | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |  |
|  |  |  |  |

### Content Created

- 

### Conferences/Events

- 

### Certifications/Training

- 

---

## 🔍 Honest Reflection

### What Worked Well

> [!success] Keep doing these things

1. 
2. 
3. 

### What Didn't Work

> [!warning] Stop or change these things

1. 
2. 
3. 

### Surprises

> [!tip] Things I didn't expect

**Pleasant:**

**Unpleasant:**


### The Unsaid

**What am I avoiding?**


**What am I afraid of?**


**What would I do if I wasn't afraid?**


---

## 📈 Trends & Patterns

### Energy Patterns

**Highest energy activities:**


**Lowest energy activities:**


**Energy trend over quarter:**


### Time Patterns

**Where time actually went vs. where I wanted it to go:**


**Biggest time sinks:**


**Time investments that paid off:**


### Revenue Patterns

**What drove revenue this quarter:**


**Revenue vulnerabilities:**


---

## 🎯 Next Quarter Planning

### <% nextQuarter %> <% nextYear %> Theme

> One phrase that captures the focus


### Top 3 Priorities

#### Priority #1: 

**Objective:** 

**Key Results:**
- [ ] KR1: 
- [ ] KR2: 
- [ ] KR3: 

**Why it matters:**


#### Priority #2: 

**Objective:** 

**Key Results:**
- [ ] KR1: 
- [ ] KR2: 
- [ ] KR3: 

**Why it matters:**


#### Priority #3: 

**Objective:** 

**Key Results:**
- [ ] KR1: 
- [ ] KR2: 
- [ ] KR3: 

**Why it matters:**


### <% nextQuarter %> Goals

| Goal | Target | Metric | Review Date |
|:-----|:-------|:-------|:------------|
|  |  |  | Monthly |
|  |  |  |  |
|  |  |  |  |

### Key Dates Next Quarter

| Date | Event | Prep Needed |
|:-----|:------|:------------|
|  |  |  |

---

## 🧹 Housekeeping

### Q-End Cleanup

- [ ] Close out completed projects
- [ ] Archive old documents
- [ ] Update roadmap.md
- [ ] Review and prune network.md
- [ ] Update client overviews
- [ ] Submit all time entries
- [ ] Review contracts expiring

### System Improvements

**What systems need attention:**


**Tools to adopt/drop:**


---

## 📝 Quarter in Review

### Month-by-Month Summary

#### <% quarterMonths[0] %>

**Theme:**

**Key events:**

**Mood/energy:**


#### <% quarterMonths[1] %>

**Theme:**

**Key events:**

**Mood/energy:**


#### <% quarterMonths[2] %>

**Theme:**

**Key events:**

**Mood/energy:**


---

## 🌟 Evolution Tracking

### Who I Was at Start of Quarter


### Who I Am Now


### Key Insight


### One Thing I'd Tell Past Me


---

## ❓ Questions for Next Quarterly Review

1. 
2. 
3. 

---

**Created:** <% tp.date.now("YYYY-MM-DD HH:mm") %>
**Review Completed:** 
**Next Review:** <% moment(quarterEnd).add(1, 'week').format("YYYY-MM-DD") %>

[//begin]: # "Autogenerated link references for markdown compatibility"
[todo]: ../todo.md "Todo"
[roadmap]: ../roadmap.md "Roadmap"
[network]: ../network.md "Network"
[//end]: # "Autogenerated link references"
