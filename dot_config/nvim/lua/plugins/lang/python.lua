-- lua/plugins/python.lua (Updated with <leader>py* keymaps)
return {
	-- Python environment management
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		ft = "python",
		keys = {
			{ "<leader>pye", "<cmd>VenvSelect<cr>", desc = "Select Python environment" },
		},
		opts = {
			name = { "venv", ".venv", "env", ".env" },
			auto_refresh = true,
		},
	},

	-- Python REPL
	{
		"Vigemus/iron.nvim",
		ft = "python",
		keys = {
			{
				"<leader>pyR",
				function()
					require("iron.core").repl_for(vim.bo.filetype)
				end,
				desc = "Start Python REPL",
			},
			{
				"<leader>pys",
				function()
					require("iron.core").send_line()
				end,
				desc = "Send line to REPL",
			},
			{
				"<leader>pyS",
				function()
					require("iron.core").send_file()
				end,
				desc = "Send file to REPL",
			},
			{
				"<leader>pym",
				function()
					require("iron.core").send_mark()
				end,
				desc = "Send marked text to REPL",
			},
		},
		config = function()
			local iron = require("iron.core")
			iron.setup({
				config = {
					scratch_repl = true,
					repl_definition = {
						python = {
							command = { "uv", "run", "python" }, -- Use UV to run Python
							format = require("iron.fts.common").bracketed_paste,
						},
					},
					repl_open_cmd = require("iron.view").right(50),
				},
				keymaps = {
					send_motion = "<leader>sc",
					visual_send = "<leader>sc",
					send_file = "<leader>sf",
					send_line = "<leader>sl",
					send_mark = "<leader>sm",
					mark_motion = "<leader>mc",
					mark_visual = "<leader>mc",
					remove_mark = "<leader>md",
					cr = "<leader>s<cr>",
					interrupt = "<leader>s<space>",
					exit = "<leader>sq",
					clear = "<leader>cl",
				},
			})
		end,
	},

	-- Python execution and package management
	{
		"nvim-lua/plenary.nvim", -- Dependency for commands
		keys = {
			-- Python execution
			{ "<leader>pyr", "<cmd>!uv run %<CR>", desc = "Run Python file with UV" },
			{ "<leader>pyt", "<cmd>!uv run pytest<CR>", desc = "Run tests with UV" },

			-- Python package management
			{ "<leader>pyi", "<cmd>!uv add ", desc = "Install package with UV" },
			{ "<leader>pyn", "<cmd>!uv sync<CR>", desc = "Sync dependencies with UV" },
			{ "<leader>pyv", "<cmd>!uv venv<CR>", desc = "Create virtual environment" },

			-- Python code quality
			{ "<leader>pyc", "<cmd>!uv run ruff check .<CR>", desc = "Check code with Ruff" },
			{ "<leader>pyf", "<cmd>!uv run ruff format .<CR>", desc = "Format code with Ruff" },
		},
	},

	-- Python docstring generation
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cg",
				function()
					require("neogen").generate()
				end,
				desc = "Generate docstring",
			},
		},
		opts = {
			snippet_engine = "luasnip",
			languages = {
				python = {
					template = {
						annotation_convention = "google_docstrings",
					},
				},
			},
		},
	},
}
