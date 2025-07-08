# 📓 Neorg Note-taking Cheatsheet

## 📋 **Quick Reference**

### **🎯 Key Prefix: `<leader>n*`**
All Neorg commands use lowercase `n` for note-taking and organization.

---

## 🏠 **Workspace Management**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>nw` | Workspaces | Switch between workspaces |
| `<leader>nr` | Return to index | Go back to workspace index |

### **📁 Default Workspaces**
- **`notes`** - Main notes workspace (`~/notes`)
- **`work`** - Work-related notes (`~/notes/work`)
- **`personal`** - Personal notes (`~/notes/personal`)
- **`projects`** - Project documentation (`~/notes/projects`)

---

## 📰 **Journal Management**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>nj` | Open journal | Access journal system |
| `<leader>nt` | Today's journal | Create/open today's entry |
| `<leader>ny` | Yesterday's journal | Open yesterday's entry |
| `<leader>nm` | Tomorrow's journal | Create tomorrow's entry |

### **📅 Journal Structure**
```
~/notes/journal/
├── 2024/
│   ├── 01/
│   │   ├── 01.norg  # January 1st
│   │   ├── 02.norg  # January 2nd
│   │   └── ...
│   └── 02/
└── template.norg    # Journal template
```

---

## 📝 **Note Management**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>nn` | New note | Create a new note |
| `<leader>nf` | Find note | Search and open notes |
| `<leader>nl` | Link to note | Create link to another note |

### **🔗 Linking Notes**
```norg
{:~/notes/work/project-alpha:}[Project Alpha]
{:$/personal/ideas:}[My Ideas]
{:meeting-notes:}[Today's Meeting]
```

---

## ✅ **GTD (Getting Things Done)**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ngc` | GTD capture | Quick capture inbox item |
| `<leader>ngv` | GTD views | View GTD perspectives |
| `<leader>nge` | GTD edit | Edit GTD items |

### **📋 GTD Workflow**
1. **Capture** (`<leader>ngc`) - Quickly capture thoughts
2. **Clarify** - Process inbox items
3. **Organize** - File into projects/areas
4. **Reflect** (`<leader>ngv`) - Review and plan
5. **Engage** - Take action

### **📁 GTD Structure**
```
~/notes/
├── inbox.norg        # Capture everything here
├── projects/         # Specific outcomes
├── areas/           # Areas of responsibility
├── archive/         # Completed items
└── someday.norg     # Maybe/someday list
```

---

## 📤 **Export & Sharing**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>nep` | Export to file | Export to various formats |
| `<leader>neh` | Export to HTML | Create HTML output |
| `<leader>nem` | Export to Markdown | Convert to Markdown |

### **📊 Export Formats**
- **HTML** - For web sharing
- **Markdown** - For GitHub, docs
- **LaTeX** - For academic papers
- **Plain text** - Universal format

---

