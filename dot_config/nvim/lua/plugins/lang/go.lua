-- lua/plugins/go.lua (Drastically Simplified)
return {
	-- Primary Go language support
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = { "go", "gomod", "gowork", "gotmpl" },
		-- build = ':lua require("go.install").update_all_sync()',
		event = { "CmdlineEnter" },
		config = function()
			require("go").setup({
				gofmt = "gofumpt",
			})
		end,
	},

	-- Go debugging support (simplified)
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{
				"<leader>dgt",
				function()
					require("dap-go").debug_test()
				end,
				desc = "Debug Go test",
				ft = "go",
			},
			{
				"<leader>dgl",
				function()
					require("dap-go").debug_last()
				end,
				desc = "Debug last Go test",
				ft = "go",
			},
			{
				"<leader>dgr",
				function()
					require("dap-go").debug_restart()
				end,
				desc = "Debug restart",
				ft = "go",
			},
		},
		opts = {
			-- Use defaults - they work great!
			-- Removed 50+ lines of manual configuration
		},
	},
}
