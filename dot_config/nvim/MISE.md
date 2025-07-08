# 🛠️ Mise Configuration for Neovim Development

## 📋 **Overview**

This guide configures [mise](https://mise.jdx.dev/) to provide all the development tools your Neovim configuration needs across Go, Python, Zig, and Node.js projects.

---

## 🚀 **Global Mise Configuration**

### **📄 `~/.config/mise/config.toml`**
```toml
# Global mise configuration for Neovim development tools

[tools]
# Core development languages
go = "latest"           # Go compiler and tools
python = "3.12"         # Python 3.12 (stable)
node = "lts"           # Node.js LTS for web development
zig = "latest"         # Zig compiler

# Language servers (auto-installed by Mason, but can be global)
"npm:typescript-language-server" = "latest"
"npm:vscode-langservers-extracted" = "latest"

# Formatters and linters
uv = "latest"          # Modern Python package manager
ruff = "latest"        # Python linter/formatter (via UV)
gofumpt = "latest"     # Go formatter
golangci-lint = "latest" # Go linter

# Development tools
ripgrep = "latest"     # Required for Telescope live_grep
fd = "latest"          # Better find (used by Telescope)
lazygit = "latest"     # Git TUI
git-delta = "latest"   # Better git diffs
btm = "latest"         # Process monitor
jq = "latest"          # JSON processor

# Build tools
make = "latest"        # Build automation
cmake = "latest"       # C/C++ build system

[env]
# Environment variables (fixed PATH syntax)
# Note: PATH manipulation is handled automatically by mise
PYTHONDONTWRITEBYTECODE = "1"
PIP_DISABLE_PIP_VERSION_CHECK = "1"

# Go optimizations
GOPROXY = "https://proxy.golang.org,direct"
GOSUMDB = "sum.golang.org"

# Development environment
EDITOR = "nvim"
VISUAL = "nvim"

# Mise-specific settings
MISE_EXPERIMENTAL = "1"
```

---

## 📁 **Project-Specific Configurations**

### **🐹 Go Project (`.mise.toml`)**
```toml
[tools]
go = "1.22"           # Specific Go version for project
golangci-lint = "latest"
gofumpt = "latest"
delve = "latest"      # Go debugger

[env]
CGO_ENABLED = "1"
GOFLAGS = "-mod=readonly"

[tasks.run]
run = "go run ."
description = "Run the Go application"

[tasks.test]
run = "go test ./..."
description = "Run all tests"

[tasks.build]
run = "go build -o bin/app ."
description = "Build the application"

[tasks.lint]
run = "golangci-lint run"
description = "Lint the code"

[tasks.fmt]
run = "gofumpt -w ."
description = "Format the code"
```

### **🐍 Python Project (`.mise.toml`)**
```toml
[tools]
python = "3.12"
uv = "latest"
ruff = "latest"

[env]
# UV configuration
UV_CACHE_DIR = "./.uv-cache"
UV_PYTHON_PREFERENCE = "only-managed"

# Python configuration
PYTHONPATH = "./src"
PYTHONDONTWRITEBYTECODE = "1"

[tasks.install]
run = "uv sync"
description = "Install dependencies"

[tasks.run]
run = "uv run python src/main.py"
description = "Run the application"

[tasks.test]
run = "uv run pytest"
description = "Run tests"

[tasks.lint]
run = "uv run ruff check ."
description = "Lint the code"

[tasks.format]
run = "uv run ruff format ."
description = "Format the code"

[tasks.check]
run = [
    "uv run ruff check .",
    "uv run ruff format --check .",
    "uv run mypy ."
]
description = "Run all checks"
```

### **⚡ Zig Project (`.mise.toml`)**
```toml
[tools]
zig = "0.12.0"        # Pin to specific Zig version
zls = "latest"        # Zig Language Server

[tasks.run]
run = "zig run src/main.zig"
description = "Run the Zig application"

[tasks.build]
run = "zig build"
description = "Build the project"

[tasks.test]
run = "zig test src/main.zig"
description = "Run tests"

[tasks.fmt]
run = "zig fmt ."
description = "Format the code"

[tasks.check]
run = "zig build-exe src/main.zig -fno-emit-bin"
description = "Check syntax without building"
```

### **🌐 Node.js/Web Project (`.mise.toml`)**
```toml
[tools]
node = "20"           # Pin to Node 20 LTS
pnpm = "latest"       # Fast package manager
typescript = "latest"

[env]
NODE_ENV = "development"

[tasks.install]
run = "pnpm install"
description = "Install dependencies"

[tasks.dev]
run = "pnpm dev"
description = "Start development server"

[tasks.build]
run = "pnpm build"
description = "Build for production"

[tasks.test]
run = "pnpm test"
description = "Run tests"

[tasks.lint]
run = "pnpm lint"
description = "Lint the code"

[tasks.format]
run = "pnpm format"
description = "Format the code"

[tasks.type-check]
run = "pnpm type-check"
description = "Run TypeScript type checking"
```

---

## 🔧 **Neovim Integration**

### **📄 `~/.config/nvim/lua/mise-integration.lua`**
```lua
-- lua/mise-integration.lua (Optional: Enhanced mise integration)

local M = {}

-- Check if mise is available
local function has_mise()
  return vim.fn.executable('mise') == 1
end

-- Get mise-managed tool path
local function get_tool_path(tool)
  if not has_mise() then return nil end

  local handle = io.popen('mise which ' .. tool .. ' 2>/dev/null')
  if not handle then return nil end

  local result = handle:read('*a')
  handle:close()

  if result and result ~= '' then
    return vim.trim(result)
  end
  return nil
end

-- Setup LSP with mise-managed tools
function M.setup_lsp_paths()
  -- Go tools
  local gopls_path = get_tool_path('gopls')
  if gopls_path then
    vim.g.go_gopls_path = gopls_path
  end

  -- Python tools
  local python_path = get_tool_path('python')
  if python_path then
    vim.g.python3_host_prog = python_path
  end

  -- Update PATH for LSP servers
  if has_mise() then
    local mise_path = vim.fn.system('mise env --shell=bash | grep "^export PATH" | cut -d= -f2- | tr -d \'"\'')
    if mise_path and mise_path ~= '' then
      vim.env.PATH = vim.trim(mise_path)
    end
  end
end

-- Auto-activate mise on directory change
function M.setup_auto_activation()
  vim.api.nvim_create_autocmd({'DirChanged', 'VimEnter'}, {
    callback = function()
      if has_mise() then
        -- Refresh environment when changing directories
        local handle = io.popen('mise env --shell=bash 2>/dev/null')
        if handle then
          local env_output = handle:read('*a')
          handle:close()

          -- Parse and apply environment variables
          for line in env_output:gmatch('[^\r\n]+') do
            local var, value = line:match('^export ([^=]+)=(.+)$')
            if var and value then
              -- Remove quotes and apply
              value = value:gsub('^"', ''):gsub('"$', '')
              vim.env[var] = value
            end
          end
        end
      end
    end,
  })
end

-- Show current mise environment info
function M.show_info()
  if not has_mise() then
    print("Mise not found")
    return
  end

  print("=== Mise Environment ===")

  -- Show active tools
  local tools = vim.fn.system('mise list --current 2>/dev/null')
  if tools and tools ~= '' then
    print("Active tools:")
    print(tools)
  end

  -- Show project tasks
  local tasks = vim.fn.system('mise tasks 2>/dev/null')
  if tasks and tasks ~= '' then
    print("Available tasks:")
    print(tasks)
  end
end

-- Run mise task
function M.run_task(task)
  if not has_mise() then
    print("Mise not found")
    return
  end

  local cmd = 'mise run ' .. (task or '')
  vim.cmd('terminal ' .. cmd)
end

return M
```

### **📄 Add to `init.lua`**
```lua
-- init.lua (add this after your existing configuration)

-- Setup mise integration
local mise_ok, mise = pcall(require, 'mise-integration')
if mise_ok then
  mise.setup_lsp_paths()
  mise.setup_auto_activation()

  -- Add keybindings for mise
  vim.keymap.set('n', '<leader>mi', function() mise.show_info() end, { desc = 'Mise info' })
  vim.keymap.set('n', '<leader>mr', function()
    vim.ui.input({ prompt = 'Mise task: ' }, function(task)
      if task then mise.run_task(task) end
    end)
  end, { desc = 'Run mise task' })
end
```

---

## ⚙️ **Shell Integration**

### **🐚 Add to `~/.zshrc` or `~/.bashrc`**
```bash
# Mise activation
eval "$(mise activate)"

# Aliases for common development tasks
alias msr="mise run"
alias mst="mise tasks"
alias msl="mise list"
alias msi="mise install"
alias msu="mise use"

# Project shortcuts
alias dev="mise run dev"
alias test="mise run test"
alias build="mise run build"
alias lint="mise run lint"
alias fmt="mise run format"

# Neovim with mise environment
alias nvim="mise exec -- nvim"
alias vim="mise exec -- nvim"

# Development environment info
mise_info() {
    echo "🛠️  Current Mise Environment"
    echo "============================="
    mise list --current
    echo ""
    echo "📋 Available Tasks:"
    mise tasks 2>/dev/null | head -10
}

# Auto-activate mise in new directories
chpwd() {
    if [[ -f .mise.toml ]] || [[ -f .tool-versions ]]; then
        echo "🔄 Activating mise environment..."
        mise install >/dev/null 2>&1 &
    fi
}
```

---

## 🎯 **Workflow Examples**

### **🚀 Starting New Project**
```bash
# Create new Go project
mkdir my-go-app && cd my-go-app
mise use go@latest golangci-lint@latest gofumpt@latest
go mod init my-go-app

# Create mise tasks
cat > .mise.toml << 'EOF'
[tools]
go = "latest"
golangci-lint = "latest"
gofumpt = "latest"

[tasks.run]
run = "go run ."

[tasks.test]
run = "go test ./..."

[tasks.build]
run = "go build ."
EOF

# Start development
nvim main.go
```

### **🐍 Python Project with UV**
```bash
# Create new Python project
mkdir my-python-app && cd my-python-app
mise use python@3.12 uv@latest

# Initialize with UV
uv init
uv add --dev pytest ruff mypy

# Configure mise
cat > .mise.toml << 'EOF'
[tools]
python = "3.12"
uv = "latest"

[tasks.install]
run = "uv sync"

[tasks.run]
run = "uv run python src/main.py"

[tasks.test]
run = "uv run pytest"
EOF

# Start development
mise run install
nvim src/main.py
```

---

## 🔍 **Troubleshooting**

### **❌ Common Issues**

**LSP not finding tools:**
```bash
# Check mise environment
mise doctor

# Verify tool installation
mise list --current

# Check PATH in Neovim
:lua print(vim.env.PATH)
```

**Mason conflicts:**
```bash
# Let Mason handle LSP servers, mise handles runtimes
mise use go@latest python@3.12 node@lts zig@latest
# Don't install gopls, pyright, etc. with mise - let Mason handle them
```

**Environment not activating:**
```bash
# Ensure mise is properly activated
eval "$(mise activate)"

# Check if .mise.toml is valid
mise check
```

---

## 🎨 **Pro Tips**

💡 **Global + Local**: Use global config for tools, local for versions
💡 **Task automation**: Define common tasks in `.mise.toml`
💡 **Environment isolation**: Each project gets its own tool versions
💡 **Shell integration**: Use aliases for common mise commands
💡 **Neovim integration**: Let mise handle runtimes, Mason handle LSPs
💡 **Performance**: Use `mise install` to pre-install tools
💡 **Version pinning**: Pin versions in production projects

### **🔥 Efficiency Tips**
- Use `mise run` instead of remembering project-specific commands
- Set up global tools for everyday development
- Use task aliases in your shell for super quick access
- Let Neovim auto-detect mise-managed tools
- Use `mise doctor` to diagnose issues
- Keep `.mise.toml` files in version control

Your development environment is now fully automated and consistent across all projects! 🚀
