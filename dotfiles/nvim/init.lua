-- ============================================================================
-- Modern Neovim Configuration 2025
-- Focused on Go, Python, and TypeScript development
-- ============================================================================

-- Set leader keys early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Basic Settings
-- ============================================================================

local opt = vim.opt

-- UI Settings
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.colorcolumn = "100"
opt.termguicolors = true
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 10

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Ensure undo directory exists
local undo_dir = vim.fn.expand("~/.local/share/nvim/undo")
if not vim.fn.isdirectory(undo_dir) then
  vim.fn.mkdir(undo_dir, "p")
end
opt.undodir = undo_dir

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.updatetime = 100
opt.timeoutlen = 300
opt.lazyredraw = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")

-- ============================================================================
-- Lazy.nvim Bootstrap
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugin Configuration
-- ============================================================================

require("lazy").setup({
  -- =========================================================================
  -- Theme - Catppuccin Latte
  -- =========================================================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        background = {
          light = "macchiato",
          dark = "macchiato",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          keywords = { "bold" },
          functions = { "bold" },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          which_key = true,
          mason = true,
          blink_cmp = true,
        }
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- =========================================================================
  -- LSP Management - Mason
  -- =========================================================================
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",        -- Go
          "basedpyright", -- Python
          "ruff",         -- Python linting/formatting
          "ts_ls",        -- TypeScript
          "eslint",       -- JavaScript/TypeScript linting
          "lua_ls",       -- Lua
          "marksman",     -- Markdown
        },
        automatic_installation = true,
      })

      -- Enhanced diagnostic configuration
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          severity = vim.diagnostic.severity.ERROR,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          header = "",
          prefix = "",
        },
      })
    end,
  },

  -- =========================================================================
  -- Completion - Blink.cmp
  -- =========================================================================
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
    },
    opts_extend = { "sources.default" }
  },

  -- =========================================================================
  -- LSP Configuration
  -- =========================================================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Go
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              test = true,
              tidy = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              unusedparams = true,
              unusedwrite = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
          },
        },
      })

      -- Python
      lspconfig.basedpyright.setup({
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      lspconfig.ruff.setup({
        capabilities = capabilities,
      })

      -- TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            }
          },
        },
      })

      -- ESLint
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          }
        }
      })

      -- Markdown
      lspconfig.marksman.setup({
        capabilities = capabilities,
        settings = {
          marksman = {
            completion = {
              wiki = { style = "title" },
            },
          },
        },
      })

      -- LSP Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
          end

          -- Navigation
          map("gd", vim.lsp.buf.definition, "Go to Definition")
          map("gr", vim.lsp.buf.references, "Go to References")
          map("gi", vim.lsp.buf.implementation, "Go to Implementation")
          map("gD", vim.lsp.buf.declaration, "Go to Declaration")

          -- Documentation
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>k", vim.lsp.buf.signature_help, "Signature Help")

          -- Actions
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")

          -- Diagnostics
          map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
          map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("<leader>e", vim.diagnostic.open_float, "Show Diagnostic")
        end,
      })
    end,
  },

  -- =========================================================================
  -- Syntax Highlighting - Treesitter
  -- =========================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "go", "gomod", "gosum",
          "python",
          "typescript", "javascript", "tsx",
          "html", "css", "json", "yaml",
          "markdown", "markdown_inline", "bash",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- =========================================================================
  -- File Finding - Telescope
  -- =========================================================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            prompt_position = "top",
            preview_width = 0.6,
          },
          sorting_strategy = "ascending",
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
      })

      pcall(require("telescope").load_extension, "fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
    end,
  },

  -- =========================================================================
  -- File Explorer
  -- =========================================================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 35,
          side = "left",
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
    end,
  },

  -- =========================================================================
  -- Git Integration
  -- =========================================================================
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      })
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    config = function()
      vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
    end,
  },

  -- =========================================================================
  -- Status Line
  -- =========================================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
      })
    end,
  },

  -- =========================================================================
  -- Utility Plugins
  -- =========================================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        delay = 300,
      })

      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>c", group = "Code" },
        { "<leader>r", group = "Rename/Refactor" },
        { "<leader>o", group = "Obsidian" },
        { "<leader>m", group = "Markdown" },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        { desc = "Buffer Diagnostics (Trouble)" })
    end,
  },

  -- =========================================================================
  -- Session Management
  -- =========================================================================
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- =========================================================================
  -- Terminal Integration
  -- =========================================================================
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
    keys = {
      { "<c-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle Vertical Terminal" },
    },
  },

  -- =========================================================================
  -- Go Development Tools
  -- =========================================================================
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup({
        goimports = "gopls",
        gofmt = "gofumpt",
        max_line_len = 120,
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        icons = { breakpoint = "🧘", currentpos = "🏃" },
        verbose = false,
        lsp_cfg = false, -- Use existing LSP config
        lsp_gofumpt = true,
        lsp_on_attach = false, -- Use existing on_attach
        dap_debug = false, -- No debugging
      })
    end,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- =========================================================================
  -- Task Runner Integration
  -- =========================================================================
  {
    "stevearc/overseer.nvim",
    opts = {
      templates = { "builtin", "go", "npm", "cargo" },
    },
    keys = {
      { "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
      { "<leader>tt", "<cmd>OverseerToggle<cr>", desc = "Toggle Tasks" },
      { "<leader>ta", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
    },
  },

  -- =========================================================================
  -- Python Environment Management
  -- =========================================================================
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = {
      name = { "venv", ".venv", "env", ".env" },
      auto_refresh = false,
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
    ft = "python",
  },


  -- =========================================================================
  -- Code Outline
  -- =========================================================================
  {
    "stevearc/aerial.nvim",
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>", { buffer = bufnr, desc = "Toggle Aerial" })
      end,
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- =========================================================================
  -- Essential Text Editing
  -- =========================================================================
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPre",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "nvim-tree",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  },

  -- =========================================================================
  -- Obsidian-style Markdown Editing
  -- =========================================================================
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "personal",
            path = "~/Documents/obsidian",
          },
          {
            name = "work",
            path = "~/Documents/work-notes",
          },
        },
        completion = {
          nvim_cmp = false,
          min_chars = 2,
        },
        mappings = {
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>ch"] = {
            action = function()
              return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
          },
          ["<cr>"] = {
            action = function()
              return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
          },
        },
        new_notes_location = "current_dir",
        wiki_link_func = function(opts)
          return require("obsidian.util").wiki_link_id_prefix(opts)
        end,
        preferred_link_style = "wiki",
        disable_frontmatter = false,
        templates = {
          subdir = "templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
        },
        daily_notes = {
          folder = "dailies",
          date_format = "%Y-%m-%d",
          alias_format = "%B %-d, %Y",
        },
        follow_url_func = function(url)
          vim.fn.jobstart({"open", url})
        end,
        finder = "telescope.nvim",
        sort_by = "modified",
        sort_reversed = true,
        open_notes_in = "current",
        ui = {
          enable = true,
          update_debounce = 200,
          checkboxes = {
            [" "] = { char = "☐", hl_group = "ObsidianTodo" },
            ["x"] = { char = "☑", hl_group = "ObsidianDone" },
            [">"] = { char = "📝", hl_group = "ObsidianRightArrow" },
            ["~"] = { char = "⌇", hl_group = "ObsidianTilde" },
          },
          bullets = { char = "•", hl_group = "ObsidianBullet" },
          external_link_icon = { char = "🔗", hl_group = "ObsidianExtLinkIcon" },
          reference_text = { hl_group = "ObsidianRefText" },
          highlight_text = { hl_group = "ObsidianHighlightText" },
          tags = { hl_group = "ObsidianTag" },
        },
        attachments = {
          img_folder = "assets/imgs",
        },
      })

      -- Obsidian keymaps
      vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Create new note" })
      vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open note in Obsidian" })
      vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Show backlinks" })
      vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<cr>", { desc = "Show tags" })
      vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch" })
      vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Search notes" })
      vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLink<cr>", { desc = "Link selection" })
      vim.keymap.set("n", "<leader>oL", "<cmd>ObsidianLinkNew<cr>", { desc = "Link selection to new note" })
      vim.keymap.set("n", "<leader>oT", "<cmd>ObsidianTemplate<cr>", { desc = "Insert template" })
      vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Open today's note" })
      vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's note" })
      vim.keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<cr>", { desc = "Paste image" })
      vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<cr>", { desc = "Rename note" })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = "markdown",
    config = function()
      require("render-markdown").setup({
        enabled = true,
        max_file_size = 1.5,
        render_modes = true,
        heading = {
          enabled = true,
          sign = false,
          position = "overlay",
          icons = { "█ ", "█ ", "█ ", "█ ", "█ ", "█ " },
          width = "full",
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
        },
        code = {
          enabled = true,
          sign = false,
          style = "full",
          width = "full",
          border = "thin",
        },
        bullet = {
          enabled = true,
          icons = { "•", "◦", "▪", "▫" },
        },
        checkbox = {
          enabled = true,
          unchecked = {
            icon = "☐ ",
            highlight = "RenderMarkdownUnchecked",
          },
          checked = {
            icon = "☑ ",
            highlight = "RenderMarkdownChecked",
          },
        },
        callout = {
          enabled = true,
          note = { raw = "[!NOTE]", rendered = "📝 Note", highlight = "RenderMarkdownInfo" },
          tip = { raw = "[!TIP]", rendered = "💡 Tip", highlight = "RenderMarkdownSuccess" },
          important = { raw = "[!IMPORTANT]", rendered = "📢 Important", highlight = "RenderMarkdownHint" },
          warning = { raw = "[!WARNING]", rendered = "⚠️ Warning", highlight = "RenderMarkdownWarn" },
          caution = { raw = "[!CAUTION]", rendered = "🔥 Caution", highlight = "RenderMarkdownError" },
        },
        link = {
          enabled = true,
          image = "🖼️",
          email = "📧",
          hyperlink = "🔗",
          highlight = "RenderMarkdownLink",
        },
      })

      -- Toggle render-markdown
      vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Render" })
    end,
  },
})

