-- lua/custom/keymaps.lua
-- Project-specific keymaps (works with any project using mise/make/git/sql)
--
-- Philosophy: 
-- - Each tool does ONE thing well (Unix philosophy)
-- - Tools are orthogonal and replaceable (Pragmatic Programmer)
-- - Plain text configuration (Unix philosophy)
-- - Compose tools, don't build monoliths (both philosophies)
--
-- External tools used:
-- - lazygit: Terminal UI for git (install: brew install lazygit)
-- - lazysql: Terminal UI for SQL (install: go install github.com/jorgerojas26/lazysql@latest)
-- - zellij: Terminal multiplexer (you already have this)

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ===== BETTER DEFAULTS =====
-- Better up/down (works with wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better escape (for ghostty compatibility)
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "kj", "<Esc>", { desc = "Exit insert mode" })

-- Clear search highlighting with Esc
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Better indenting (stays in visual mode)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better paste (doesn't overwrite register)
map("v", "p", '"_dP', opts)

-- ===== INSTANT ACCESS (TIER 1) =====
-- Most frequent operations - single key after leader
map("n", "<leader>w", "<cmd>w<CR>", { desc = "💾 Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "🚪 Quit" })
map("n", "<leader>Q", "<cmd>qa<CR>", { desc = "🚪 Quit all" })
map("n", "<leader>e", "<cmd>lua require('mini.files').open()<CR>", { desc = "📁 File explorer" })
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "✨ Format buffer" })

-- Undo tree (requires undotree plugin)
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })

-- ===== WINDOW MANAGEMENT =====
-- Since you're using zellij, these are less important but still useful
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows (useful even with zellij for nvim splits)
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ===== CORE OPERATIONS (TIER 2) =====
-- Logical groupings with mnemonic letters

