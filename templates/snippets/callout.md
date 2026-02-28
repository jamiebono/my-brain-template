<%*
// Callout templates for different purposes
const calloutType = await tp.system.suggester(
    ["💡 Tip/Insight", "⚠️ Warning", "📌 Important", "❓ Question", "✅ Success", "📝 Note", "🔥 Critical", "💭 Thinking"],
    ["tip", "warning", "important", "question", "success", "note", "danger", "abstract"]
);
const title = await tp.system.prompt("Callout title:", "");
-%>

> [!<% calloutType %>] <% title %>
> 

