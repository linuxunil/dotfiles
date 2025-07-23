return {
  {
    'echasnovski/mini.starter',
    lazy = false,
    opts = {
      autoopen = true,
      evaluate_single = true,
    },
  },
  {
    'echasnovski/mini.move',
    lazy = true,
    event = 'InsertEnter',
    opts = {
      reindent_linewise = true,
    },
  },
  {
    'echasnovski/mini.statusline',
    lazy = false,
    opts = {
      use_icons = vim.g.have_nerd_font,
      --@diagnostic disable-next-line: duplicate-set-field
      --   statusline.section_location = function()
      --     return '%2l:%-2v'
      -- end,
    },
  },
  {
    'echasnovski/mini.ai',
    lazy = true,
    event = 'InsertEnter',
    opts = {},
  },
  {
    'echasnovski/mini.surround',
    lazy = true,
    event = 'InsertEnter',
    opts = {},
  },
  {
    'echasnovski/mini.indentscope',
    lazy = true,
    event = 'VeryLazy',
    opts = {
      symbol = '┆',
      draw = {
        delay = 0,
      },
    },
  },
  {
    'echasnovski/mini.animate',
    lazy = false,
    opts = {
      cursor = {
        enable = true,
        timing = function(_, n)
          return 50 / n
        end,
      },
      scroll = {
        enable = true,
        timing = function(_, n)
          return 80 / n
        end,
      },
      resize = { enable = false },
      open = { enable = false },
      close = { enable = false },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
