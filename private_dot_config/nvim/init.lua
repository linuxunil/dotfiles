-- init.lua (Updated with new organization and performance monitoring)

-- Store startup time for performance monitoring
vim.g.start_time = vim.fn.reltime()

-- ===== CORE CONFIGURATION =====
-- Load core settings with error handling
local core_modules = { "core.settings", "core.keymaps", "core.autocmds" }

for _, module in ipairs(core_modules) do
	local ok, err = pcall(require, module)
	if not ok then
		vim.notify(
			string.format("Failed to load %s: %s", module, err),
			vim.log.levels.ERROR,
			{ title = "Configuration Error" }
		)
	end
end

-- ===== PERFORMANCE MONITORING =====
-- Load performance monitoring early
local perf_ok, perf = pcall(require, "utils.performance")
if not perf_ok then
	vim.notify("Performance monitoring not available", vim.log.levels.WARN)
end

-- ===== LAZY.NVIM BOOTSTRAP =====
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local success = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to clone lazy.nvim: " .. success, vim.log.levels.ERROR, { title = "Plugin Manager Error" })
		return
	end
end
vim.opt.rtp:prepend(lazypath)

-- ===== PLUGIN SETUP =====
local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
	vim.notify("Failed to load lazy.nvim", vim.log.levels.ERROR, { title = "Plugin Manager Error" })
	return
end

-- Setup plugins using new organized structure
lazy.setup("plugins", {
	defaults = { lazy = true },

	-- Colorscheme fallbacks
	install = {
		colorscheme = { "catppuccin-frappe", "habamax", "default" },
	},

	-- Auto-update checking
	checker = {
		enabled = true,
		notify = false, -- Don't spam notifications
		frequency = 3600, -- Check once per hour
	},

	-- Performance optimizations
	performance = {
		cache = { enabled = true },
		reset_packpath = true,
		rtp = {
			reset = true,
			paths = {},
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},

	-- UI improvements
	ui = {
		border = "rounded",
		backdrop = 60,
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		icons = {
			cmd = " ",
			config = "",
			event = "📅",
			ft = " ",
			init = " ",
			keys = " ",
			plugin = " ",
			runtime = " ",
			require = "󰢱 ",
			source = " ",
			start = " ",
			task = "✔ ",
			lazy = "󰒲 ",
		},
	},

	-- Development settings
	dev = {
		path = "~/projects",
		patterns = {},
		fallback = false,
	},

	-- Plugin change detection
	change_detection = {
		enabled = true,
		notify = false, -- Don't spam notifications
	},
})

-- ===== MISE INTEGRATION =====
local mise_ok, mise = pcall(require, "utils.mise-integration")
if mise_ok then
	-- Safely setup mise integration
	local setup_ok, setup_err = pcall(function()
		mise.setup_lsp_paths()
		mise.setup_auto_activation()
	end)

	if setup_ok then
		-- Add keybindings only if setup succeeded
		vim.keymap.set("n", "<leader>mi", function()
			mise.show_info()
		end, { desc = "Mise info" })

		vim.keymap.set("n", "<leader>mr", function()
			vim.ui.input({ prompt = "Mise task: " }, function(task)
				if task and task ~= "" then
					mise.run_task(task)
				end
			end)
		end, { desc = "Run mise task" })
	else
		vim.notify("Mise integration setup failed: " .. setup_err, vim.log.levels.WARN, { title = "Mise Integration" })
	end
else
	-- Mise integration is optional - just inform user once
	vim.defer_fn(function()
		vim.notify("Mise integration not available (optional)", vim.log.levels.INFO, { title = "Development Tools" })
	end, 2000) -- Delay to avoid startup spam
end

-- ===== HEALTH CHECKS =====
-- Add some basic health checks after everything loads
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Defer health checks to avoid slowing startup
		vim.defer_fn(function()
			-- Check for required external tools
			local tools = {
				{ cmd = "git", desc = "Git version control" },
				{ cmd = "rg", desc = "Ripgrep for searching" },
				{ cmd = "fd", desc = "Fast file finder" },
			}

			local missing = {}
			local available = {}

			for _, tool in ipairs(tools) do
				if vim.fn.executable(tool.cmd) == 0 then
					table.insert(missing, tool.cmd .. " (" .. tool.desc .. ")")
				else
					table.insert(available, tool.cmd)
				end
			end

			-- Report missing tools
			if #missing > 0 then
				vim.notify(
					"Missing external tools:\n• " .. table.concat(missing, "\n• "),
					vim.log.levels.WARN,
					{ title = "External Dependencies" }
				)
			end

			-- Optional: Report available tools (for debugging)
			if vim.g.verbose_health_check then
				vim.notify(
					"Available tools: " .. table.concat(available, ", "),
					vim.log.levels.INFO,
					{ title = "Health Check" }
				)
			end

			-- Show startup time
			if vim.g.show_startup_message ~= false then
				local startup_time = perf and perf.get_startup_time() or 0
				if startup_time > 0 then
					vim.notify(
						string.format("Neovim ready in %.1fms", startup_time),
						vim.log.levels.INFO,
						{ title = "Startup Complete" }
					)
				end
			end
		end, 1000) -- Wait 1 second after startup
	end,
})

-- ===== DEVELOPMENT HELPERS =====
-- Add some useful development commands
vim.api.nvim_create_user_command("ConfigReload", function()
	-- Reload core configuration
	for name, _ in pairs(package.loaded) do
		if name:match("^settings") or name:match("^keymaps") or name:match("^autocmds") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Configuration reloaded", vim.log.levels.INFO)
end, { desc = "Reload Neovim configuration" })

vim.api.nvim_create_user_command("ConfigEdit", function()
	vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Edit Neovim configuration" })

vim.api.nvim_create_user_command("ConfigDir", function()
	vim.cmd("edit " .. vim.fn.stdpath("config"))
end, { desc = "Open Neovim configuration directory" })

-- ===== FINAL SETUP =====
-- Set up configuration globals for debugging
vim.g.config_loaded = true
vim.g.config_version = "2.0-optimized"

--[[
Configuration Structure:

1. PERFORMANCE MONITORING: Track startup and runtime performance
2. CORE MODULES: Essential settings, keymaps, autocmds
3. PLUGIN MANAGER: Lazy.nvim with optimized settings
4. MISE INTEGRATION: Development tool management (optional)
5. HEALTH CHECKS: Verify external dependencies
6. DEVELOPMENT HELPERS: Commands for config management

Loading Strategy:
- Core settings load first (synchronous)
- Performance monitoring starts early
- Plugins load via organized imports
- Health checks run after startup (async)
- Development helpers available immediately

Error Handling:
- Graceful degradation for missing components
- Informative error messages
- Fallback options where possible
- Non-critical failures don't block startup
]]
