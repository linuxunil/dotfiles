-- lua/custom/keymaps.lua
-- Essential keymaps only - optimized for muscle memory

local map = vim.keymap.set

-- ===== BETTER DEFAULTS =====
-- Better up/down (works with wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Clear search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

-- Better indenting (stays in visual mode)
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

-- ===== CORE WORKFLOW (FREQUENCY OPTIMIZED) =====
-- Most frequent operations get the easiest keys
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File manager" })

-- ===== HARPOON (INTUITIVE NUMBERS) =====
map("n", "<leader>a", function() require('harpoon'):list():add() end, { desc = "Add to harpoon" })
map("n", "<leader>h", function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, { desc = "Harpoon menu" })
map("n", "<leader>1", function() require('harpoon'):list():select(1) end, { desc = "Harpoon 1" })
map("n", "<leader>2", function() require('harpoon'):list():select(2) end, { desc = "Harpoon 2" })
map("n", "<leader>3", function() require('harpoon'):list():select(3) end, { desc = "Harpoon 3" })
map("n", "<leader>4", function() require('harpoon'):list():select(4) end, { desc = "Harpoon 4" })

-- ===== EXTERNAL TOOLS (DOUBLE LETTERS) =====
map("n", "<leader>gg", "<cmd>!lazygit<cr>", { desc = "Git" })
map("n", "<leader>tt", "<cmd>!mise test<cr>", { desc = "Test" })

-- ===== CODE ACTIONS (MINIMAL) =====
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>=", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format" })

-- ===== UTILITIES =====
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo tree" })

-- ===== VIM DEFAULTS (LEVERAGE EXISTING MUSCLE MEMORY) =====
-- These are already built-in, just documenting for completeness:
-- s - Flash motion (via plugin)
-- gd, gr, K - LSP navigation (built-in)
-- [d, ]d - Diagnostics navigation (built-in)
-- :w, :q - Save/quit (never override)
