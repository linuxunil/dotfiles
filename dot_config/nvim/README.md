# 🚀 Modern Neovim Configuration

A highly optimized, low cognitive load Neovim configuration designed for multi-language development with Go, Zig, Python, web technologies, and advanced note-taking.

## 📚 **Documentation**

### **🎯 Language-Specific Guides**
- **[🚀 Go Development](./GO.md)** - Complete Go workflow with testing, debugging, and tools
- **[🐍 Python Development](./PYTHON.md)** - Modern Python with UV, Ruff, and pytest
- **[⚡ Zig Development](./ZIG.md)** - Full Zig development cycle and ZLS integration
- **[📝 Markdown Editing](./DEVELOPMENT.md)** - Professional markdown with live preview and tables
- **[📓 Neorg Note-taking](./NEORG.md)** - Advanced knowledge management and GTD system

### **🔧 Configuration Guides**
- **[🛠️ Mise Integration](./MISE.md)** - Development tool management with mise
- **[✅ Todo Management](./TODO.md)** - Comment-based task tracking

### **📊 Quick Reference**
| Feature | Key Pattern | Guide |
|---------|-------------|-------|
| **Go Development** | `<leader>go*` | [Go Guide](./GO.md) |
| **Python Development** | `<leader>py*` | [Python Guide](./PYTHON.md) |
| **Zig Development** | `<leader>zg*` | [Zig Guide](./ZIG.md) |
| **Markdown Editing** | `<leader>m*` | [Markdown Guide](./DEVELOPMENT.md) |
| **Note-taking** | `<leader>n*` | [Neorg Guide](./NEORG.md) |
| **Todo Comments** | `]t` / `[t` | [Todo Guide](./TODO.md) |
| **File Management** | `<leader>e` | [General Guide](./README.md) |
| **Git Operations** | `<leader>g*` | [General Guide](./README.md) |

---

## ✨ **Key Features**

### **🔥 Zero-config setup**
- Language servers auto-install and configure
- Development tools managed by [mise](./mise-configuration.md)
- Consistent keybindings across all languages

### **⚡ Performance Optimized**
- Fast startup with lazy loading
- Efficient plugin management
- Reduced to 50 carefully selected plugins

### **🎯 Multi-language Support**
- **Go**: Full development cycle with testing and debugging
- **Python**: Modern workflow with UV and Ruff
- **Zig**: Complete toolchain integration
- **Web**: TypeScript, JavaScript, HTML, CSS support
- **Markdown**: Professional editing with live preview
- **Notes**: Advanced knowledge management with Neorg

### **🧠 Knowledge Management**
- **Neorg**: Advanced note-taking with GTD methodology
- **Todo Comments**: Code-embedded task management
- **Journal System**: Daily reflection and planning
- **Project Documentation**: Seamless markdown workflow
- **Session Management**: Automatically save and restore sessions with `mini.sessions`.

### **🚀 Supercharged Navigation**
- **Flash**: Lightning-fast in-file navigation.
- **Telescope**: Fuzzy finding for files, buffers, and more.
- **oil.nvim**: A Vim-like file explorer that lets you edit directories like buffers.

### **✂️ Snippet Expansion**
- **LuaSnip**: Powerful snippet engine for boilerplate expansion.
- **Friendly Snippets**: A large collection of pre-made snippets.

---

## 📦 **Installation**