## 🔧 **Advanced Tools**

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ntc` | Table of contents | Generate TOC |
| `<leader>nts` | Tangle current file | Extract code blocks |

---

## ⌨️ **In-File Navigation** (`.norg` files only)

| Key | Command | Description |
|-----|---------|-------------|
| `<CR>` | Follow link | Jump to linked note |
| `<M-CR>` | Follow in split | Open link in vertical split |
| `<C-Space>` | Cycle task state | Toggle todo status |
| `]]` | Next heading | Jump to next heading |
| `[[` | Previous heading | Jump to previous heading |
| `<M-l>` | Promote | Move item up a level |
| `<M-h>` | Demote | Move item down a level |

---

## 📝 **Neorg Syntax Quick Reference**

### **📑 Headings**
```norg
* Level 1 Heading
** Level 2 Heading
*** Level 3 Heading
**** Level 4 Heading
***** Level 5 Heading
****** Level 6 Heading
```

### **✅ Task Lists**
```norg
- ( ) Undone task
- (x) Done task
- (!) Important task
- (+) Recurring task
- (-) Cancelled task
- (?) Question/uncertain
- (=) On hold
```

### **📋 Lists**
```norg
- Unordered list item
- Another item
  -- Nested item
  -- Another nested item

~ Ordered list item
~ Second item
  ~~ Nested ordered item
  ~~ Another nested item
```

### **🎨 Text Formatting**
```norg
*bold text*
/italic text/
_underlined text_
-strikethrough text-
!spoiler text!
^superscript^
,subscript,
`verbatim/code`
```

### **🔗 Links & References**
```norg
{:file-name:}[Link Text]
{:~/absolute/path:}[Absolute Link]
{:$/relative/path:}[Relative Link]
{https://example.com}[Web Link]
{# Heading}[Internal Link]
```

### **💻 Code Blocks**
```norg
@code lua
function hello()
    print("Hello from Neorg!")
end
@end
```

### **📝 Quotes & Comments**
```norg
> This is a quote
> Multi-line quotes
> work like this

% This is a comment
%% This is also a comment
```

### **📊 Tables**
```norg
| Name    | Age | City        |
|---------|-----|-------------|
| Alice   | 25  | New York    |
| Bob     | 30  | Los Angeles |
| Charlie | 35  | Chicago     |
```

---

## 🔍 **Search & Navigation**

### **🔭 Telescope Integration**
- **Find notes**: `<leader>nf` uses Telescope
- **Live grep**: `<leader>fg` works in notes
- **Recent files**: `<leader>fr` includes `.norg` files

### **🧭 Quick Navigation**
```norg
Table of Contents:
{# Introduction}
{# Getting Started}
{# Advanced Features}
{# Conclusion}
```

---

## 🎯 **Common Workflows**

### **📅 Daily Journal Workflow**
1. `<leader>nt` - Open today's journal
2. Write daily notes, tasks, reflections
3. Link to relevant notes: `{:meeting-notes:}`
4. Use tasks for action items: `- ( ) Call client`
5. Review yesterday: `<leader>ny`

### **📋 GTD Capture Workflow**
1. `<leader>ngc` - Quick capture thought
2. Write brief description in inbox
3. Later: `<leader>ngv` - Process inbox
4. Clarify and organize into projects/areas
5. Regular review and planning

### **📚 Research Note Workflow**
1. `<leader>nn` - Create new research note
2. Use headings to structure: `* Topic`, `** Subtopic`
3. Link related concepts: `{:related-note:}`
4. Add references and sources
5. `<leader>ntc` - Generate table of contents

### **📖 Meeting Notes Workflow**
1. `<leader>nn` - New meeting note
2. Structure: `* Attendees`, `* Agenda`, `* Action Items`
3. Use tasks for follow-ups: `- ( ) Send follow-up email`
4. Link to project notes: `{:project-alpha:}`
5. Export if needed: `<leader>neh`

### **💡 Idea Management Workflow**
1. `<leader>ngc` - Quick capture ideas
2. Expand in dedicated idea notes
3. Link related ideas together
4. Use GTD someday/maybe for future ideas
5. Regular review and development

---

## 🎨 **Pro Tips**

💡 **Nested workspaces**: Organize by context (work, personal, projects)
💡 **Consistent structure**: Use templates for recurring note types
💡 **Link everything**: Create a web of connected knowledge
💡 **Daily review**: Use journal for reflection and planning
💡 **GTD system**: Capture everything, process regularly
💡 **Export options**: Share knowledge in multiple formats
💡 **Code integration**: Tangle code blocks for documentation

### **🔥 Efficiency Tips**
- Use `<leader>nt` daily for consistent journaling
- Capture quickly with `<leader>ngc`, process later
- Link liberally to create knowledge connections
- Use task states for different priority levels
- Export to Markdown for sharing with non-Neorg users
- Structure notes with consistent heading patterns
- Use nested lists for hierarchical information

### **📝 Organization Tips**
- **Workspaces**: Separate contexts clearly
- **Templates**: Create templates for recurring note types
- **Naming**: Use consistent, descriptive file names
- **Linking**: Create index notes for major topics
- **Archive**: Move completed projects to archive
- **Backup**: Keep notes in version control

Your note-taking and knowledge management system is now professional-grade! 📓✨
