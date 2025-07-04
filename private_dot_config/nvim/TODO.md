# ✅ Todo Comments Management Cheatsheet

## 📋 **Quick Reference**

### **🎯 Navigation Keys**
| Key | Command | Description |
|-----|---------|-------------|
| `]t` | Next todo | Jump to next todo comment |
| `[t` | Previous todo | Jump to previous todo comment |

### **🔍 Search & Management**
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>xt` | Todo (Trouble) | Show all todos in Trouble |
| `<leader>xT` | Todo/Fix/Fixme | Show urgent todos only |
| `<leader>st` | Todo search | Search todos with Telescope |
| `<leader>sT` | Urgent todo search | Search urgent todos only |

---

## 🏷️ **Todo Comment Types**

### **🚨 Error & Fixes (High Priority)**
```python
# TODO: Implement user authentication
# FIXME: Fix memory leak in upload function
# BUG: Button doesn't respond on mobile
# ISSUE: Database connection timeout
# FIXIT: Incorrect calculation in tax module
```
**Icon**: 🐛 | **Color**: Red | **Priority**: High

### **📝 General Todos (Medium Priority)**
```javascript
// TODO: Add error handling for API calls
// INFO: This function handles user login
// NOTE: Remember to update documentation
```
**Icon**: 📝 | **Color**: Blue | **Priority**: Medium

### **⚠️ Warnings & Hacks (Medium Priority)**
```go
// WARN: This approach might cause performance issues
// WARNING: Deprecated function, replace soon
// HACK: Temporary workaround for API bug
// XXX: This code needs review
```
**Icon**: ⚠️ | **Color**: Orange | **Priority**: Medium

### **⚡ Performance & Optimization (Low Priority)**
```rust
// PERF: Consider using a more efficient algorithm
// OPTIMIZE: Cache database queries here
// OPTIM: Reduce memory allocation in loop
// PERFORMANCE: Profile this function under load
```
**Icon**: ⚡ | **Color**: Purple | **Priority**: Low

### **🧪 Testing (Medium Priority)**
```python
# TEST: Add unit tests for edge cases
# TESTING: Mock external API calls
# PASSED: Integration tests working
# FAILED: Need to fix test setup
```
**Icon**: 🧪 | **Color**: Pink | **Priority**: Medium

---

## 🎨 **Visual Highlighting**

### **🌈 Color Coding**
- **🔴 Red**: FIX, FIXME, BUG, ISSUE (Critical)
- **🟠 Orange**: WARN, WARNING, HACK, XXX (Important)
- **🔵 Blue**: TODO, INFO, NOTE (Standard)
- **🟣 Purple**: PERF, OPTIMIZE, OPTIM (Enhancement)
- **🩷 Pink**: TEST, TESTING (Quality)

### **✨ Highlighting Styles**
- **Keywords**: Bold and colored
- **Comments**: Highlighted background
- **Multiline**: Supports multi-line todos
- **Icons**: Visual indicators in sign column

---

## 🔍 **Search & Filter**

### **🔭 Telescope Integration**
```bash
<leader>st    # Search all todos
<leader>sT    # Search only TODO, FIX, FIXME

# Search specific keywords
:TodoTelescope keywords=HACK,WARN
:TodoTelescope keywords=PERF,OPTIMIZE
```

### **⚠️ Trouble Integration**
```bash
<leader>xt    # Show all todos in Trouble
<leader>xT    # Show urgent todos only

# Filter by type in Trouble interface
:TodoTrouble keywords=BUG,FIXME
:TodoTrouble keywords=TEST,PERF
```

---

## 📝 **Writing Effective Todo Comments**

### **✅ Good Examples**
```python
# TODO: Add input validation for email addresses
# FIXME: Race condition in user login (affects mobile users)
# PERF: Cache user permissions to reduce DB queries
# TEST: Add integration tests for payment processing
# NOTE: This algorithm assumes sorted input arrays
```

### **❌ Poor Examples**
```python
# TODO: fix this
# FIXME: broken
# TODO: do stuff later
# NOTE: important
```

### **📋 Best Practices**
1. **Be specific**: Describe exactly what needs to be done
2. **Add context**: Explain why it's needed
3. **Include scope**: Mention affected areas/users
4. **Set priority**: Use appropriate keywords
5. **Link issues**: Reference issue numbers when relevant

---

## 🎯 **Workflow Integration**

### **📅 Daily Development**
```bash
# Start of day - check todos
<leader>xt

# During development - add todos
# TODO: Refactor this function for better readability
# FIXME: Handle null pointer exception

