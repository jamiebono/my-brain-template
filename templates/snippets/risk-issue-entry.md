<%*
// Risk/issue log entry
const type = await tp.system.suggester(["⚠️ Risk", "🔴 Issue", "🚧 Blocker"], ["risk", "issue", "blocker"]);
const description = await tp.system.prompt("Describe the risk/issue:", "");
const likelihood = await tp.system.suggester(["High", "Medium", "Low"], ["H", "M", "L"]);
const impact = await tp.system.suggester(["High", "Medium", "Low"], ["H", "M", "L"]);
const owner = await tp.system.prompt("Owner:", "");
const mitigation = await tp.system.prompt("Mitigation/Resolution:", "");
-%>

| <% tp.date.now("YYYY-MM-DD") %> | <% type === "risk" ? "⚠️" : type === "issue" ? "🔴" : "🚧" %> | <% description %> | <% likelihood %> | <% impact %> | <% owner %> | <% mitigation %> | ⬜ Open |
