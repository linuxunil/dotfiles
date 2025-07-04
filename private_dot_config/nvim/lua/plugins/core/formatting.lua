-- lua/plugins/formatting.lua (Simplified)
return {
	{
		"stevearc/conform.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			-- ===== ESSENTIAL FORMATTERS ONLY =====
			formatters_by_ft = {
				-- Core languages
				lua = { "stylua" },
				go = { "goimports", "gofumpt" },
				zig = { "zig" },
				python = { "ruff_format", "ruff_organize_imports" },

				-- Web technologies
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				markdown = { "prettier" },
				yaml = { "prettier" },

				-- Configuration files
				toml = { "taplo" },

				-- Shell scripts
				sh = { "shfmt" },
				bash = { "shfmt" },
			},

			-- Format on save for most files
			format_on_save = function(bufnr)
				-- Disable for certain filetypes that have issues
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return {
					timeout_ms = 1000,
					lsp_fallback = true,
				}
			end,

			-- ===== SIMPLIFIED FORMATTER CONFIGS =====
			formatters = {
				-- Use defaults for most formatters - they work great!
				-- Only customize when absolutely necessary

				shfmt = {
					prepend_args = { "-i", "2", "-ci" }, -- 2 space indent, case indent
				},
			},
		},
	},
}
