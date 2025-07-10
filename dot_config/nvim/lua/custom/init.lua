-- lua/custom/init.lua
-- Load all custom configurations

-- Load custom options
require('custom.options')

-- Load custom keymaps
require('custom.keymaps')

-- Load custom autocommands
require('custom.autocommands')

-- Extend kickstart's conform and lint configurations
-- These must be loaded after plugins are loaded
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    require('custom.conform-config')
    require('custom.lint-config')
    
    -- Load which-key keymaps after which-key is available
    -- Using defer_fn to ensure which-key is fully loaded
    vim.defer_fn(function()
      local ok, wk = pcall(require, 'which-key')
      if ok then
        require('custom.which-key-keymaps').setup()
        require('custom.which-key-improvements').setup()
        require('custom.which-key-improvements').setup_highlights()
      else
        vim.notify('Which-key not loaded yet', vim.log.levels.WARN)
      end
    end, 100)
  end,
  desc = 'Load custom conform, lint, and which-key extensions',
})

-- Note: Custom plugins are loaded via { import = 'custom.plugins' } in lazy-plugins.lua
