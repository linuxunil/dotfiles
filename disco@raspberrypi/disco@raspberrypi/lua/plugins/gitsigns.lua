-- Alternatively, use `config = function() ... end` for full control over the configuration.
-- If you prefer to call `setup` explicitly, use:
--    {
--        'lewis6991/gitsigns.nvim',
--        config = function()
--            require('gitsigns').setup({
--                -- Your gitsigns configuration here
--            })
--        end,
--    }
--
-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`.
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      
      -- Git hunk navigation
      vim.keymap.set('n', ']h', function()
        local gitsigns = require 'gitsigns'
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Next git hunk' })
      
      vim.keymap.set('n', '[h', function()
        local gitsigns = require 'gitsigns'
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Previous git hunk' })
      
      vim.keymap.set('n', ']H', function()
        require('gitsigns').nav_hunk 'last'
      end, { desc = 'Last git hunk' })
      
      vim.keymap.set('n', '[H', function()
        require('gitsigns').nav_hunk 'first'
      end, { desc = 'First git hunk' })
      
      -- Git operations
      vim.keymap.set('n', '<leader>Gs', function()
        require('gitsigns').stage_hunk()
      end, { desc = 'Git [s]tage hunk' })
      
      vim.keymap.set('v', '<leader>Gs', function()
        require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Git [s]tage hunk' })
      
      vim.keymap.set('n', '<leader>Gr', function()
        require('gitsigns').reset_hunk()
      end, { desc = 'Git [r]eset hunk' })
      
      vim.keymap.set('v', '<leader>Gr', function()
        require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Git [r]eset hunk' })
      
      vim.keymap.set('n', '<leader>GS', function()
        require('gitsigns').stage_buffer()
      end, { desc = 'Git [S]tage buffer' })
      
      vim.keymap.set('n', '<leader>Gu', function()
        require('gitsigns').undo_stage_hunk()
      end, { desc = 'Git [u]ndo stage hunk' })
      
      vim.keymap.set('n', '<leader>GR', function()
        require('gitsigns').reset_buffer()
      end, { desc = 'Git [R]eset buffer' })
      
      vim.keymap.set('n', '<leader>Gp', function()
        require('gitsigns').preview_hunk()
      end, { desc = 'Git [p]review hunk' })
      
      vim.keymap.set('n', '<leader>Gb', function()
        require('gitsigns').blame_line()
      end, { desc = 'Git [b]lame line' })
      
      vim.keymap.set('n', '<leader>Gd', function()
        require('gitsigns').diffthis()
      end, { desc = 'Git [d]iff against index' })
      
      vim.keymap.set('n', '<leader>GD', function()
        require('gitsigns').diffthis '@'
      end, { desc = 'Git [D]iff against last commit' })
      
      -- Register which-key groups
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          require('which-key').add {
            { '<leader>G', group = '[G]it' },
          }
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
