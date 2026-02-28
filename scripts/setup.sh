#!/usr/bin/env bash
# setup.sh — My Brain vault personalization script
# Alternative to the /setup Claude Code command for users who prefer CLI.
#
# Usage:
#   bash scripts/setup.sh            # Interactive setup
#   bash scripts/setup.sh --dry-run  # Preview changes without applying

set -euo pipefail

# ── Configuration ──────────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SETUP_MARKER="$VAULT_ROOT/.claude/.setup-complete"
DRY_RUN=false

# Detect OS for sed compatibility
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_INPLACE=(sed -i '')
else
    SED_INPLACE=(sed -i)
fi

# ── Argument Parsing ──────────────────────────────────────────────────────────

for arg in "$@"; do
    case $arg in
        --dry-run) DRY_RUN=true ;;
        --help|-h)
            echo "Usage: bash scripts/setup.sh [--dry-run]"
            echo ""
            echo "Personalize your My Brain vault with your name, organization,"
            echo "brand colors, and MCP server configuration."
            echo ""
            echo "Options:"
            echo "  --dry-run  Preview changes without applying them"
            echo "  --help     Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: bash scripts/setup.sh [--dry-run]"
            exit 1
            ;;
    esac
done

# ── Pre-Flight ─────────────────────────────────────────────────────────────────

if [[ -f "$SETUP_MARKER" ]]; then
    echo ""
    echo "⚠  Setup has already been run ($(head -1 "$SETUP_MARKER"))."
    read -rp "Re-run and overwrite current values? [y/N] " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Cancelled. Use /personalize in Claude Code for targeted changes."
        exit 0
    fi
fi

# ── Helper Functions ───────────────────────────────────────────────────────────

