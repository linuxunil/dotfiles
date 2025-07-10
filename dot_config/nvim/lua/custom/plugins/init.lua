-- lua/custom/plugins/init.lua
-- Glimpse project custom plugins

return {
  -- ===== UI & COLORSCHEME (priority 1000) =====
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        contrast = 'hard',
        italic = {
          strings = false,
          comments = false,
          operators = false,
          folds = false,
        },
      })
      vim.cmd.colorscheme 'gruvbox'
    end,
  },

  -- ===== ESSENTIAL MINI MODULES (priority 600-700) =====
  {
    'echasnovski/mini.icons',
    version = false,
    priority = 700,
    config = function()
      require('mini.icons').setup()
    end,
  },

  {
    'echasnovski/mini.tabline',
    version = false,
    priority = 650,
    config = function()
      require('mini.tabline').setup()
    end,
  },

  {
    'echasnovski/mini.indentscope',
    version = false,
    event = 'BufRead',
    config = function()
      require('mini.indentscope').setup({
        symbol = "│",
        options = { try_as_border = true },
      })
    end,
  },

  {
    'echasnovski/mini.cursorword',
    version = false,
    event = 'BufRead',
    config = function()
      require('mini.cursorword').setup()
    end,
  },

  {
    'echasnovski/mini.trailspace',
    version = false,
    event = 'BufRead',
    config = function()
      require('mini.trailspace').setup()
    end,
  },

  -- NOTE: mini.comment and mini.pairs are already loaded by kickstart/plugins/mini.lua

  -- ===== FILE & BUFFER MANAGEMENT =====
  {
    'echasnovski/mini.files',
    version = false,
    priority = 500,
    lazy = false,
    config = function()
      require('mini.files').setup({
        mappings = {
          go_in_plus = '<CR>',
        },
      })
      -- Set keymap after setup
      vim.keymap.set('n', '<leader>e', function() require('mini.files').open() end, { desc = 'Open file explorer' })
    end,
  },

  {
    'echasnovski/mini.bufremove',
    version = false,
    keys = {
      { '<leader>bd', function() require('mini.bufremove').delete() end, desc = 'Delete buffer' },
    },
    config = function()
      require('mini.bufremove').setup()
    end,
  },

  -- ===== MOTION & NAVIGATION =====
  {
    'ggandor/leap.nvim',
    keys = { 's', 'S' },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    priority = 400,
    lazy = false,
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()
      
      -- Set keymaps after setup
      vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Add to Harpoon' })
      vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })
      vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end, { desc = 'Harpoon 1' })
      vim.keymap.set('n', '<C-t>', function() harpoon:list():select(2) end, { desc = 'Harpoon 2' })
      vim.keymap.set('n', '<C-n>', function() harpoon:list():select(3) end, { desc = 'Harpoon 3' })
      vim.keymap.set('n', '<C-s>', function() harpoon:list():select(4) end, { desc = 'Harpoon 4' })
    end,
  },

  -- ===== UTILITIES =====
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle undo tree' },
    },
  },

  {
    'folke/trouble.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle<cr>', desc = 'Toggle trouble' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace diagnostics' },
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document diagnostics' },
      { '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', desc = 'Quickfix list' },
      { '<leader>xl', '<cmd>TroubleToggle loclist<cr>', desc = 'Location list' },
    },
    opts = {},
  },

  {
    'ahmedkhalf/project.nvim',
    event = 'VeryLazy',
    config = function()
      require('project_nvim').setup({
        detection_methods = { 'pattern', 'lsp' },
        patterns = { '.git', '.mise.toml', 'Makefile', 'go.mod', 'pyproject.toml' },
      })
    end,
  },

  -- ===== TELESCOPE EXTENSIONS =====
  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope').load_extension('frecency')
    end,
    keys = {
      { '<leader>sf', '<cmd>Telescope frecency<cr>', desc = 'Frecent files' },
    },
  },

  -- ===== TESTING =====
  {
    'nvim-neotest/neotest',
    ft = { 'go', 'python' },
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-go'),
          require('neotest-python')({
            runner = 'pytest',
            python = '.venv/bin/python',
          }),
        },
      })
    end,
    keys = {
      { '<leader>tn', function() require('neotest').run.run() end, desc = 'Run nearest test' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run file tests' },
      { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
    },
  },

  -- ===== SNIPPETS =====
  {
    'rafamadriz/friendly-snippets',
    event = 'InsertEnter',
  },

  -- ===== NOTE TAKING =====
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'glimpse',
          path = '~/Documents/glimpse-notes',
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      mappings = {
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      },
    },
  },

  -- ===== LSP ENHANCEMENTS =====
  -- NOTE: conform.nvim and nvim-lint are already loaded by kickstart
  -- Extensions will be added via separate config files
}
