<%*
// Decision log entry
const decision = await tp.system.prompt("Decision made:", "");
const rationale = await tp.system.prompt("Why?", "");
const madeBy = await tp.system.prompt("Decided by:", "");
const reversible = await tp.system.suggester(["Yes - easily reversed", "Somewhat - can be changed", "No - one-way door"], ["🟢 Reversible", "🟡 Changeable", "🔴 Irreversible"]);
-%>

| <% tp.date.now("YYYY-MM-DD") %> | <% decision %> | <% rationale %> | <% madeBy %> | <% reversible %> |