-- [F]ile operations
map("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", { desc = "📂 Browse files" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "🔍 Find files" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "🕐 Recent files" })
map("n", "<leader>fs", "<cmd>w<CR>", { desc = "💾 Save file" })
map("n", "<leader>fq", "<cmd>q<CR>", { desc = "🚪 Quit file" })
map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "📄 New file" })
map("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { desc = "⚡ Make executable" })

-- [B]uffer operations
map("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "📋 Buffer list" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "❌ Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "➡️ Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "⬅️ Previous buffer" })
map("n", "<leader>ba", "<cmd>bufdo bd<CR>", { desc = "🗑️ Delete all buffers" })
map("n", "<leader>bw", "<cmd>w<CR>", { desc = "💾 Save buffer" })
map("n", "<leader>br", "<cmd>e!<CR>", { desc = "🔄 Reload buffer" })

-- Keep existing navigation for muscle memory
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "⬅️ Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "➡️ Next buffer" })

-- [P]roject operations
map("n", "<leader>pf", "<cmd>Telescope find_files<CR>", { desc = "🔍 Find project files" })
map("n", "<leader>pr", "<cmd>Telescope find_files cwd=~<CR>", { desc = "🏠 Find from home" })
map("n", "<leader>pt", "<cmd>TodoTelescope<CR>", { desc = "📋 Project todos" })
map("n", "<leader>pg", "<cmd>Telescope git_files<CR>", { desc = "🔍 Git project files" })
map("n", "<leader>pb", "<cmd>!mise build<CR>", { desc = "🔨 Build project" })
map("n", "<leader>pc", "<cmd>!mise check<CR>", { desc = "✅ Check project" })
map("n", "<leader>ps", "<cmd>!mise test<CR>", { desc = "🧪 Test project" })
map("n", "<leader>pw", "<cmd>!mise watch test<CR>", { desc = "👁️ Watch tests" })

-- [M]ise/Make operations (keep existing for compatibility)
map("n", "<leader>mt", "<cmd>!mise test<CR>", { desc = "🧪 Run tests" })
map("n", "<leader>mc", "<cmd>!mise check<CR>", { desc = "✅ Run checks/lints" })
map("n", "<leader>mb", "<cmd>!mise build<CR>", { desc = "🔨 Build project" })
map("n", "<leader>mr", "<cmd>!mise run<CR>", { desc = "🚀 Run task" })
map("n", "<leader>mw", "<cmd>!mise watch test<CR>", { desc = "👁️ Watch tests" })

-- Project file navigation (common patterns)
map("n", "<leader>pa", function()
  -- Find architecture/design docs
  local files = {"docs/ARCHITECTURE.md", "ARCHITECTURE.md", "docs/design.md", "DESIGN.md"}
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      vim.cmd("e " .. file)
      return
    end
  end
  print("No architecture doc found")
end, { desc = "Open architecture doc" })

map("n", "<leader>pt", function()
  -- Find TODO/project tracking files
  local files = {"docs/PROJECT_TRACKER.org", "TODO.md", "TODO.org", "TASKS.md"}
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      vim.cmd("e " .. file)
      return
    end
  end
  print("No project tracker found")
end, { desc = "Open project tracker" })

map("n", "<leader>ps", function()
  -- Find database schema
  local files = {"sql/schema.sql", "db/schema.sql", "schema.sql", "migrations/schema.sql"}
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      vim.cmd("e " .. file)
      return
    end
  end
  print("No schema file found")
end, { desc = "Open database schema" })

map("n", "<leader>pm", function()
  -- Find project config (mise, make, package.json, etc.)
  local files = {".mise.toml", "Makefile", "package.json", "Cargo.toml", "go.mod"}
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      vim.cmd("e " .. file)
      return
    end
  end
  print("No project config found")
end, { desc = "Open project config" })

map("n", "<leader>pr", "<cmd>e README.md<CR>", { desc = "Open README" })

-- Common project directory navigation
map("n", "<leader>pc", function()
  -- Common source directories
  local dirs = {"cmd/", "src/cmd/", "app/", "src/"}
  for _, dir in ipairs(dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      require('telescope.builtin').find_files({ cwd = dir })
      return
    end
  end
  print("No command/app directory found")
end, { desc = "Find in command/app directory" })

map("n", "<leader>pp", function()
  -- Common package/library directories
  local dirs = {"pkg/", "lib/", "src/lib/", "internal/"}
  for _, dir in ipairs(dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      require('telescope.builtin').find_files({ cwd = dir })
      return
    end
  end
  print("No package/lib directory found")
end, { desc = "Find in package/lib directory" })

-- [G]it operations
map("n", "<leader>gg", "<cmd>!zellij run -f -- lazygit<CR>", { desc = "🦉 Git status (LazyGit)" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "👤 Git blame line" })
map("n", "<leader>gd", "<cmd>Gitsigns preview_hunk<CR>", { desc = "👁️ Git diff hunk" })
map("n", "<leader>gl", "<cmd>Telescope git_commits<CR>", { desc = "📜 Git log" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "➕ Stage hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "↩️ Reset hunk" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "⏪ Undo stage hunk" })
map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "➕ Stage buffer" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "↩️ Reset buffer" })
map("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "🔍 Git files" })
map("n", "<leader>gc", "<cmd>Telescope git_bcommits<CR>", { desc = "📋 Buffer commits" })

-- Git navigation (keep existing)
map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "⬇️ Next git hunk" })
map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "⬆️ Previous git hunk" })

-- [H]elp & Documentation operations
map("n", "<leader>hh", "<cmd>Telescope help_tags<CR>", { desc = "📚 Search help" })
map("n", "<leader>hk", "<cmd>Telescope keymaps<CR>", { desc = "🎹 Search keymaps" })
map("n", "<leader>hc", "<cmd>Telescope commands<CR>", { desc = "⚡ Search commands" })
map("n", "<leader>ho", "<cmd>Telescope vim_options<CR>", { desc = "⚙️ Search options" })
map("n", "<leader>hl", "<cmd>Telescope highlights<CR>", { desc = "🎨 Search highlights" })
map("n", "<leader>hm", "<cmd>messages<CR>", { desc = "📜 Show messages" })
map("n", "<leader>hn", "<cmd>Telescope notify<CR>", { desc = "🔔 Show notifications" })
map("n", "<leader>hr", "<cmd>checkhealth<CR>", { desc = "🏥 Run health check" })

-- [T]oggle operations
map("n", "<leader>tn", "<cmd>set number!<CR>", { desc = "🔢 Toggle line numbers" })
map("n", "<leader>tr", "<cmd>set relativenumber!<CR>", { desc = "🔢 Toggle relative numbers" })
map("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "↩️ Toggle line wrap" })
map("n", "<leader>ts", "<cmd>set spell!<CR>", { desc = "📝 Toggle spell check" })
map("n", "<leader>th", "<cmd>set hlsearch!<CR>", { desc = "🔍 Toggle search highlight" })
map("n", "<leader>tc", "<cmd>set cursorline!<CR>", { desc = "➖ Toggle cursor line" })
map("n", "<leader>tl", "<cmd>set list!<CR>", { desc = "👁️ Toggle list chars" })
map("n", "<leader>td", "<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<CR>", { desc = "🔍 Toggle diagnostics" })
map("n", "<leader>tf", "<cmd>lua vim.g.disable_autoformat = not vim.g.disable_autoformat<CR>", { desc = "✨ Toggle auto-format" })
map("n", "<leader>tt", "<cmd>split | terminal<CR>", { desc = "💻 Toggle terminal" })

-- [L]ist operations (diagnostics, quickfix, etc.)
map("n", "<leader>ld", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "📋 List diagnostics" })
map("n", "<leader>lq", "<cmd>copen<CR>", { desc = "📋 Open quickfix" })
map("n", "<leader>ll", "<cmd>lopen<CR>", { desc = "📋 Open location list" })
map("n", "<leader>lt", "<cmd>TodoTelescope<CR>", { desc = "📋 List todos" })

-- Diagnostic navigation (keep existing)
map("n", "[d", vim.diagnostic.goto_prev, { desc = "⬆️ Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "⬇️ Next diagnostic" })
-- Moved to <leader>cd (code diagnostics) to free up <leader>e for file explorer

-- ===== QUICKFIX/LOCATION LIST =====
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[l", "<cmd>lprev<CR>", { desc = "Previous location" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location" })

-- ===== TERMINAL =====
-- Better terminal escape (works well with ghostty)
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Open terminal in split
map("n", "<leader>tt", "<cmd>split | terminal<CR>", { desc = "Terminal in split" })
map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Terminal in vsplit" })

-- [D]atabase operations
map("n", "<leader>db", "<cmd>!zellij run -f -- lazysql<CR>", { desc = "🗄️ Database manager (LazySQL)" })
map("n", "<leader>ds", function()
  local dbs = {"*.db", "*.sqlite", "*.sqlite3", "database.db", "dev.db", "app.db"}
  for _, pattern in ipairs(dbs) do
    local files = vim.fn.glob(pattern, false, true)
    if #files > 0 then
      vim.cmd("!echo '.schema' | sqlite3 " .. files[1] .. " | less")
      return
    end
  end
  print("No SQLite database found")
end, { desc = "📋 Show database schema" })
map("n", "<leader>dc", "<cmd>!sqlite3<CR>", { desc = "💻 SQLite console" })
map("n", "<leader>dd", "<cmd>!pg_dump<CR>", { desc = "📦 Database dump" })

-- Quick database schema view (tries common database files)
map("n", "<leader>ds", function()
  local dbs = {"*.db", "*.sqlite", "*.sqlite3", "database.db", "dev.db", "app.db"}
  for _, pattern in ipairs(dbs) do
    local files = vim.fn.glob(pattern, false, true)
    if #files > 0 then
      vim.cmd("!echo '.schema' | sqlite3 " .. files[1] .. " | less")
      return
    end
  end
  print("No SQLite database found")
end, { desc = "Show database schema" })

-- [C]ode operations
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "⚡ Code actions" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "🔍 Show diagnostics" })
map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, { desc = "✨ Format code" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "📝 Rename symbol" })
map("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "🔍 Go to implementation" })
map("n", "<leader>ct", vim.lsp.buf.type_definition, { desc = "🔍 Go to type definition" })
map("n", "<leader>ch", vim.lsp.buf.hover, { desc = "📖 Show hover info" })
map("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "✍️ Signature help" })
map("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "📍 Go to declaration" })
map("n", "<leader>cR", vim.lsp.buf.references, { desc = "🔗 Show references" })

-- [S]earch operations
map("n", "<leader>ss", "<cmd>Telescope live_grep<CR>", { desc = "🔍 Search in files" })
map("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "🔍 Search word under cursor" })
map("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "🔍 Search files" })
map("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "🔍 Search buffers" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "🔍 Search help" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "🔍 Search keymaps" })
map("n", "<leader>sc", "<cmd>Telescope commands<CR>", { desc = "🔍 Search commands" })
map("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "🔍 Search diagnostics" })
map("n", "<leader>sr", "<cmd>Telescope resume<CR>", { desc = "🔍 Resume last search" })
map("n", "<leader>s.", "<cmd>Telescope oldfiles<CR>", { desc = "🔍 Search recent files" })
map("n", "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "🔍 Search in current buffer" })

-- Search and replace
map("n", "<leader>s*", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "🔄 Replace word under cursor" })
map("n", "<leader>sr", [[:%s//g<Left><Left>]], { desc = "🔄 Search and replace" })

-- [Y]ank/[P]aste operations (system clipboard)
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "📋 Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "📋 Yank line to system clipboard" })
map({ "n", "v" }, "<leader>p", [["+p]], { desc = "📋 Paste from system clipboard" })
map({ "n", "v" }, "<leader>P", [["+P]], { desc = "📋 Paste before from system clipboard" })

-- [W]indow operations
map("n", "<leader>wh", "<C-w>h", { desc = "⬅️ Move to left window" })
map("n", "<leader>wj", "<C-w>j", { desc = "⬇️ Move to lower window" })
map("n", "<leader>wk", "<C-w>k", { desc = "⬆️ Move to upper window" })
map("n", "<leader>wl", "<C-w>l", { desc = "➡️ Move to right window" })
map("n", "<leader>ws", "<C-w>s", { desc = "➖ Split horizontal" })
map("n", "<leader>wv", "<C-w>v", { desc = "➗ Split vertical" })
map("n", "<leader>wq", "<C-w>q", { desc = "❌ Close window" })
map("n", "<leader>wo", "<C-w>o", { desc = "📏 Only window" })
map("n", "<leader>w=", "<C-w>=", { desc = "⚖️ Balance windows" })
map("n", "<leader>w+", "<C-w>+", { desc = "⬆️ Increase height" })
map("n", "<leader>w-", "<C-w>-", { desc = "⬇️ Decrease height" })
map("n", "<leader>w<", "<C-w><", { desc = "⬅️ Decrease width" })
map("n", "<leader>w>", "<C-w>>", { desc = "➡️ Increase width" })

-- ===== PHILOSOPHY NOTES =====
-- This configuration embraces:
-- 1. Unix Philosophy: Each external tool (lazygit, lazysql, mise) does ONE thing well
-- 2. Pragmatic Programmer: Tools are orthogonal and easily replaceable
-- 3. Plain Text: All config and data in text formats (SQL, Git, Markdown)
-- 4. Composition: Small tools working together via zellij/terminal
-- 5. No Lock-in: Can replace any tool without changing the workflow
