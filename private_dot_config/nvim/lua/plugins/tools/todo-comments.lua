-- lua/plugins/tools/todo-comments.lua - Todo Comment Management
-- Highlights and manages TODO, FIXME, BUG, and other comment types

return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			-- Todo navigation
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},

			-- Todo search and management
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
		opts = {
			signs = true, -- Show icons in the signs column
			sign_priority = 8, -- Sign priority

			-- Todo comment keywords and their configurations
			keywords = {
				-- High priority (errors and fixes)
				FIX = {
					icon = " ", -- Icon used for the sign and search results
					color = "error", -- Can be a hex color or named color
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Alternative keywords that map to FIX
				},

				-- Standard todos
				TODO = {
					icon = " ",
					color = "info",
				},

				-- Warnings and hacks
				HACK = {
					icon = " ",
					color = "warning",
				},
				WARN = {
					icon = " ",
					color = "warning",
					alt = { "WARNING", "XXX" },
				},

				-- Performance and optimization
				PERF = {
					icon = " ",
					alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
				},

				-- Notes and information
				NOTE = {
					icon = " ",
					color = "hint",
					alt = { "INFO" },
				},

				-- Testing
				TEST = {
					icon = "⏲ ",
					color = "test",
					alt = { "TESTING", "PASSED", "FAILED" },
				},
			},

			-- GUI styling
			gui_style = {
				fg = "NONE", -- Foreground style
				bg = "BOLD", -- Background style
			},

			merge_keywords = true, -- Merge custom keywords with defaults

			-- Highlighting configuration
			highlight = {
				multiline = true, -- Enable multiline todo comments
				multiline_pattern = "^.", -- Lua pattern to match multiline continuation
				multiline_context = 10, -- Extra lines of context for multiline comments
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern for highlighting (vim regex)
				comments_only = true, -- Only match keywords in comments
				max_line_len = 400, -- Ignore lines longer than this
				exclude = {}, -- List of file types to exclude
			},

			-- Color configuration
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF006E" },
			},

			-- Search configuration
			search = {
				command = "rg", -- Search command
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				pattern = [[\b(KEYWORDS):]], -- Ripgrep regex pattern for search
			},
		},
		config = function(_, opts)
			require("todo-comments").setup(opts)

			-- Auto-highlight todo comments when file is read or written
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
				pattern = "*",
				callback = function()
					-- Force refresh todo highlights
					if package.loaded["todo-comments"] then
						require("todo-comments").setup(opts)
					end
				end,
			})
		end,
	},
}

--[[
Todo Comments Configuration Philosophy:

1. VISUAL CLARITY: Different colors and icons for different priorities
2. COMPREHENSIVE: Cover all common todo comment types
3. SEARCHABLE: Easy to find and manage todos across the project
4. INTEGRATED: Works with Trouble and Telescope for better workflow

Keyword Priority Levels:
- HIGH (Red): FIX, FIXME, BUG, ISSUE - Critical issues that need immediate attention
- MEDIUM (Yellow): HACK, WARN, WARNING, XXX - Important but not critical
- STANDARD (Blue): TODO, NOTE, INFO - Regular todos and notes
- PERFORMANCE (Purple): PERF, OPTIMIZE, OPTIM - Performance improvements
- TESTING (Pink): TEST, TESTING - Testing related comments

Usage Examples:
-- TODO: Implement user authentication
-- FIXME: Fix memory leak in upload function
-- BUG: Button doesn't respond on mobile
-- HACK: Temporary workaround for API limitation
-- PERF: Consider using a more efficient algorithm
-- NOTE: This function assumes sorted input
-- TEST: Add integration tests for payment processing

Navigation:
- ]t / [t: Jump between todo comments
- <leader>xt: View all todos in Trouble
- <leader>st: Search todos with Telescope
]]
