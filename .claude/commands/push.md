# Git Push with Auto-generated Commit Message

Commit and push all changes with an auto-generated commit message.

## Process

1. **Check current state:**
   - Run `git status` to see all untracked and modified files
   - Run `git diff --staged` to see staged changes
   - Run `git diff` to see unstaged changes

2. **Analyze changes** and create a concise, descriptive commit message that reflects the actual work being done.

3. **Execute:**
   - `git add -A` to stage all changes
   - `git commit -m "YOUR_GENERATED_MESSAGE"` with the generated message
   - `git push` to push to remote

## Commit Message Guidelines

The commit message should:
- Summarize the main changes clearly
- Be under 72 characters for the first line
- Be specific about what changed
- Use appropriate tone and formatting for the project (technical vs. business language)

## Good Commit Message Examples

```
Add daily review command for Claude Code
Update network/ person files with new contacts from calendar
Fix broken link in roadmap.md
Reorganize project files into proper folders
Complete weekly review and update priorities
```

## What NOT to do

- Don't commit files with secrets (.env, credentials.json, etc.)
- Don't write vague messages like "updates" or "changes"
- Don't include file paths in the message unless specifically relevant
