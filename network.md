---
tags:
  - "#network"
  - "#contacts"
  - "#relationships"
  - "#professional-network"
status: active
created_date: 2025-11-12
last_updated: 2026-02-23
permalink: network
color: "#22c55e"
icon: FasPeopleGroup
---

# Network

**See also:** [[todo]], [[roadmap]], [[outreach]]

> [!info] Individual contact profiles live in `network/`. This page is a Dataview-powered index.
> To add a contact, create a new file in `network/` using `tpl-person-light` or `tpl-person`.

---

## Active Contacts

```dataview
TABLE role, company, last_contact, relationship_type
FROM "network"
WHERE status = "active"
SORT last_contact DESC
```

## By Company

```dataview
TABLE WITHOUT ID company AS "Company", length(rows) AS "Contacts", rows.file.link AS "People"
FROM "network"
WHERE status = "active"
GROUP BY company
SORT length(rows) DESC
```

## Prospects

```dataview
TABLE role, company, last_contact, last_context
FROM "network"
WHERE relationship_type = "prospect"
SORT last_contact DESC
```

## Stale Contacts (90+ days)

```dataview
TABLE role, company, last_contact
FROM "network"
WHERE status = "active" AND date(today) - date(last_contact) > dur(90 days)
SORT last_contact ASC
```

## Recently Added

```dataview
TABLE role, company, created_date
FROM "network"
SORT created_date DESC
LIMIT 10
```

---

**Created:** 2025-11-12
**Last Updated:** 2026-02-23
**Next Review:** Weekly

[todo]: todo.md "Todo"
[roadmap]: roadmap.md "Roadmap"
[outreach]: outreach.md "Outreach"
