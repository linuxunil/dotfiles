return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<C-y>'] = { 'select_and_accept' },

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500, window = { border = 'single' } },
        menu = {
          border = 'single',
          draw = {
            columns = { { 'kind_icon' }, { 'label', 'label_detail', gap = 1 } },
            components = {
              label_detail = {
                text = function(ctx)
                  local detail = ctx.item.detail or ''
                  -- Remove newlines and extra whitespace that can cause rendering issues
                  return detail:gsub('[\r\n]', ' '):gsub('%s+', ' '):match '^%s*(.-)%s*$' or ''
                end,
                highlight = 'Comment',
              },
            },
          },
        },
      },

      sources = {
        -- Dynamic provider selection based on filetype and context
        default = function(ctx)
          -- Check if we're in a comment (requires treesitter)
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            return { 'buffer' }
          end

          -- Filetype-specific provider selection
          if vim.bo.filetype == 'go' then
            return { 'lsp', 'path', 'snippets' }
          elseif vim.bo.filetype == 'lua' then
            return { 'lsp', 'path', 'lazydev' }
          elseif vim.bo.filetype == 'python' then
            return { 'lsp', 'path', 'snippets', 'buffer' }
          elseif vim.bo.filetype == 'markdown' then
            return { 'buffer', 'path' }
          elseif vim.bo.filetype == 'yaml' or vim.bo.filetype == 'yml' then
            return { 'lsp', 'path', 'buffer' }
          else
            return { 'lsp', 'path', 'snippets', 'buffer' }
          end
        end,
        providers = {
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          -- Enhanced buffer completion from all open buffers
          buffer = {
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ''
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
        },
        -- Set minimum keyword length by filetype
        min_keyword_length = function()
          if vim.bo.filetype == 'markdown' then
            return 2
          elseif vim.bo.filetype == 'yaml' or vim.bo.filetype == 'yml' then
            return 1
          else
            return 0
          end
        end,
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'prefer_rust_with_warning', sorts = {
        'exact',
        'score',
        'sort_text',
      } },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true, window = { border = 'single' } },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
