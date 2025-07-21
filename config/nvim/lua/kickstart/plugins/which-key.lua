-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `opts` key (recommended), the configuration runs
-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },

        -- File operations
        { '<leader>f', group = '[F]iles' },
        { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
        { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
        { '<leader>fg', '<cmd>Telescope git_files<cr>', desc = 'Git files' },

        -- Buffer operations
        { '<leader>b', group = '[B]uffers' },
        { '<leader>bb', '<cmd>Telescope buffers<cr>', desc = 'Switch buffers' },
        { '<leader>bd', '<cmd>bdelete<cr>', desc = 'Delete buffer' },
        { '<leader>bn', '<cmd>bnext<cr>', desc = 'Next buffer' },
        { '<leader>bp', '<cmd>bprevious<cr>', desc = 'Previous buffer' },

        -- Search/Grep operations
        { '<leader>g', group = '[G]rep/Search' },
        { '<leader>gg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
        { '<leader>gw', '<cmd>Telescope grep_string<cr>', desc = 'Search word' },
        { '<leader>gf', '<cmd>Telescope live_grep<cr>', desc = 'Grep files' },

        -- Jump operations
        { '<leader>j', group = '[J]ump' },
        { '<leader>jj', '<cmd>Telescope jumplist<cr>', desc = 'Jump list' },
        { '<leader>jm', '<cmd>Telescope marks<cr>', desc = 'Marks' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
