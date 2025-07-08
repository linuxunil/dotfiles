-- lua/plugins/mini.lua (Optimized - removed mini.bufremove, fixed icons loading)
return {
	-- Mini.icons - Load immediately for UI components
	{
		"echasnovski/mini.icons",
		version = false,
		lazy = false, -- Load immediately for UI icons
		priority = 900, -- Load early for other plugins
		opts = {
			style = "glyph",
			extension = {
				go = { glyph = "󰟓", hl = "MiniIconsBlue" },
				zig = { glyph = "⚡", hl = "MiniIconsOrange" },
				py = { glyph = "󰌠", hl = "MiniIconsYellow" },
				js = { glyph = "󰌞", hl = "MiniIconsYellow" },
				ts = { glyph = "󰛦", hl = "MiniIconsBlue" },
				lua = { glyph = "󰢱", hl = "MiniIconsBlue" },
				md = { glyph = "󰍔", hl = "MiniIconsGrey" },
				json = { glyph = "󰘦", hl = "MiniIconsYellow" },
				yaml = { glyph = "󰈙", hl = "MiniIconsOrange" },
				yml = { glyph = "󰈙", hl = "MiniIconsOrange" },
				toml = { glyph = "󰈙", hl = "MiniIconsOrange" },
				dockerfile = { glyph = "󰡨", hl = "MiniIconsBlue" },
			},
			filetype = {
				go = { glyph = "󰟓", hl = "MiniIconsBlue" },
				zig = { glyph = "⚡", hl = "MiniIconsOrange" },
				python = { glyph = "󰌠", hl = "MiniIconsYellow" },
				javascript = { glyph = "󰌞", hl = "MiniIconsYellow" },
				typescript = { glyph = "󰛦", hl = "MiniIconsBlue" },
				lua = { glyph = "󰢱", hl = "MiniIconsBlue" },
				markdown = { glyph = "󰍔", hl = "MiniIconsGrey" },
				json = { glyph = "󰘦", hl = "MiniIconsYellow" },
				yaml = { glyph = "󰈙", hl = "MiniIconsOrange" },
				dockerfile = { glyph = "󰡨", hl = "MiniIconsBlue" },
			},
			file = {
				["go.mod"] = { glyph = "󰟓", hl = "MiniIconsBlue" },
				["go.sum"] = { glyph = "󰟓", hl = "MiniIconsBlue" },
				["build.zig"] = { glyph = "⚡", hl = "MiniIconsOrange" },
				["pyproject.toml"] = { glyph = "󰌠", hl = "MiniIconsYellow" },
				["package.json"] = { glyph = "󰌞", hl = "MiniIconsYellow" },
				["tsconfig.json"] = { glyph = "󰛦", hl = "MiniIconsBlue" },
				[".env"] = { glyph = "󰙩", hl = "MiniIconsYellow" },
				[".gitignore"] = { glyph = "󰊢", hl = "MiniIconsRed" },
				["README.md"] = { glyph = "󰍔", hl = "MiniIconsGrey" },
				["Dockerfile"] = { glyph = "󰡨", hl = "MiniIconsBlue" },
			},
		},
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- Mini.ai - Better text objects
	{
		"echasnovski/mini.ai",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({
				custom_textobjects = {
					o = require("mini.ai").gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			})
		end,
	},

	-- Mini.comment - Smart commenting
	{
		"echasnovski/mini.comment",
		version = false,
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},

	-- Mini.pairs - Auto pairs
	{
		"echasnovski/mini.pairs",
		version = false,
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = false, terminal = false },
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			skip_ts = { "string" },
			skip_unbalanced = true,
			markdown = true,
		},
	},

	-- Mini.surround - Surround text objects
	{
		"echasnovski/mini.surround",
		version = false,
		event = "VeryLazy",
	},

	-- Note: Removed mini.bufremove - now using snacks.nvim bufdelete

	-- Mini.move - Move lines and blocks
	{
		"echasnovski/mini.move",
		version = false,
		event = "VeryLazy",
	},

	-- Mini.sessions - Session management
	{
		"echasnovski/mini.sessions",
		version = false,
		event = "VeryLazy",
	},

	-- Mini.statusline - Minimal and fast statusline
	{
		"echasnovski/mini.statusline",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.statusline").setup()
		end,
	},

	-- Mini.tabline - Modern and clean buffer/tab manager
	{
		"echasnovski/mini.tabline",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.tabline").setup()
		end,
	},
}
