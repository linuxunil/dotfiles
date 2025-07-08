-- lua/core/deps.lua

local M = {}

function M.setup()
  -- mini.deps setup
  require('mini.deps').setup()
  local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

  -- ===== Add plugins here =====
  add('echasnovski/mini.nvim')
  add('folke/tokyonight.nvim')
  add('folke/which-key.nvim')
  add('nvim-lua/plenary.nvim')
  add('nvim-telescope/telescope.nvim')
  add({ source = 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' })
  add('lewis6991/gitsigns.nvim')
  add('nvim-treesitter/nvim-treesitter')
  add('nvim-treesitter/nvim-treesitter-textobjects')
  add('williamboman/mason.nvim')
  add('williamboman/mason-lspconfig.nvim')
  add('neovim/nvim-lspconfig')
  add('saghen/blink.cmp')
  add('L3MON4D3/LuaSnip')
  add('rafamadriz/friendly-snippets')
  add('stevearc/conform.nvim')
  add('mfussenegger/nvim-dap')
  add('rcarriga/nvim-dap-ui')
  add('leoluz/nvim-dap-go')
  add('nvim-neotest/neotest')
  add('nvim-neotest/neotest-go')
  add('folke/trouble.nvim')
  add('folke/noice.nvim')
  add('MunifTanjim/nui.nvim')
  add('rcarriga/nvim-notify')
  add('stevearc/oil.nvim')
  add('karb94/neoscroll.nvim')
  add('RRethy/vim-illuminate')
  add('kevinhwang91/nvim-ufo')
  add('kevinhwang91/promise-async')
  add('norcalli/nvim-colorizer.lua')
  add('folke/todo-comments.nvim')
  add('folke/flash.nvim')
  add('ray-x/go.nvim')
  add('ray-x/guihua.lua')
  add('linux-cultist/venv-selector.nvim')
  add('Vigemus/iron.nvim')
  add('danymat/neogen')
  add('ziglang/zig.vim')
  add('NTBBloodbath/zig-tools.nvim')
  add('toppair/peek.nvim')
  add('preservim/vim-markdown')
  add('godlygeek/tabular')
  add('HakonHarnes/img-clip.nvim')
  add({ source = 'vhyrro/luarocks.nvim', priority = 1000 })
  add('nvim-neorg/neorg')
  add('WhoIsSethDaniel/mason-tool-installer.nvim')
  add('nvim-neotest/nvim-nio')

  -- ===== Configure plugins =====
  now(function()
    -- Load theme and core UI immediately
    require('tokyonight').setup({
      style = 'night',
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = 'dark',
        floats = 'dark',
      },
    })
    vim.cmd.colorscheme('tokyonight')

    require('mini.statusline').setup({
      use_icons = true,
      content = {
        active = function()
          return {
            { section = 'mode', icon = '' },
            { section = 'git', icon = '' },
            { section = 'fileinfo', icon = '󰈙' },
            { section = 'diagnostics', icon = '󰒡' },
            { section = 'location', icon = '󰆞' },
          }
        end,
      },
    })

    require('mini.tabline').setup({ use_icons = true })
    require('mini.starter').setup({
      header = require('utils.starter').get_theme().header,
      items = require('utils.starter').get_theme().items,
      footer = require('utils.starter').get_theme().quote,
    })
  end)

  later(function()
    -- All other plugin configurations go here
    require('gitsigns').setup({
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
    })

    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash', 'c', 'lua', 'vim', 'vimdoc', 'query', 'regex', 'html', 'css',
        'javascript', 'typescript', 'tsx', 'json', 'jsonc', 'python', 'go',
        'zig', 'rust', 'java', 'cpp', 'yaml', 'toml', 'xml', 'ini',
        'dockerfile', 'gitignore', 'gitcommit', 'markdown', 'markdown_inline',
        'sql',
      },
      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
          goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
        },
      },
    })

    require('mason').setup({
      PATH = 'append',
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'gopls',
        'golangci-lint',
        'delve',
      },
    })

    require('mason-lspconfig').setup({
      ensure_installed = {
        'gopls', 'html', 'sqlls', 'lua_ls', 'zls', 'pyright', 'ruff',
        'elixirls', 'ts_ls', 'jsonls', 'yamlls', 'dockerls', 'taplo',
      },
      automatic_installation = true,
    })

    local lspconfig = require('lspconfig')
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      client.server_capabilities.semanticTokensProvider = nil
    end

    local servers = {
      gopls = {
        settings = {
          gopls = {
            analyses = { unusedparams = true, unusedwrite = true },
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
            gofumpt = true,
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME, '${3rd}/luv/library', '${3rd}/busted/library' },
            },
            completion = { callSnippet = 'Replace' },
            diagnostics = { globals = { 'vim' } },
            telemetry = { enable = false },
          },
        },
      },
      zls = {
        settings = {
          zls = {
            enable_snippets = true,
            enable_ast_check_diagnostics = true,
            enable_autofix = true,
            warn_style = true,
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'workspace',
            },
          },
        },
      },
      ruff = {},
      html = {},
      ts_ls = {},
      jsonls = {},
      yamlls = {},
      dockerls = {},
      sqlls = {},
      taplo = {},
    }

    for server, config in pairs(servers) do
      config.capabilities = capabilities
      config.on_attach = on_attach
      lspconfig[server].setup(config)
    end

    vim.diagnostic.config({
      virtual_text = { prefix = '●', source = 'if_many' },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { border = 'rounded', source = 'always' },
    })

    local signs = { Error = '󰅚', Warn = '󰀪', Hint = '󰌶', Info = '󰋽' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    require('luasnip').setup({
      history = true,
      delete_check_events = 'TextChanged',
    })

    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofumpt' },
        zig = { 'zig' },
        python = { 'ruff_format', 'ruff_organize_imports' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        json = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        markdown = { 'prettier' },
        yaml = { 'prettier' },
        toml = { 'taplo' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
      },
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return {
          timeout_ms = 1000,
          lsp_fallback = true,
        }
      end,
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2', '-ci' },
        },
      },
    })

    require('oil').setup({
      default_file_explorer = true,
      columns = { 'icon', 'git' },
      view_options = { show_hidden = false },
      keymaps = { ['g.'] = 'actions.toggle_hidden' },
    })

    require('neoscroll').setup()
    require('illuminate').configure({
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = { providers = { 'lsp' } },
    })

    require('ufo').setup({
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    })
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = 'eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸'

    require('colorizer').setup()
    require('trouble').setup()
    require('todo-comments').setup()
    require('flash').setup()
    require('go').setup({ gofmt = 'gofumpt' })
    require('dap-go').setup()
    require('venv-selector').setup({ stay_on_this_version = true })
    require('iron.core').setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          python = {
            command = { 'uv', 'run', 'python' },
            format = require('iron.fts.common').bracketed_paste,
          },
        },
        repl_open_cmd = require('iron.view').right(50),
      },
    })
    require('neogen').setup({ snippet_engine = 'luasnip', languages = { python = { template = { annotation_convention = 'google_docstrings' } } } })
    vim.g.zig_fmt_autosave = 1
    require('zig-tools').setup({ integrations = { debug = true } })
    require('peek').setup({ auto_load = true, close_on_bdelete = true, syntax = true, theme = 'dark' })
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 0
    require('img-clip.nvim').setup({ default = { embed_image_as_base64 = false, prompt_for_file_name = true } })
    require('luarocks.nvim').setup({ rocks = { 'lua-utils.nvim', 'nvim-nio', 'pathlib.nvim' } })

    local neorg_workspaces = {
      notes = '~/notes',
      work = '~/notes/work',
      personal = '~/notes/personal',
      projects = '~/notes/projects',
    }
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    neorg_workspaces[project_name] = vim.fn.getcwd() .. '/.notes'

    require('neorg').setup({
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = { config = { icon_preset = 'diamond', icons = { heading = { icons = { '◉', '◎', '○', '✺', '▶', '⤷' } }, todo = { done = { icon = '✓' }, pending = { icon = '○' }, undone = { icon = '✗' } } } } },
        ['core.dirman'] = { config = { workspaces = neorg_workspaces, default_workspace = 'notes', index = 'index.norg' } },
        ['core.journal'] = { config = { strategy = 'nested', workspace = 'notes' } },
        ['core.export'] = {},
        ['core.qol.toc'] = {},
        ['core.qol.todo_items'] = {},
        ['core.looking-glass'] = {},
        ['core.summary'] = {},
        ['core.tangle'] = { config = { report_on_empty = false } },
      },
    })

    require('blink.cmp').setup({
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
      },
      snippets = {
        preset = 'luasnip',
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
    })

    require('which-key').setup({
      plugins = { spelling = true },
      win = { border = 'rounded' },
    })
  end)
end

return M