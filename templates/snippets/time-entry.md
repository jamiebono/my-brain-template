<%*
// Time entry quick log
const client = await tp.system.prompt("Client:", "");
const project = await tp.system.prompt("Project:", "");
const hours = await tp.system.prompt("Hours:", "");
const description = await tp.system.prompt("What did you work on?", "");
const billable = await tp.system.suggester(["💰 Billable", "📋 Non-billable"], ["billable", "non-billable"]);
-%>

| <% tp.date.now("YYYY-MM-DD") %> | <% client %> | <% project %> | <% hours %>h | <% billable === "billable" ? "💰" : "📋" %> | <% description %> |
