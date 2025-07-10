-- lua/custom/which-key-keymaps.lua
-- Structured keybindings using which-key v3 API
-- This file demonstrates how to use the new add() method for better organization

local M = {}

-- Load this after which-key is loaded
M.setup = function()
  local wk = require("which-key")
  
  -- Add structured keybindings using the new v3 API
  wk.add({
    -- ===== INSTANT ACCESS (TIER 1) =====
    { "<leader>w", "<cmd>w<CR>", desc = "💾 Save file" },
    { "<leader>q", "<cmd>q<CR>", desc = "🚪 Quit" },
    { "<leader>Q", "<cmd>qa<CR>", desc = "🚪 Quit all" },
    { "<leader>e", "<cmd>lua require('mini.files').open()<CR>", desc = "📁 File explorer" },
    { "<leader>f", function() vim.lsp.buf.format({ async = true }) end, desc = "✨ Format buffer" },
    
    -- ===== FILE OPERATIONS =====
    { "<leader>f", group = "📁 [F]ile" },
    { "<leader>fb", "<cmd>Telescope file_browser<CR>", desc = "📂 Browse files" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "🔍 Find files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "🕐 Recent files" },
    { "<leader>fs", "<cmd>w<CR>", desc = "💾 Save file" },
    { "<leader>fq", "<cmd>q<CR>", desc = "🚪 Quit file" },
    { "<leader>fn", "<cmd>enew<CR>", desc = "📄 New file" },
    { "<leader>fx", "<cmd>!chmod +x %<CR>", desc = "⚡ Make executable" },
    
    -- ===== BUFFER OPERATIONS =====
    { "<leader>b", group = "📋 [B]uffer" },
    { "<leader>bb", "<cmd>Telescope buffers<CR>", desc = "📋 Buffer list" },
    { "<leader>bd", "<cmd>bdelete<CR>", desc = "❌ Delete buffer" },
    { "<leader>bn", "<cmd>bnext<CR>", desc = "➡️ Next buffer" },
    { "<leader>bp", "<cmd>bprevious<CR>", desc = "⬅️ Previous buffer" },
    { "<leader>ba", "<cmd>bufdo bd<CR>", desc = "🗑️ Delete all buffers" },
    { "<leader>bw", "<cmd>w<CR>", desc = "💾 Save buffer" },
    { "<leader>br", "<cmd>e!<CR>", desc = "🔄 Reload buffer" },
    
    -- ===== GIT OPERATIONS =====
    { "<leader>g", group = "🔄 [G]it" },
    { "<leader>gg", "<cmd>!zellij run -f -- lazygit<CR>", desc = "🦉 Git status (LazyGit)" },
    { "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc = "👤 Git blame line" },
    { "<leader>gd", "<cmd>Gitsigns preview_hunk<CR>", desc = "👁️ Git diff hunk" },
    { "<leader>gl", "<cmd>Telescope git_commits<CR>", desc = "📜 Git log" },
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", desc = "➕ Stage hunk" },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "↩️ Reset hunk" },
    { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "⏪ Undo stage hunk" },
    { "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", desc = "➕ Stage buffer" },
    { "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", desc = "↩️ Reset buffer" },
    { "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "🔍 Git files" },
    { "<leader>gc", "<cmd>Telescope git_bcommits<CR>", desc = "📋 Buffer commits" },
    
    -- ===== CODE OPERATIONS =====
    { "<leader>c", group = "⚡ [C]ode" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "⚡ Code actions" },
    { "<leader>cd", vim.diagnostic.open_float, desc = "🔍 Show diagnostics" },
    { "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, desc = "✨ Format code" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "📝 Rename symbol" },
    { "<leader>ci", vim.lsp.buf.implementation, desc = "🔍 Go to implementation" },
    { "<leader>ct", vim.lsp.buf.type_definition, desc = "🔍 Go to type definition" },
    { "<leader>ch", vim.lsp.buf.hover, desc = "📖 Show hover info" },
    { "<leader>cs", vim.lsp.buf.signature_help, desc = "✍️ Signature help" },
    { "<leader>cD", vim.lsp.buf.declaration, desc = "📍 Go to declaration" },
    { "<leader>cR", vim.lsp.buf.references, desc = "🔗 Show references" },
    
    -- ===== SEARCH OPERATIONS =====
    { "<leader>s", group = "🔍 [S]earch" },
    { "<leader>ss", "<cmd>Telescope live_grep<CR>", desc = "🔍 Search in files" },
    { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "🔍 Search word under cursor" },
    { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "🔍 Search files" },
    { "<leader>sb", "<cmd>Telescope buffers<CR>", desc = "🔍 Search buffers" },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "🔍 Search help" },
    { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "🔍 Search keymaps" },
    { "<leader>sc", "<cmd>Telescope commands<CR>", desc = "🔍 Search commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics<CR>", desc = "🔍 Search diagnostics" },
    { "<leader>sr", "<cmd>Telescope resume<CR>", desc = "🔍 Resume last search" },
    { "<leader>s.", "<cmd>Telescope oldfiles<CR>", desc = "🔍 Search recent files" },
    { "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "🔍 Search in current buffer" },
    
    -- ===== PROJECT OPERATIONS =====
    { "<leader>p", group = "📁 [P]roject" },
    { "<leader>pf", "<cmd>Telescope find_files<CR>", desc = "🔍 Find project files" },
    { "<leader>pr", "<cmd>Telescope find_files cwd=~<CR>", desc = "🏠 Find from home" },
    { "<leader>pt", "<cmd>TodoTelescope<CR>", desc = "📋 Project todos" },
    { "<leader>pg", "<cmd>Telescope git_files<CR>", desc = "🔍 Git project files" },
    { "<leader>pb", "<cmd>!mise build<CR>", desc = "🔨 Build project" },
    { "<leader>pc", "<cmd>!mise check<CR>", desc = "✅ Check project" },
    { "<leader>ps", "<cmd>!mise test<CR>", desc = "🧪 Test project" },
    { "<leader>pw", "<cmd>!mise watch test<CR>", desc = "👁️ Watch tests" },
    
    -- ===== TOGGLE OPERATIONS =====
    { "<leader>t", group = "🔄 [T]oggle" },
    { "<leader>tn", "<cmd>set number!<CR>", desc = "🔢 Toggle line numbers" },
    { "<leader>tr", "<cmd>set relativenumber!<CR>", desc = "🔢 Toggle relative numbers" },
    { "<leader>tw", "<cmd>set wrap!<CR>", desc = "↩️ Toggle line wrap" },
    { "<leader>ts", "<cmd>set spell!<CR>", desc = "📝 Toggle spell check" },
    { "<leader>th", "<cmd>set hlsearch!<CR>", desc = "🔍 Toggle search highlight" },
    { "<leader>tc", "<cmd>set cursorline!<CR>", desc = "➖ Toggle cursor line" },
    { "<leader>tl", "<cmd>set list!<CR>", desc = "👁️ Toggle list chars" },
    { "<leader>td", "<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<CR>", desc = "🔍 Toggle diagnostics" },
    { "<leader>tf", "<cmd>lua vim.g.disable_autoformat = not vim.g.disable_autoformat<CR>", desc = "✨ Toggle auto-format" },
    { "<leader>tt", "<cmd>split | terminal<CR>", desc = "💻 Toggle terminal" },
    
    -- ===== WINDOW OPERATIONS =====
    { "<leader>w", group = "🪟 [W]indow" },
    { "<leader>wh", "<C-w>h", desc = "⬅️ Move to left window" },
    { "<leader>wj", "<C-w>j", desc = "⬇️ Move to lower window" },
    { "<leader>wk", "<C-w>k", desc = "⬆️ Move to upper window" },
    { "<leader>wl", "<C-w>l", desc = "➡️ Move to right window" },
    { "<leader>ws", "<C-w>s", desc = "➖ Split horizontal" },
    { "<leader>wv", "<C-w>v", desc = "➗ Split vertical" },
    { "<leader>wq", "<C-w>q", desc = "❌ Close window" },
    { "<leader>wo", "<C-w>o", desc = "📏 Only window" },
    { "<leader>w=", "<C-w>=", desc = "⚖️ Balance windows" },
    { "<leader>w+", "<C-w>+", desc = "⬆️ Increase height" },
    { "<leader>w-", "<C-w>-", desc = "⬇️ Decrease height" },
    { "<leader>w<", "<C-w><", desc = "⬅️ Decrease width" },
    { "<leader>w>", "<C-w>>", desc = "➡️ Increase width" },
    
    -- ===== DATABASE OPERATIONS =====
    { "<leader>d", group = "🗃️ [D]atabase" },
    { "<leader>db", "<cmd>!zellij run -f -- lazysql<CR>", desc = "🗄️ Database manager (LazySQL)" },
    { "<leader>ds", function()
      local dbs = {"*.db", "*.sqlite", "*.sqlite3", "database.db", "dev.db", "app.db"}
      for _, pattern in ipairs(dbs) do
        local files = vim.fn.glob(pattern, false, true)
        if #files > 0 then
          vim.cmd("!echo '.schema' | sqlite3 " .. files[1] .. " | less")
          return
        end
      end
      print("No SQLite database found")
    end, desc = "📋 Show database schema" },
    { "<leader>dc", "<cmd>!sqlite3<CR>", desc = "💻 SQLite console" },
    { "<leader>dd", "<cmd>!pg_dump<CR>", desc = "📦 Database dump" },
    
    -- ===== LIST OPERATIONS =====
    { "<leader>l", group = "📋 [L]ist" },
    { "<leader>ld", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "📋 List diagnostics" },
    { "<leader>lq", "<cmd>copen<CR>", desc = "📋 Open quickfix" },
    { "<leader>ll", "<cmd>lopen<CR>", desc = "📋 Open location list" },
    { "<leader>lt", "<cmd>TodoTelescope<CR>", desc = "📋 List todos" },
    
    -- ===== YANK/PASTE OPERATIONS =====
    { "<leader>y", group = "📋 [Y]ank" },
    { "<leader>y", '"+y', desc = "📋 Yank to system clipboard", mode = { "n", "v" } },
    { "<leader>Y", '"+Y', desc = "📋 Yank line to system clipboard" },
    { "<leader>p", '"+p', desc = "📋 Paste from system clipboard", mode = { "n", "v" } },
    { "<leader>P", '"+P', desc = "📋 Paste before from system clipboard", mode = { "n", "v" } },
    
    -- ===== LEGACY COMPATIBILITY =====
    { "<leader>m", group = "🔧 [M]ise" },
    { "<leader>mt", "<cmd>!mise test<CR>", desc = "🧪 Run tests" },
    { "<leader>mc", "<cmd>!mise check<CR>", desc = "✅ Run checks/lints" },
    { "<leader>mb", "<cmd>!mise build<CR>", desc = "🔨 Build project" },
    { "<leader>mr", "<cmd>!mise run<CR>", desc = "🚀 Run task" },
    { "<leader>mw", "<cmd>!mise watch test<CR>", desc = "👁️ Watch tests" },
    
    -- ===== HELP & DOCUMENTATION =====
    { "<leader>h", group = "📚 [H]elp & Documentation" },
    { "<leader>hh", "<cmd>Telescope help_tags<CR>", desc = "📚 Search help" },
    { "<leader>hk", "<cmd>Telescope keymaps<CR>", desc = "🎹 Search keymaps" },
    { "<leader>hc", "<cmd>Telescope commands<CR>", desc = "⚡ Search commands" },
    { "<leader>ho", "<cmd>Telescope vim_options<CR>", desc = "⚙️ Search options" },
    { "<leader>hl", "<cmd>Telescope highlights<CR>", desc = "🎨 Search highlights" },
    { "<leader>hm", "<cmd>messages<CR>", desc = "📜 Show messages" },
    { "<leader>hn", "<cmd>Telescope notify<CR>", desc = "🔔 Show notifications" },
    { "<leader>hr", "<cmd>checkhealth<CR>", desc = "🏥 Run health check" },
  })
  
  -- Note: Dynamic buffer mappings removed as they conflict with existing buffer mappings
  -- If you want numbered buffer switching, use :b1, :b2, etc. or <leader>bb for buffer list
end

return M