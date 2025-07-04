-- lua/plugins/tools/project.lua
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = {
    manual_mode = false,
    detection_methods = { "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    datapath = vim.fn.stdpath("data") .. "/project.nvim",
    silent_chdir = true,
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("telescope").load_extension("projects")
  end,
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Projects" },
  },
}