validate_hex() {
    local color="$1"
    if [[ "$color" =~ ^#[0-9a-fA-F]{6}$ ]] || [[ "$color" =~ ^#[0-9a-fA-F]{3}$ ]]; then
        return 0
    fi
    return 1
}

replace_in_file() {
    local file="$1" old="$2" new="$3"
    if [[ ! -f "$file" ]]; then return; fi
    if grep -qF "$old" "$file" 2>/dev/null; then
        if $DRY_RUN; then
            echo "  [dry-run] $file: \"$old\" → \"$new\""
        else
            "${SED_INPLACE[@]}" "s|$(printf '%s' "$old" | sed 's/[&/\]/\\&/g')|$(printf '%s' "$new" | sed 's/[&/\]/\\&/g')|g" "$file"
        fi
        return 0
    fi
    return 1
}

count=0
count_replacement() { ((count++)); }

# ── Collect Information ────────────────────────────────────────────────────────

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║          🧠 My Brain — Vault Setup Wizard                ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Identity
echo "── Step 1: Identity ──────────────────────────────────────────"
read -rp "Your full name: " USER_NAME
while [[ -z "$USER_NAME" ]]; do
    read -rp "Name is required. Your full name: " USER_NAME
done

read -rp "Organization/company name: " ORG_NAME
while [[ -z "$ORG_NAME" ]]; do
    read -rp "Organization is required. Organization/company name: " ORG_NAME
done

# Step 2: Role
echo ""
echo "── Step 2: Role & Context ────────────────────────────────────"
read -rp "Your role/title (e.g., Senior Consultant): " USER_ROLE
read -rp "Industry/domain (e.g., Data & Analytics): " USER_DOMAIN

# Step 3: Brand Colors
echo ""
echo "── Step 3: Brand Colors (optional) ───────────────────────────"
echo "Current defaults:"
echo "  Primary (dark):     #1a5276  (headers, accents)"
echo "  Secondary (medium):  #2874a6  (subheaders, links)"
echo "  Accent (light):     #3498db  (info callouts)"
echo ""
read -rp "Custom primary color? (hex, or Enter to keep default): " COLOR_PRIMARY
read -rp "Custom secondary color? (hex, or Enter to keep default): " COLOR_SECONDARY
read -rp "Custom accent color? (hex, or Enter to keep default): " COLOR_ACCENT

# Validate colors
for var_name in COLOR_PRIMARY COLOR_SECONDARY COLOR_ACCENT; do
    color="${!var_name}"
    if [[ -n "$color" ]] && ! validate_hex "$color"; then
        echo "⚠  Invalid hex color: $color (expected format: #1a5276). Keeping default."
        declare "$var_name="
    fi
done

# Step 4: MCP Configuration
echo ""
echo "── Step 4: MCP Servers (optional) ────────────────────────────"
echo "Available MCP integrations:"
echo "  1. basic-memory  — Cross-session memory (indexes your vault)"
echo "  2. filesystem    — Enhanced file operations"
echo "  3. markitdown    — Document conversion (DOCX/PDF → markdown)"
echo ""
read -rp "Enable which? (1,2,3 / all / skip): " MCP_CHOICE

# ── Apply Changes ──────────────────────────────────────────────────────────────

echo ""
if $DRY_RUN; then
    echo "── Dry Run — Previewing Changes ──────────────────────────────"
else
    echo "── Applying Changes ──────────────────────────────────────────"
fi

# Name replacements
name_count=0
echo ""
echo "Replacing 'Your Name' → '$USER_NAME'..."
while IFS= read -r -d '' file; do
    if replace_in_file "$file" "Your Name" "$USER_NAME"; then
        ((name_count++))
    fi
done < <(find "$VAULT_ROOT" -name "*.md" -o -name "*.py" -o -name "*.yml" -o -name "*.yaml" -o -name "*.qmd" -o -name "*.scss" | tr '\n' '\0')

# Organization replacements (both casings)
org_count=0
echo "Replacing 'Your Organization' → '$ORG_NAME'..."
while IFS= read -r -d '' file; do
    if replace_in_file "$file" "Your Organization" "$ORG_NAME"; then
        ((org_count++))
    fi
done < <(find "$VAULT_ROOT" -name "*.md" -o -name "*.py" -o -name "*.yml" -o -name "*.yaml" -o -name "*.qmd" -o -name "*.scss" | tr '\n' '\0')

org_lower=$(echo "$ORG_NAME" | tr '[:upper:]' '[:lower:]')
echo "Replacing 'your organization' → '$org_lower'..."
while IFS= read -r -d '' file; do
    if replace_in_file "$file" "your organization" "$org_lower"; then
        ((org_count++))
    fi
done < <(find "$VAULT_ROOT" -name "*.md" -o -name "*.py" -o -name "*.yml" -o -name "*.yaml" -o -name "*.qmd" -o -name "*.scss" | tr '\n' '\0')

# Brand color replacements
color_count=0
SCSS_FILE="$VAULT_ROOT/templates/quarto-brand/themes/brand-theme.scss"
if [[ -n "$COLOR_PRIMARY" ]]; then
    echo "Updating primary color → $COLOR_PRIMARY..."
    replace_in_file "$SCSS_FILE" '#1a5276' "$COLOR_PRIMARY" && ((color_count++))
    # Also update README color table and CLAUDE.local.md
    replace_in_file "$VAULT_ROOT/templates/quarto-brand/README.md" '#1a5276' "$COLOR_PRIMARY"
    replace_in_file "$VAULT_ROOT/CLAUDE.local.md" '#1a5276' "$COLOR_PRIMARY"
fi
if [[ -n "$COLOR_SECONDARY" ]]; then
    echo "Updating secondary color → $COLOR_SECONDARY..."
    replace_in_file "$SCSS_FILE" '#2874a6' "$COLOR_SECONDARY" && ((color_count++))
    replace_in_file "$VAULT_ROOT/templates/quarto-brand/README.md" '#2874a6' "$COLOR_SECONDARY"
    replace_in_file "$VAULT_ROOT/CLAUDE.local.md" '#2874a6' "$COLOR_SECONDARY"
fi
if [[ -n "$COLOR_ACCENT" ]]; then
    echo "Updating accent color → $COLOR_ACCENT..."
    replace_in_file "$SCSS_FILE" '#3498db' "$COLOR_ACCENT" && ((color_count++))
    replace_in_file "$VAULT_ROOT/templates/quarto-brand/README.md" '#3498db' "$COLOR_ACCENT"
fi

# Role/industry context — add Owner Context to CLAUDE.md
if [[ -n "$USER_ROLE" || -n "$USER_DOMAIN" ]] && ! $DRY_RUN; then
    CLAUDE_MD="$VAULT_ROOT/CLAUDE.md"
    if ! grep -q "## Owner Context" "$CLAUDE_MD"; then
        # Insert after "## What This Is" section's first paragraph
        "${SED_INPLACE[@]}" "/^## What This Is$/,/^$/{
            /^$/a\\
\\
## Owner Context\\
- **Name:** $USER_NAME\\
- **Organization:** $ORG_NAME\\
- **Role:** ${USER_ROLE:-Not specified}\\
- **Domain:** ${USER_DOMAIN:-Not specified}
        }" "$CLAUDE_MD"
        echo "  Added Owner Context section to CLAUDE.md"
    fi
elif [[ -n "$USER_ROLE" || -n "$USER_DOMAIN" ]] && $DRY_RUN; then
    echo "  [dry-run] CLAUDE.md: Would add Owner Context section"
fi

# MCP configuration
if [[ "$MCP_CHOICE" != "skip" && -n "$MCP_CHOICE" ]]; then
    MCP_EXAMPLE="$VAULT_ROOT/.mcp.json.example"
    MCP_TARGET="$VAULT_ROOT/.mcp.json"

    if [[ -f "$MCP_EXAMPLE" ]]; then
        if $DRY_RUN; then
            echo "  [dry-run] Would create .mcp.json from .mcp.json.example"
        else
            cp "$MCP_EXAMPLE" "$MCP_TARGET"

            # Remove unselected servers
            if [[ "$MCP_CHOICE" != "all" ]]; then
                # Parse comma-separated numbers
                IFS=',' read -ra selections <<< "$MCP_CHOICE"
                local_servers=("basic-memory" "filesystem" "markitdown")
                keep=()
                for sel in "${selections[@]}"; do
                    sel=$(echo "$sel" | tr -d ' ')
                    if [[ "$sel" =~ ^[1-3]$ ]]; then
                        keep+=("${local_servers[$((sel-1))]}")
                    fi
                done

                # Use python to filter JSON if available, otherwise keep all
                if command -v python3 &>/dev/null; then
                    python3 -c "
import json, sys
keep = sys.argv[1:]
with open('$MCP_TARGET') as f:
    data = json.load(f)
filtered = {k: v for k, v in data['mcpServers'].items() if k in keep}
data['mcpServers'] = filtered
with open('$MCP_TARGET', 'w') as f:
    json.dump(data, f, indent=2)
    f.write('\n')
" "${keep[@]}"
                fi
            fi
            echo "  Created .mcp.json with selected servers"
        fi
    fi
fi

# ── Create Marker & Summary ───────────────────────────────────────────────────

if ! $DRY_RUN; then
    mkdir -p "$VAULT_ROOT/.claude"
    cat > "$SETUP_MARKER" <<MARKER
Setup completed: $(date -Iseconds)
Name: $USER_NAME
Organization: $ORG_NAME
Role: ${USER_ROLE:-Not specified}
Domain: ${USER_DOMAIN:-Not specified}
Colors: ${COLOR_PRIMARY:-default} / ${COLOR_SECONDARY:-default} / ${COLOR_ACCENT:-default}
MCP: ${MCP_CHOICE:-skip}
MARKER
fi

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║  ✅ Setup Complete!                                      ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "  Name:          $USER_NAME ($name_count files updated)"
echo "  Organization:  $ORG_NAME ($org_count files updated)"
echo "  Role:          ${USER_ROLE:-Not specified}"
echo "  Brand Colors:  ${COLOR_PRIMARY:-default} / ${COLOR_SECONDARY:-default} / ${COLOR_ACCENT:-default} ($color_count files updated)"
echo "  MCP Servers:   ${MCP_CHOICE:-skip}"
echo ""
echo "📋 Next steps:"
echo "  1. Update todo.md with your current tasks"
echo "  2. Update roadmap.md with your milestones"
echo "  3. Add contacts to network/ (see network/example-person.md)"
echo "  4. Open in Obsidian and install recommended plugins"
echo "  5. Run 'claude' then '/daily' for your first strategic brief"
if $DRY_RUN; then
    echo ""
    echo "  ⚠  This was a dry run. No files were modified."
    echo "  Run without --dry-run to apply changes."
fi
