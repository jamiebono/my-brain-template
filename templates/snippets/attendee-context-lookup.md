<%*
// ═══════════════════════════════════════════════════════════════════════════
// 👥 ATTENDEE CONTEXT LOOKUP SNIPPET
// ═══════════════════════════════════════════════════════════════════════════
// Auto-populates meeting context by searching network/ person files for
// attendees and finding previous meetings with those people
//
// Usage: Insert this snippet after creating a meeting note, or have the Meeting Maestro
// run this as part of meeting prep workflow
// ═══════════════════════════════════════════════════════════════════════════

// Get attendees from frontmatter or prompt
let attendees = tp.frontmatter?.attendees;
if (!attendees || attendees.length === 0) {
    const attendeeInput = await tp.system.prompt("Attendees to look up (comma-separated):", "");
    attendees = attendeeInput.split(',').map(a => a.trim()).filter(a => a);
}

// Function to find attendee's person file in network/ folder
async function findPersonFile(name) {
    const networkFolder = app.vault.getAbstractFileByPath("network");
    if (!networkFolder || !networkFolder.children) return null;

    const nameLower = name.toLowerCase();

    for (const file of networkFolder.children) {
        if (!file.path.endsWith('.md')) continue;

        try {
            const content = await app.vault.read(file);
            // Check aliases in frontmatter
            if (content.startsWith('---')) {
                const endIdx = content.indexOf('---', 3);
                if (endIdx !== -1) {
                    const frontmatter = content.substring(3, endIdx);
                    // Check if name appears in aliases
                    if (frontmatter.toLowerCase().includes(nameLower)) {
                        return { file, content };
                    }
                }
            }
            // Also check filename match
            const stem = file.basename.replace(/-/g, ' ');
            if (stem.toLowerCase().includes(nameLower) || nameLower.includes(stem.toLowerCase())) {
                return { file, content };
            }
        } catch (e) {
            // Skip files that can't be read
        }
    }
    return null;
}

// Function to parse person file frontmatter
function parseFrontmatter(content) {
    const result = {};
    if (!content.startsWith('---')) return result;
    const endIdx = content.indexOf('---', 3);
    if (endIdx === -1) return result;
    const fm = content.substring(3, endIdx);

    const fields = ['role', 'company', 'email', 'last_contact', 'last_context', 'relationship_type'];
    for (const field of fields) {
        const match = fm.match(new RegExp(`${field}:\\s*"?([^"\\n]*)"?`));
        if (match) result[field] = match[1].trim();
    }
    return result;
}

// Function to get notes section from person file
function getNotesSection(content) {
    const notesMatch = content.match(/## Notes\s*\n([\s\S]*?)(?=\n## |\n---\s*$|$)/);
    if (notesMatch) {
        return notesMatch[1].trim().substring(0, 300); // First 300 chars
    }
    return null;
}

// Function to search for previous meetings with attendee
async function findPreviousMeetings(name) {
    const files = app.vault.getMarkdownFiles();
    const meetings = [];

    for (const file of files) {
        if (file.path.includes('meeting') || file.path.includes('Meeting')) {
            const content = await app.vault.read(file);
            if (content.toLowerCase().includes(name.toLowerCase())) {
                const match = file.basename.match(/(\d{4}-\d{2}-\d{2})/);
                if (match) {
                    meetings.push({
                        date: match[1],
                        title: file.basename,
                        path: file.path
                    });
                }
            }
        }
    }

    return meetings.sort((a, b) => b.date.localeCompare(a.date)).slice(0, 3);
}

// Build output
let output = "\n## Attendee Context\n\n";
output += "> [!info] Auto-populated from `network/` person files and meeting history\n\n";

for (const attendee of attendees) {
    output += `### ${attendee}\n`;

    // Search network/ for person file
    const personResult = await findPersonFile(attendee);
    if (personResult) {
        const fm = parseFrontmatter(personResult.content);
        if (fm.role && fm.company) {
            output += `**Role:** ${fm.role} @ ${fm.company}\n`;
        }
        if (fm.email) {
            output += `**Email:** ${fm.email}\n`;
        }
        if (fm.last_contact) {
            output += `**Last Contact:** ${fm.last_contact}`;
            if (fm.last_context) output += ` - ${fm.last_context}`;
            output += '\n';
        }
        const notes = getNotesSection(personResult.content);
        if (notes) {
            output += `**Context:** ${notes}\n`;
        }
        output += `**Profile:** [[${personResult.file.basename}]]\n`;
    } else {
        output += `*Not found in network/ — consider creating a person file after meeting*\n`;
    }

    // Get previous meetings
    const previousMeetings = await findPreviousMeetings(attendee);
    if (previousMeetings.length > 0) {
        output += `\n**Previous Meetings:**\n`;
        for (const meeting of previousMeetings) {
            output += `- [[${meeting.path}|${meeting.title}]] (${meeting.date})\n`;
        }
    }

    output += "\n---\n\n";
}

// Add relationship insights prompt
output += `> [!question] Pre-meeting Questions\n`;
output += `> - What's their current priority/concern?\n`;
output += `> - What do they need from this meeting?\n`;
output += `> - Any political considerations?\n`;

tR += output;
_%>
