-- lua/plugins/debugging.lua (Fixed with nvim-nio dependency)
return {
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver" },
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<cr>",         desc = "Continue" },
      { "<leader>dC", "<cmd>DapRunToCursor<cr>",      desc = "Run to Cursor" },
      { "<leader>dg", "<cmd>DapGoto<cr>",             desc = "Go to line (no execute)" },
      { "<leader>di", "<cmd>DapStepInto<cr>",         desc = "Step Into" },
      { "<leader>dj", "<cmd>DapDown<cr>",             desc = "Down" },
      { "<leader>dk", "<cmd>DapUp<cr>",               desc = "Up" },
      { "<leader>dl", "<cmd>DapShowLog<cr>",          desc = "Show Log" },
      { "<leader>do", "<cmd>DapStepOut<cr>",          desc = "Step Out" },
      { "<leader>dO", "<cmd>DapStepOver<cr>",         desc = "Step Over" },
      { "<leader>dp", "<cmd>DapPause<cr>",            desc = "Pause" },
      { "<leader>dr", "<cmd>DapRepl<cr>",             desc = "REPL" },
      { "<leader>ds", "<cmd>DapSessionSelect<cr>",    desc = "Session" },
      { "<leader>dt", "<cmd>DapTerminate<cr>",        desc = "Terminate" },
      { "<leader>dw", "<cmd>DapShowWidgets<cr>",      desc = "Widgets" },
    },
    config = function()
      local dap = require("dap")

      -- Set up DAP UI icons
      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "", linehl = "", numhl = "" })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio", -- Fixed: Added missing dependency
      "nvim-neotest/neotest-go",
    },
    event = "BufRead",
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end,                     desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Run file tests" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Test summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test output" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          }),
        },
        status = {
          virtual_text = true,
        },
        output = {
          open_on_run = true,
        },
        quickfix = {
          open = function()
            vim.cmd("Trouble qflist open")
          end,
        },
      })
    end,
  },
  {
    "nvim-neotest/neotest-go",
    ft = "go",
  },
}
