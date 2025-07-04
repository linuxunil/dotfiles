-- lua/plugins/tools/snacks.lua (Enhanced with file explorer)
return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			-- ===== CORE FEATURES =====
			bigfile = { enabled = true },
			dashboard = { enabled = false }, -- Using alpha-nvim
			notifier = { enabled = true }, -- Primary notifications
			terminal = { enabled = true }, -- Primary terminal
			lazygit = { enabled = true }, -- Primary git interface
			bufdelete = { enabled = true }, -- Primary buffer management

			-- ===== FILE MANAGEMENT =====
			explorer = {
				enabled = true,
				-- File explorer configuration
				win = {
					position = "left",
					width = 30,
					height = 0.8,
				},
				-- Show hidden files by default
				show_hidden = false,
				-- Auto close when opening a file
				auto_close = false,
				-- Follow current file
				follow_file = true,
				-- Git integration
				git = {
					enabled = true,
					show_status = true,
				},
				-- File operations
				actions = {
					files = {
						copy = "c",
						cut = "x",
						paste = "p",
						delete = "d",
						rename = "r",
						create_file = "f",
						create_dir = "F",
					},
					navigation = {
						close = "q",
						refresh = "R",
						parent = "h",
						enter = "l",
						toggle_hidden = ".",
						toggle_git_ignore = "i",
					},
				},
			},

			-- ===== ADDITIONAL FEATURES =====
			indent = { enabled = true },
			input = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			git = { enabled = true },

			-- ===== STYLES =====
			styles = {
				notification = {
					wo = { wrap = true },
				},
				terminal = {
					bo = { filetype = "snacks_terminal" },
				},
				explorer = {
					backdrop = false,
					border = "rounded",
					title = " Explorer ",
					title_pos = "center",
					wo = {
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
						winblend = 0,
					},
				},
			},
		},
		keys = {
			-- ===== FILE EXPLORER =====
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			{
				"<leader>E",
				function()
					Snacks.explorer({ cwd = vim.uv.cwd() })
				end,
				desc = "File Explorer (cwd)",
			},

			-- ===== NOTIFICATIONS =====
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},

			-- ===== BUFFER MANAGEMENT =====
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					Snacks.bufdelete({ force = true })
				end,
				desc = "Delete Buffer (Force)",
			},

			-- ===== GIT INTEGRATION =====
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gb",
				function()
					Snacks.git.blame_line()
				end,
				desc = "Git Blame Line",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Lazygit Current File History",
			},
			{
				"<leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},

			-- ===== TERMINAL =====
			{
				"<leader>th",
				function()
					Snacks.terminal(nil, { win = { position = "bottom", height = 0.3 } })
				end,
				desc = "Terminal Horizontal",
			},
			{
				"<leader>tv",
				function()
					Snacks.terminal(nil, { win = { position = "right", width = 0.4 } })
				end,
				desc = "Terminal Vertical",
			},
			{
				"<leader>tt",
				function()
					Snacks.terminal()
				end,
				desc = "Terminal Toggle",
			},
			{
				"<c-/>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<c-_>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},

			-- ===== FILE OPERATIONS =====
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},

			-- ===== WORD NAVIGATION =====
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},

			-- ===== UTILITIES =====
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
					})
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup globals
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd

					-- Create toggle commands
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					if vim.lsp.inlay_hint then
						Snacks.toggle.inlay_hints():map("<leader>uh")
					end
				end,
			})
		end,
	},
}
