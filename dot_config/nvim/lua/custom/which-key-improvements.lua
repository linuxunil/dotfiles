-- lua/custom/which-key-improvements.lua
-- Advanced which-key enhancements for context-aware and dynamic keybindings

local M = {}

-- Setup function for advanced which-key improvements
M.setup = function()
  local wk = require("which-key")
  
  -- ===== CONDITIONAL KEYBINDINGS =====
  -- Only show LSP-related keybindings when LSP is active
  wk.add({
    {
      "<leader>c",
      group = "⚡ [C]ode Actions",
      cond = function()
        return #vim.lsp.get_clients({ bufnr = 0 }) > 0
      end,
    },
  })
  
  -- Git keybindings only in git repositories
  wk.add({
    {
      "<leader>g",
      group = "🔄 [G]it Operations",
      cond = function()
        return vim.fn.isdirectory(".git") == 1
      end,
    },
  })
  
  -- Database keybindings only when database files are present
  wk.add({
    {
      "<leader>d",
      group = "🗃️ [D]atabase",
      cond = function()
        local db_patterns = { "*.db", "*.sqlite", "*.sqlite3" }
        for _, pattern in ipairs(db_patterns) do
          if #vim.fn.glob(pattern, false, true) > 0 then
            return true
          end
        end
        return false
      end,
    },
  })
  
  -- ===== DYNAMIC KEYBINDINGS =====
  -- Note: The expand property requires functions as rhs, not command strings
  -- So we'll use conditional keybindings instead
  
  -- Project-specific keybindings based on project type
  local project_type = M.detect_project_type()
  
  if project_type == "go" then
    wk.add({
      { "<leader>pt", "<cmd>!go test ./...<cr>", desc = "🧪 Run Go tests" },
      { "<leader>pb", "<cmd>!go build<cr>", desc = "🔨 Build Go project" },
    })
  elseif project_type == "node" then
    wk.add({
      { "<leader>pt", "<cmd>!npm test<cr>", desc = "🧪 Run npm tests" },
      { "<leader>pb", "<cmd>!npm run build<cr>", desc = "🔨 Build npm project" },
    })
  elseif project_type == "python" then
    wk.add({
      { "<leader>pt", "<cmd>!python -m pytest<cr>", desc = "🧪 Run Python tests" },
      { "<leader>pr", "<cmd>!python %<cr>", desc = "🐍 Run Python script" },
    })
  end
  
  -- ===== CONTEXT-AWARE BUFFER KEYBINDINGS =====
  -- Different keybindings based on buffer type
  local function add_filetype_keybindings()
    local ft = vim.bo.filetype
    
    if ft == "lua" then
      wk.add({
        { "<leader>r", group = "🌙 [R]un Lua" },
        { "<leader>rl", "<cmd>luafile %<cr>", desc = "🌙 Run current Lua file" },
        { "<leader>rr", function() 
          local line = vim.api.nvim_get_current_line()
          loadstring(line)()
        end, desc = "🌙 Run current line" },
      }, { buffer = 0 })
    elseif ft == "markdown" then
      wk.add({
        { "<leader>r", group = "📝 [R]ender Markdown" },
        { "<leader>rp", "<cmd>MarkdownPreview<cr>", desc = "📝 Preview markdown" },
        { "<leader>rt", "<cmd>MarkdownPreviewToggle<cr>", desc = "📝 Toggle preview" },
      }, { buffer = 0 })
    elseif ft == "json" then
      wk.add({
        { "<leader>r", group = "📋 [R]eformat JSON" },
        { "<leader>rj", "<cmd>%!jq .<cr>", desc = "📋 Format JSON with jq" },
        { "<leader>rc", "<cmd>%!jq -c .<cr>", desc = "📋 Compact JSON" },
      }, { buffer = 0 })
    end
  end
  
  -- Auto-add filetype keybindings when entering buffers
  vim.api.nvim_create_autocmd("FileType", {
    callback = add_filetype_keybindings,
    desc = "Add filetype-specific which-key bindings",
  })
  
  -- ===== SMART DESCRIPTIONS =====
  -- Dynamic descriptions that show current state
  wk.add({
    {
      "<leader>tl",
      function()
        vim.o.list = not vim.o.list
      end,
      desc = function()
        return vim.o.list and "👁️ Hide list chars" or "👁️ Show list chars"
      end,
    },
    {
      "<leader>tw",
      function()
        vim.o.wrap = not vim.o.wrap
      end,
      desc = function()
        return vim.o.wrap and "↩️ Disable line wrap" or "↩️ Enable line wrap"
      end,
    },
    {
      "<leader>tn",
      function()
        vim.o.number = not vim.o.number
      end,
      desc = function()
        return vim.o.number and "🔢 Hide line numbers" or "🔢 Show line numbers"
      end,
    },
  })
  
  -- ===== QUICK INFO =====
  -- Quick version and info commands
  wk.add({
    { "<leader>?", "<cmd>version<cr>", desc = "ℹ️ Show Neovim version" },
  })
end

-- Helper function to detect project type
M.detect_project_type = function()
  if vim.fn.filereadable("go.mod") == 1 then
    return "go"
  elseif vim.fn.filereadable("package.json") == 1 then
    return "node"
  elseif vim.fn.filereadable("pyproject.toml") == 1 or vim.fn.filereadable("requirements.txt") == 1 then
    return "python"
  elseif vim.fn.filereadable("Cargo.toml") == 1 then
    return "rust"
  elseif vim.fn.filereadable("Makefile") == 1 then
    return "make"
  elseif vim.fn.filereadable(".mise.toml") == 1 then
    return "mise"
  else
    return "generic"
  end
end

-- ===== VISUAL ENHANCEMENTS =====
-- Add custom highlights for better visual separation
M.setup_highlights = function()
  vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = "#7aa2f7", bold = true })
  vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = "#9ece6a" })
  vim.api.nvim_set_hl(0, "WhichKeySeperator", { fg = "#565f89" })
  vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "#1a1b26", blend = 10 })
end

-- ===== PERFORMANCE OPTIMIZATIONS =====
-- Cache frequently used functions
local cached_project_type = nil
local function get_cached_project_type()
  if not cached_project_type then
    cached_project_type = M.detect_project_type()
  end
  return cached_project_type
end

-- Invalidate cache when changing directories
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    cached_project_type = nil
  end,
})

return M