-- ============================================================================
-- Additional Keymaps
-- ============================================================================

-- Better movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Better scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Better search
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Quick save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Format
vim.keymap.set("n", "<leader>fmt", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

-- Task runner integration
vim.keymap.set("n", "<leader>tb", "<cmd>OverseerRun task base<cr>", { desc = "Run task base" })
vim.keymap.set("n", "<leader>td", "<cmd>OverseerRun task dev<cr>", { desc = "Run task dev" })
vim.keymap.set("n", "<leader>tc", "<cmd>OverseerRun task clean<cr>", { desc = "Run task clean" })
vim.keymap.set("n", "<leader>ts", "<cmd>OverseerRun task status<cr>", { desc = "Run task status" })

-- Go-specific keymaps
vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", { desc = "Go Test" })
vim.keymap.set("n", "<leader>gT", "<cmd>GoTestFile<cr>", { desc = "Go Test File" })
vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<cr>", { desc = "Go Coverage" })
vim.keymap.set("n", "<leader>gi", "<cmd>GoImpl<cr>", { desc = "Go Implement Interface" })
vim.keymap.set("n", "<leader>gf", "<cmd>GoFillStruct<cr>", { desc = "Go Fill Struct" })


-- ============================================================================
-- Auto Commands
-- ============================================================================

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
    })
  end,
})

-- Auto-format on save for specific filetypes
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("AutoFormat", {}),
  pattern = { "*.go", "*.py", "*.ts", "*.js", "*.lua" },
  callback = function()
    -- Use async formatting for most files, sync for Go (goimports needs sync)
    local async = vim.bo.filetype ~= "go"
    vim.lsp.buf.format({ async = async })
  end,
})

-- Terminal mode improvements
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TerminalSettings", {}),
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- Session management - auto-save sessions
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("SessionManager", {}),
  callback = function()
    if vim.fn.argc() == 0 then
      require("persistence").save()
    end
  end,
})

-- Set tab width for Go files
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("GoSettings", {}),
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})

-- ============================================================================
-- End Configuration
-- ============================================================================

