-- lua/mise-integration.lua (Enhanced with better error handling)

local M = {}

-- Check if mise is available
local function has_mise()
	return vim.fn.executable("mise") == 1
end

-- Safe command execution
local function safe_execute(cmd, silent)
	silent = silent or false

	local handle = io.popen(cmd .. " 2>/dev/null")
	if not handle then
		if not silent then
			vim.notify("Failed to execute: " .. cmd, vim.log.levels.WARN)
		end
		return nil
	end

	local result = handle:read("*a")
	local success = handle:close()

	if not success and not silent then
		vim.notify("Command failed: " .. cmd, vim.log.levels.WARN)
		return nil
	end

	return result and vim.trim(result) or nil
end

-- Get mise-managed tool path with error handling
local function get_tool_path(tool)
	if not has_mise() then
		return nil
	end

	local result = safe_execute("mise which " .. tool, true)
	return result ~= "" and result or nil
end

-- Setup LSP with mise-managed tools
function M.setup_lsp_paths()
	if not has_mise() then
		return false, "mise not available"
	end

	local success = true
	local errors = {}

	-- Go tools
	local gopls_path = get_tool_path("gopls")
	if gopls_path then
		vim.g.go_gopls_path = gopls_path
	end

	-- Python tools
	local python_path = get_tool_path("python")
	if python_path then
		vim.g.python3_host_prog = python_path
	end

	-- Update PATH for LSP servers
	local mise_env = safe_execute("mise env --shell=bash")
	if mise_env then
		for line in mise_env:gmatch("[^\r\n]+") do
			local var, value = line:match("^export ([^=]+)=(.+)$")
			if var == "PATH" and value then
				-- Remove quotes and apply
				value = value:gsub('^"', ""):gsub('"$', "")
				vim.env.PATH = value
				break
			end
		end
	else
		table.insert(errors, "Failed to get mise environment")
		success = false
	end

	return success, #errors > 0 and table.concat(errors, "; ") or nil
end

-- Auto-activate mise on directory change
function M.setup_auto_activation()
	vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
		callback = function()
			if not has_mise() then
				return
			end

			-- Refresh environment when changing directories
			local env_output = safe_execute("mise env --shell=bash", true)
			if not env_output then
				return
			end

			-- Parse and apply environment variables
			for line in env_output:gmatch("[^\r\n]+") do
				local var, value = line:match("^export ([^=]+)=(.+)$")
				if var and value then
					-- Remove quotes and apply
					value = value:gsub('^"', ""):gsub('"$', "")
					vim.env[var] = value
				end
			end
		end,
	})
end

-- Show current mise environment info
function M.show_info()
	if not has_mise() then
		vim.notify("Mise not found", vim.log.levels.WARN)
		return
	end

	local info = {}
	table.insert(info, "=== Mise Environment ===")

	-- Show active tools
	local tools = safe_execute("mise list --current")
	if tools and tools ~= "" then
		table.insert(info, "")
		table.insert(info, "Active tools:")
		table.insert(info, tools)
	end

	-- Show project tasks
	local tasks = safe_execute("mise tasks")
	if tasks and tasks ~= "" then
		table.insert(info, "")
		table.insert(info, "Available tasks:")
		table.insert(info, tasks)
	end

	if #info > 1 then
		vim.notify(table.concat(info, "\n"), vim.log.levels.INFO, { title = "Mise Info" })
	else
		vim.notify("No mise information available", vim.log.levels.WARN)
	end
end

-- Run mise task with error handling
function M.run_task(task)
	if not has_mise() then
		vim.notify("Mise not found", vim.log.levels.WARN)
		return
	end

	if not task or task == "" then
		vim.notify("No task specified", vim.log.levels.WARN)
		return
	end

	local cmd = "mise run " .. task

	-- Use terminal for interactive tasks
	if vim.fn.has("nvim-0.10") == 1 then
		require("snacks").terminal(cmd)
	else
		vim.cmd("terminal " .. cmd)
	end
end

return M
