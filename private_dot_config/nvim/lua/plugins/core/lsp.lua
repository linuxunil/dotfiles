-- lua/plugins/lsp.lua (Enhanced with schemastore)
return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				PATH = "append",
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls", -- Go
					"golangci-lint", -- Go Linter
					"delve", -- Go Debugger
					"html", -- HTML
					"sqlls", -- SQL
					"lua_ls", -- Lua
					"zls", -- Zig Language Server
					"pyright", -- Python
					"ruff", -- Python linter/formatter
					"elixir-ls", -- Elixir
					"ts_ls", -- TypeScript/JavaScript
					"jsonls", -- JSON
					"yamlls", -- YAML
					"dockerls", -- Dockerfile
					"taplo", -- TOML
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
			"b0o/schemastore.nvim", -- ✅ ADD: JSON/YAML schema support
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Common LSP settings
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Disable semantic tokens for better performance
				client.server_capabilities.semanticTokensProvider = nil
			end

			-- ===== SIMPLIFIED SERVER CONFIGURATIONS =====
			local servers = {
				-- Go
				gopls = {
					settings = {
						gopls = {
							analyses = { unusedparams = true, unusedwrite = true },
							staticcheck = true,
							usePlaceholders = true,
							completeUnimported = true,
							gofumpt = true,
						},
					},
				},

				-- Lua
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = { vim.env.VIMRUNTIME, "${3rd}/luv/library", "${3rd}/busted/library" },
							},
							completion = { callSnippet = "Replace" },
							diagnostics = { globals = { "vim" } },
							telemetry = { enable = false },
						},
					},
				},

				-- Zig
				zls = {
					settings = {
						zls = {
							enable_snippets = true,
							enable_ast_check_diagnostics = true,
							enable_autofix = true,
							warn_style = true,
						},
					},
				},

				-- Python
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							},
						},
					},
				},

				-- Python linting/formatting
				ruff = {},

				-- Web technologies
				html = {},
				ts_ls = {},

				-- ===== JSON with SCHEMASTORE (MAJOR IMPROVEMENT) =====
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				-- ===== YAML with SCHEMASTORE (MAJOR IMPROVEMENT) =====
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false, -- Disable built-in store
								url = "",
							},
							schemas = require("schemastore").yaml.schemas({
								-- Add commonly used schemas
								select = {
									"GitHub Workflow",
									"GitHub Action",
									"docker-compose.yml",
									"Chart.yaml",
									"dependabot.yml",
									"GitLab CI",
									".travis.yml",
									"codecov.yml",
									"CircleCI config.yml",
									".pre-commit-config.yaml",
									"Kubernetes",
								},
							}),
						},
					},
				},

				-- Infrastructure
				dockerls = {},
				sqlls = {},
				taplo = {}, -- TOML
			}

			-- Setup servers
			for server, config in pairs(servers) do
				config.capabilities = capabilities
				config.on_attach = on_attach
				lspconfig[server].setup(config)
			end

			-- ===== SIMPLIFIED DIAGNOSTICS =====
			vim.diagnostic.config({
				virtual_text = { prefix = "●", source = "if_many" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "always" },
			})

			-- Custom diagnostic signs
			local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "󰋽" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