### **Prerequisites**
- Neovim 0.9+
- Git
- [Nerd Font](https://www.nerdfonts.com/) for icons
- [mise](https://mise.jdx.dev/) for development tool management
- `ripgrep` for search functionality
- `make` for building native extensions

### **Quick Setup**
```bash
# 1. Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# 2. Clone this configuration
git clone <your-repo> ~/.config/nvim

# 3. Install mise (if not already installed)
curl https://mise.jdx.dev/install.sh | sh

# 4. Configure mise for development tools
cp ~/.config/nvim/docs/mise-example.toml ~/.config/mise/config.toml

# 5. Start Neovim - everything installs automatically
nvim
```

### **First Launch**
1. **Plugins install** automatically via lazy.nvim
2. **Language servers** install via Mason
3. **Development tools** install via mise
4. **Restart Neovim** after initial setup

### **Post-Installation Verification**
```bash
# Check health
:checkhealth

# Verify plugins
:Lazy

# Check language servers
:Mason

# Verify mise tools
mise doctor
```

---

## 🎯 **Quick Start**

### **🚀 Go Development**
```bash
# Create new project
mkdir my-go-app && cd my-go-app
mise use go@latest
go mod init my-go-app
nvim main.go

# Key commands:
# <leader>Gr - Run Go file
# <leader>Gt - Run tests
# <leader>Gb - Build project
```
📖 **[Complete Go Guide →](./go-cheatsheet.md)**

### **🐍 Python Development**
```bash
# Create new project
mkdir my-python-app && cd my-python-app
mise use python@3.12 uv@latest
uv init && uv add --dev pytest ruff
nvim main.py

# Key commands:
# <leader>pr - Run with UV
# <leader>pt - Run tests
# <leader>pf - Format with Ruff
```
📖 **[Complete Python Guide →](./python-cheatsheet.md)**

### **📓 Note-taking with Neorg**
```bash
# Start note-taking
nvim notes.norg

# Key commands:
# <leader>nt - Today's journal
# <leader>nn - New note
# <leader>ngc - GTD quick capture
```
📖 **[Complete Neorg Guide →](./neorg-cheatsheet.md)**

---

## 🔧 **Configuration Structure**

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json             # Plugin versions
├── lua/
│   ├── core/
│   │   ├── settings.lua       # Neovim settings
│   │   ├── keymaps.lua        # Key mappings
│   │   └── autocmds.lua       # Auto commands
│   ├── utils/
│   │   ├── mise-integration.lua # Mise integration
│   │   ├── performance.lua    # Performance monitoring
│   │   └── starter.lua        # Custom starter page
│   └── plugins/
│       ├── core/
│       │   ├── completion.lua
│       │   ├── debugging.lua
│       │   ├── formatting.lua
│       │   ├── lsp.lua
│       │   └── luasnip.lua
│       ├── editing/
│       │   ├── flash.lua
│       │   ├── git.lua
│       │   ├── mini.lua
│       │   ├── oil.lua
│       │   └── treesitter.lua
│       ├── lang/
│       │   ├── go.lua
│       │   ├── python.lua
│       │   └── zig.lua
│       ├── notes/
│       │   ├── markdown.lua
│       │   └── neorg.lua
│       ├── tools/
│       │   ├── snacks.lua
│       │   ├── todo-comments.lua
│       │   └── which-key.lua
│       └── ui/
│           ├── mini-starter.lua
│           ├── mini-statusline.lua
│           ├── mini-tabline.lua
│           ├── noice.lua
│           ├── telescope.lua
│           ├── theme.lua
│           └── visual.lua
└── GEMINI.md                  # Gemini agent context
```

---

## 🎨 **Workflow Examples**

### **💼 Daily Development Workflow**
1. **Start day**: `<leader>nt` - Open today's journal
2. **Find files**: `<leader>ff` - Quick file finder
3. **Code navigation**: `gd` - Go to definition, `gr` - Find references
4. **Run/test**: Language-specific commands (`<leader>Gr`, `<leader>pr`, etc.)
5. **Git workflow**: `<leader>gg` - LazyGit interface
6. **End day**: Journal reflection and tomorrow planning

### **📚 Research & Documentation**
1. **Capture ideas**: `<leader>ngc` - Quick GTD capture
2. **Create notes**: `<leader>nn` - New structured note
3. **Link knowledge**: Use Neorg linking syntax
4. **Write docs**: Markdown with live preview (`<leader>mp`)
5. **Organize**: Use GTD methodology for information management

### **🐛 Debugging Workflow**
1. **Set breakpoints**: `<leader>db`
2. **Start debugging**: Language-specific debug commands
3. **Navigate**: `<leader>di` (step into), `<leader>dO` (step over)
4. **Inspect**: Use DAP UI for variable inspection
5. **Document**: Add findings to notes or comments

---

## 🎯 **Key Benefits**

✅ **Consistent Experience** - Same patterns across all languages
✅ **Zero Configuration** - Works out of the box
✅ **Performance Optimized** - Fast startup and operation
✅ **Knowledge Management** - Integrated note-taking and GTD
✅ **Modern Tooling** - Latest development tools and practices
✅ **Comprehensive Docs** - Detailed guides for every feature
✅ **Tool Integration** - Seamless mise, UV, Ruff, and more

---

## 🤝 **Contributing**

See individual guides for language-specific improvements:
- [Go Development](./go-cheatsheet.md) for Go-related enhancements
- [Python Development](./python-cheatsheet.md) for Python improvements
- [Neorg Guide](./neorg-cheatsheet.md) for note-taking features

---

## 📝 **License**

MIT License - feel free to use and modify as needed.

---

**🎉 Happy coding and note-taking!**

This configuration minimizes cognitive load while maximizing productivity across development and knowledge management workflows. Check out the individual guides to master each aspect of the system.
