# Templates

Instructions for working with Obsidian templates in this directory.

## Templater Syntax

This vault uses the **Templater** plugin. Preserve these syntax patterns:

| Syntax | Purpose | Example |
|--------|---------|---------|
| `<% %>` | Execution block | `<% tp.date.now() %>` |
| `<%= %>` | Output block | `<%= tp.file.title %>` |
| `<%* %>` | JavaScript block | `<%* let name = await tp.system.prompt("Name?") %>` |
| `<% tp.file.cursor() %>` | Cursor placement | Places cursor after template insertion |

## Common Templater Functions

```javascript
tp.date.now("YYYY-MM-DD")           // Current date
tp.date.now("HH:mm")                // Current time
tp.file.title                        // Current file name
tp.file.folder()                     // Current folder path
tp.system.prompt("Question")         // User input prompt
tp.file.cursor()                     // Cursor position after insert
```

## Template Categories

### Core Templates (tpl-*)
- `tpl-daily-brief.md` - Daily strategic planning
- `tpl-weekly-review.md` - 7-phase weekly reflection
- `tpl-quarterly-review.md` - Strategic quarterly planning
- `tpl-meeting.md` - General meeting capture
- `tpl-discovery-session.md` - Client discovery calls
- `tpl-1on1.md` - 1:1 meetings
- `tpl-client-overview.md` - New client setup
- `tpl-project-brief.md` - New project setup
- `tpl-person.md` - Important contact profiles

### Snippets (snippets/*)
Small, reusable template fragments for inline insertion:
- `update-timestamp` - Quick timestamp footer
- `quick-action` - Insert action item
- `quick-meeting-capture` - Rapid meeting notes
- `standup` - Daily standup format
- `time-entry` - Billable time tracking
- `decision-log-entry` - Document decisions
- `risk-issue-entry` - Track risks/issues

## When Editing Templates

1. **Test after changes** - Insert the template in a scratch file to verify
2. **Preserve cursor placement** - Keep `<% tp.file.cursor() %>` where user should start typing
3. **Update README.md** - If adding/removing templates, update `templates/README.md`
4. **Don't break frontmatter** - Ensure YAML frontmatter remains valid after template variables resolve

## Adding New Templates

1. Use prefix `tpl-` for full templates, no prefix for snippets
2. Add to appropriate location: root for templates, `snippets/` for fragments
3. Document in `templates/README.md` with use case
4. Consider Calendar plugin integration for date-triggered templates

## Template Variables Reference

Templates may reference these vault locations:
- `[[todo]]` - Task tracking
- `[[roadmap]]` - Strategic milestones
- `[[network]]` - Professional contacts
- `[[outreach]]` - Message drafts

Keep these links as wiki-style `[[links]]` for Obsidian compatibility.
