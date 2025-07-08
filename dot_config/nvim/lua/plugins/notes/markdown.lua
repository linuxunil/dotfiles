-- lua/plugins/notes/markdown.lua
return {
  -- Modern Markdown preview
  {
    "toppair/peek.nvim",
    ft = "markdown",
    build = "deno task --quiet build:fast",
    keys = {
      { "<leader>mp", "<cmd>PeekOpen<cr>", desc = "Markdown Preview", ft = "markdown" },
    },
    opts = {
      auto_load = true,
      close_on_bdelete = true,
      syntax = true,
      theme = "dark",
    },
  },

  -- Basic markdown syntax and features
  {
    "preservim/vim-markdown",
    ft = "markdown",
    dependencies = { "godlygeek/tabular" },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
    end,
  },

  -- Paste images into markdown
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    ft = { "markdown" },
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = true,
      },
    },
    keys = {
      { "<leader>mi", "<cmd>PasteImage<cr>", desc = "Paste Image", ft = "markdown" },
    },
  },
}