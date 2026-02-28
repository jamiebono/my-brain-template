<%*
// Daily standup update format
const yesterday = await tp.system.prompt("What did you do yesterday?", "");
const today = await tp.system.prompt("What are you doing today?", "");
const blockers = await tp.system.prompt("Any blockers? (leave blank if none)", "");
-%>

### Standup — <% tp.date.now("YYYY-MM-DD") %>

**Yesterday:** <% yesterday %>

**Today:** <% today %>

<% if (blockers) { %>**Blockers:** ⚠️ <% blockers %><% } else { %>**Blockers:** None 🟢<% } %>

---
