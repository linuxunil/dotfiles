-- lua/utils/performance.lua - Performance Monitoring System
local M = {}

-- Store startup time
if not vim.g.start_time then
	vim.g.start_time = vim.fn.reltime()
end

-- Performance tracking state
local perf_data = {
	startup_time = nil,
	plugin_load_times = {},
	lsp_attach_times = {},
	file_open_times = {},
}

-- Utility function to format time
local function format_time(time_ms)
	if time_ms < 1000 then
		return string.format("%.1fms", time_ms)
	else
		return string.format("%.2fs", time_ms / 1000)
	end
end

-- Get startup time
function M.get_startup_time()
	if not perf_data.startup_time then
		local elapsed = vim.fn.reltime(vim.g.start_time)
		perf_data.startup_time = vim.fn.reltimefloat(elapsed) * 1000
	end
	return perf_data.startup_time
end

-- Show startup time
function M.startup_time()
	local startup_ms = M.get_startup_time()
	local message = string.format("Startup: %s", format_time(startup_ms))

	-- Add loader stats if available (Neovim 0.9+)
	if vim.loader and vim.loader.stats then
		local stats = vim.loader.stats()
		if stats then
			message = message .. string.format(" (%d files loaded)", stats.loaded)
		end
	end

	vim.notify(message, vim.log.levels.INFO, { title = "Performance" })
	return startup_ms
end

-- Get plugin statistics
function M.plugin_stats()
	local lazy_ok, lazy = pcall(require, "lazy.stats")
	if not lazy_ok then
		vim.notify("Lazy.nvim not available", vim.log.levels.WARN)
		return nil
	end

	local stats = lazy.stats()
	local message =
		string.format("Plugins: %d loaded, %d total (%.1fms load time)", stats.loaded, stats.count, stats.startuptime)

	vim.notify(message, vim.log.levels.INFO, { title = "Plugin Stats" })
	return stats
end

-- Monitor file opening performance
function M.track_file_open()
	local start_time = vim.fn.reltime()

	vim.api.nvim_create_autocmd("BufReadPost", {
		once = true,
		callback = function()
			local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time)) * 1000
			table.insert(perf_data.file_open_times, elapsed)

			-- Show if file takes longer than 100ms to open
			if elapsed > 100 then
				vim.notify(
					string.format("Slow file open: %s", format_time(elapsed)),
					vim.log.levels.WARN,
					{ title = "Performance Warning" }
				)
			end
		end,
	})
end

-- Monitor LSP attach times
function M.track_lsp_attach()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client then
				local attach_time = vim.fn.reltime()

				-- Track when LSP is fully ready
				vim.defer_fn(function()
					local elapsed = vim.fn.reltimefloat(vim.fn.reltime(attach_time)) * 1000
					perf_data.lsp_attach_times[client.name] = elapsed

					-- Show if LSP takes longer than 500ms to attach
					if elapsed > 500 then
						vim.notify(
							string.format("Slow LSP attach (%s): %s", client.name, format_time(elapsed)),
							vim.log.levels.WARN,
							{ title = "LSP Performance" }
						)
					end
				end, 100)
			end
		end,
	})
end

-- Get memory usage
function M.memory_usage()
	local mem_used = collectgarbage("count")
	local message = string.format("Memory: %.1f MB", mem_used / 1024)

	vim.notify(message, vim.log.levels.INFO, { title = "Memory Usage" })
	return mem_used
end

