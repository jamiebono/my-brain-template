# your organization Quarto Templates

Professional document generation with consistent Your Organization branding.

## Quick Start

```bash
# Install Quarto CLI (if not already installed)
# Windows: winget install Posit.Quarto
# Mac: brew install quarto
# Linux: See https://quarto.org/docs/get-started/

# Render a document
cd templates/quarto-brand
quarto render examples/example-briefing.qmd

# Render to specific format
quarto render examples/example-briefing.qmd --to pdf
quarto render examples/example-briefing.qmd --to html
quarto render examples/example-briefing.qmd --to docx

# Render all formats
quarto render examples/example-briefing.qmd
```

## Project Structure

```
quarto-brand/
├── _quarto.yml              # Project config (colors, fonts, defaults)
├── themes/
│   └── brand-theme.scss       # your brand styling (blues, typography)
├── templates/
│   └── meeting-briefing.qmd # Reusable meeting briefing template
├── examples/
│   └── example-briefing.qmd  # Working example
└── _output/                 # Rendered documents go here
```

## your organization Brand Colors

| Color | Hex | Usage |
|:------|:----|:------|
| your organization Blue (Dark) | `#1a5276` | Headers, primary accent |
| your organization Blue (Medium) | `#2874a6` | Subheaders, links |
| your organization Blue (Light) | `#3498db` | Info callouts |
| Highlight Green | `#d5f5e3` | Success, positive callouts |
| Warning Red | `#fadbd8` | Warnings, important notes |

## Available Callout Styles

```markdown
::: {.callout-info}
## Info Box
Blue accent for general information
:::

::: {.callout-highlight}
## Success/Highlight Box
Green accent for positive information, key takeaways
:::

::: {.callout-warning}
## Warning Box
Red accent for important reminders, cautions
:::
```

## Output Formats

### PDF
Professional print-ready documents with your organization colors and typography.

### HTML
Interactive web documents with table of contents, styled with your organization theme.

### DOCX
Microsoft Word documents (requires reference template for full branding).

### reveal.js (Presentations)
Slide decks with branded output. Use `format: revealjs` in frontmatter.

## Creating New Documents

### Meeting Briefing

1. Copy `templates/meeting-briefing.qmd`
2. Fill in the `{{PLACEHOLDER}}` values
3. Render: `quarto render your-briefing.qmd`

### Presentation

```yaml
---
title: "Your Presentation"
format: revealjs
---

# Slide 1

Content here

---

# Slide 2

More content
```

## Integration with Claude Code

### The `/briefing` Command

Generate professional briefings on any topic directly from Claude Code:

```bash
# Meeting prep (auto-detects from calendar)
/briefing Jane Smith
/briefing "Client Meeting"

# Specific briefing types
/briefing --type person "Jane Doe"
/briefing --type company "Acme Corp"
/briefing --type topic "Microsoft Fabric"
/briefing --type project "MVP migration"

# Control output format
/briefing --format pdf "subject"      # PDF only
/briefing --format html "subject"     # HTML only
/briefing --format docx "subject"     # Word only
/briefing --format all "subject"      # All formats (default)

# Combine options
/briefing --type company --format pdf Acme Corp
```

### Briefing Types

| Type | What it generates | Research sources |
|------|-------------------|------------------|
| `meeting` | Meeting prep with attendee profiles | Calendar, network.md, web research |
| `person` | Individual profile + your organization relationship | network.md, LinkedIn, web |
| `company` | Organization overview | Projects/, web, news |
| `topic` | Technical/concept briefing | Web research, your organization experience |
| `project` | Project status summary | project-brief.md, project_TODO.md |

### How It Works

1. **Research** - Uses the Relationship Manager agent for contact research, pulls from vault files
2. **Generate** - Creates a `.qmd` file with branded output and callout styles
3. **Render** - Runs Quarto to produce PDF/HTML/DOCX output
4. **Update** - Adds new contacts to `network.md` if discovered

Output location: `templates/quarto-brand/_output/briefing-[DATE]-[slug].[format]`

## Tips

- Keep `.qmd` source files in version control
- Rendered outputs go to `_output/` (gitignored)
- Use relative paths for images/assets
- The logo is at `../../Assets/logo.png`

## Resources

- [Quarto Documentation](https://quarto.org/docs/guide/)
- [Quarto for VS Code](https://quarto.org/docs/tools/vscode.html)
- [SCSS Theming](https://quarto.org/docs/output-formats/html-themes.html)