# End of day - review todos
<leader>st    # Search all todos
]t ]t ]t      # Navigate through them
```

### **🔄 Code Review Process**
1. **Before committing**: `<leader>xt` to review all todos
2. **Address urgent items**: Focus on FIX, FIXME, BUG first
3. **Document decisions**: Convert TODOs to NOTEs if deferring
4. **Clean up**: Remove completed todos
5. **Track progress**: Move to issue tracker if needed

### **🧹 Maintenance Workflow**
```bash
# Weekly todo cleanup
<leader>st                    # Review all todos
:TodoTelescope keywords=FIXME # Focus on urgent items

# Monthly optimization review
:TodoTelescope keywords=PERF,OPTIMIZE

# Quarterly tech debt review
:TodoTelescope keywords=HACK,WARNING
```

---

## 🛠️ **Configuration Examples**

### **📝 Language-Specific Patterns**
```lua
-- In your todo-comments configuration
highlight = {
  pattern = {
    [[.*<(KEYWORDS)\s*:]], -- Standard: TODO:
    [[.*\*\s*(KEYWORDS)\s*:]], -- Markdown: * TODO:
    [[.*//\s*(KEYWORDS)\s*:]], -- C/C++: // TODO:
    [[.*#\s*(KEYWORDS)\s*:]], -- Python/Shell: # TODO:
    [[.*--\s*(KEYWORDS)\s*:]], -- SQL/Lua: -- TODO:
  },
}
```

### **🎨 Custom Keywords**
```lua
keywords = {
  FUTURE = { icon = "🔮", color = "hint" },
  IDEA = { icon = "💡", color = "info" },
  QUESTION = { icon = "❓", color = "warning" },
  REVIEW = { icon = "👀", color = "info" },
  SECURITY = { icon = "🔒", color = "error" },
}
```

---

## 📊 **Project Management Integration**

### **📈 Todo Metrics**
```bash
# Get todo statistics
rg "TODO|FIXME|BUG|HACK" --count-matches

# Generate todo report
rg "(TODO|FIXME|BUG|HACK|PERF):" --no-heading | wc -l
```

### **🎯 Sprint Planning**
1. **Extract todos**: `<leader>st` to see all todos
2. **Prioritize**: Focus on FIX/FIXME for current sprint
3. **Estimate**: Convert TODOs to story points
4. **Track**: Move to project management tool
5. **Update**: Replace completed todos with NOTEs

---

## 🎨 **Pro Tips**

💡 **Color consistency**: Use consistent keywords across your team
💡 **Context matters**: Always explain why, not just what
💡 **Regular cleanup**: Review todos weekly during code review
💡 **Link issues**: Reference issue numbers for tracking
💡 **Team standards**: Establish team conventions for todo usage
💡 **Automation**: Use git hooks to prevent committing certain todos
💡 **Documentation**: Convert important NOTEs to proper documentation

### **🔥 Efficiency Tips**
- Use `]t` and `[t` to quickly navigate through todos
- Use `<leader>xt` for a quick overview before commits
- Filter by keyword type for focused review sessions
- Use multiline todos for complex explanations
- Combine with git blame to track todo age
- Set up automated reports for todo metrics

### **📋 Team Workflow**
- **Code review**: Always check for new todos
- **Sprint planning**: Convert todos to user stories
- **Retrospectives**: Review todo patterns and cleanup
- **Documentation**: Graduate important NOTEs to wikis
- **Onboarding**: Use todos to mark learning opportunities

Your todo management system is now professional-grade for tracking technical debt and development tasks! ✅✨# ✅ Todo Comments Management Cheatsheet

## 📋 **Quick Reference**

### **🎯 Navigation Keys**
| Key | Command | Description |
|-----|---------|-------------|
| `]t` | Next todo | Jump to next todo comment |
| `[t` | Previous todo | Jump to previous todo comment |

### **🔍 Search & Management**
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>xt` | Todo (Trouble) | Show all todos in Trouble |
| `<leader>xT` | Todo/Fix/Fixme | Show urgent todos only |
| `<leader>st` | Todo search | Search todos with Telescope |
| `<leader>sT` | Urgent todo search | Search urgent todos only |

---

## 🏷️ **Todo Comment Types**

### **🚨 Error & Fixes**
```python
# TODO: Implement user authentication
# FIXME: Fix memory leak in upload function
# BUG: Button doesn't respond on mobile
# ISSUE: Database connection timeout
# FIXIT: Incorrect calculation in tax module
```
**Icon**: 🐛 | **Color**: Red | **Priority**: High

### **📝 General Todos**
```javascript
// TODO: Add error handling for API calls
// INFO: This function handles user login
// NOTE: Remember to update documentation
```
**Icon**: 📝 | **Color
