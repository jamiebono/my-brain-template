<%*
// Quick action item capture
const action = await tp.system.prompt("Action item:", "");
const owner = await tp.system.prompt("Owner:", "Your Name");
const dueDate = await tp.system.prompt("Due date (YYYY-MM-DD):", tp.date.now("YYYY-MM-DD", 7));
const priority = await tp.system.suggester(["🔴 High", "🟡 Medium", "🟢 Low"], ["🔴", "🟡", "🟢"]);
-%>
- [ ] <% priority %> **<% action %>** — @<% owner %> (due: <% dueDate %>)