-- Performance summary
function M.summary()
	local lines = {}

	-- Header
	table.insert(lines, "=== Performance Summary ===")
	table.insert(lines, "")

	-- Startup time
	local startup_ms = M.get_startup_time()
	table.insert(lines, string.format("Startup: %s", format_time(startup_ms)))

	-- Plugin stats
	local lazy_ok, lazy = pcall(require, "lazy.stats")
	if lazy_ok then
		local stats = lazy.stats()
		table.insert(
			lines,
			string.format("Plugins: %d/%d loaded (%s)", stats.loaded, stats.count, format_time(stats.startuptime))
		)
	end

	-- Memory usage
	local mem_used = collectgarbage("count")
	table.insert(lines, string.format("Memory: %.1f MB", mem_used / 1024))

	-- LSP attach times
	if next(perf_data.lsp_attach_times) then
		table.insert(lines, "")
		table.insert(lines, "LSP Attach Times:")
		for client, time in pairs(perf_data.lsp_attach_times) do
			table.insert(lines, string.format("  %s: %s", client, format_time(time)))
		end
	end

	-- File open times (average)
	if #perf_data.file_open_times > 0 then
		local total = 0
		for _, time in ipairs(perf_data.file_open_times) do
			total = total + time
		end
		local avg = total / #perf_data.file_open_times
		table.insert(lines, "")
		table.insert(lines, string.format("File opens: %d files, avg %s", #perf_data.file_open_times, format_time(avg)))
	end

	-- Performance recommendations
	table.insert(lines, "")
	table.insert(lines, "Recommendations:")

	if startup_ms > 150 then
		table.insert(lines, "  • Slow startup - consider lazy loading more plugins")
	end

	if mem_used > 100 * 1024 then -- 100MB
		table.insert(lines, "  • High memory usage - check for memory leaks")
	end

	local slow_lsp = {}
	for client, time in pairs(perf_data.lsp_attach_times) do
		if time > 1000 then
			table.insert(slow_lsp, client)
		end
	end

	if #slow_lsp > 0 then
		table.insert(lines, "  • Slow LSP servers: " .. table.concat(slow_lsp, ", "))
	end

	if #lines == 9 then -- No recommendations added
		table.insert(lines, "  ✅ Performance looks good!")
	end

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Performance Report" })
end

-- Benchmark a function
function M.benchmark(name, func, iterations)
	iterations = iterations or 1
	local times = {}

	for i = 1, iterations do
		local start_time = vim.fn.reltime()
		func()
		local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time)) * 1000
		table.insert(times, elapsed)
	end

	local total = 0
	local min_time = math.huge
	local max_time = 0

	for _, time in ipairs(times) do
		total = total + time
		min_time = math.min(min_time, time)
		max_time = math.max(max_time, time)
	end

	local avg_time = total / iterations

	local message = string.format(
		"%s: %s avg (%s min, %s max, %d runs)",
		name,
		format_time(avg_time),
		format_time(min_time),
		format_time(max_time),
		iterations
	)

	vim.notify(message, vim.log.levels.INFO, { title = "Benchmark" })
	return avg_time
end

-- Auto-setup performance monitoring
function M.setup()
	-- Track file opens
	M.track_file_open()

	-- Track LSP attaches
	M.track_lsp_attach()

	-- Show startup time after everything loads
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			-- Defer to let everything finish loading
			vim.defer_fn(function()
				if vim.g.show_startup_time ~= false then
					M.startup_time()
				end
			end, 100)
		end,
	})

	-- Garbage collection monitoring (optional)
	if vim.g.monitor_gc then
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyDone",
			callback = function()
				vim.defer_fn(function()
					collectgarbage("collect")
					local mem_after_gc = collectgarbage("count")
					vim.notify(
						string.format("Post-GC memory: %.1f MB", mem_after_gc / 1024),
						vim.log.levels.INFO,
						{ title = "Memory" }
					)
				end, 1000)
			end,
		})
	end
end

-- Create user commands for performance monitoring
local function create_commands()
	vim.api.nvim_create_user_command("PerfInfo", M.summary, {
		desc = "Show comprehensive performance information",
	})

	vim.api.nvim_create_user_command("PerfStartup", M.startup_time, {
		desc = "Show startup time",
	})

	vim.api.nvim_create_user_command("PerfPlugins", M.plugin_stats, {
		desc = "Show plugin statistics",
	})

	vim.api.nvim_create_user_command("PerfMemory", M.memory_usage, {
		desc = "Show memory usage",
	})

	vim.api.nvim_create_user_command("PerfBench", function(opts)
		local func_name = opts.args
		if func_name == "" then
			vim.notify("Usage: :PerfBench <function_name>", vim.log.levels.WARN)
			return
		end

		-- Simple benchmark for built-in functions
		local func = _G[func_name]
		if type(func) == "function" then
			M.benchmark(func_name, func, 10)
		else
			vim.notify("Function not found: " .. func_name, vim.log.levels.ERROR)
		end
	end, {
		nargs = 1,
		complete = "function",
		desc = "Benchmark a function",
	})
end

-- Initialize performance monitoring
M.setup()
create_commands()

return M
