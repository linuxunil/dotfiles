-- lua/plugins/zig.lua (Updated with <leader>zg* keymaps)
return {
	-- Zig language support
	{
		"ziglang/zig.vim",
		ft = "zig",
		config = function()
			vim.g.zig_fmt_autosave = 1
		end,
	},

	-- Additional Zig tooling
	{
		"NTBBloodbath/zig-tools.nvim",
		ft = "zig",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
		keys = {
			{ "<leader>zgr", "<cmd>ZigRun<cr>", desc = "Run Zig file", ft = "zig" },
			{ "<leader>zgt", "<cmd>ZigTest<cr>", desc = "Test Zig file", ft = "zig" },
			{ "<leader>zgb", "<cmd>ZigBuild<cr>", desc = "Build Zig project", ft = "zig" },
			{ "<leader>zgf", "<cmd>ZigFmt<cr>", desc = "Format Zig file", ft = "zig" },
			{ "<leader>zgc", "<cmd>ZigCheck<cr>", desc = "Check Zig file", ft = "zig" },
			{ "<leader>zgi", "<cmd>ZigInit<cr>", desc = "Initialize Zig project", ft = "zig" },
		},
		opts = {
			integrations = {
				debug = true, -- Enable DAP integration
			},
		},
	},
}
