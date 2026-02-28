<%*
// Quick meeting capture
const topic = await tp.system.prompt("What was discussed?", "");
const decision = await tp.system.prompt("Any decisions made?", "");
const nextStep = await tp.system.prompt("Next step?", "");
const owner = await tp.system.prompt("Owner?", "");
-%>

---

### Quick Capture — <% tp.date.now("YYYY-MM-DD HH:mm") %>

**Topic:** <% topic %>

**Decision:** <% decision || "None" %>

**Next Step:** <% nextStep %>

**Owner:** <% owner %>

---
