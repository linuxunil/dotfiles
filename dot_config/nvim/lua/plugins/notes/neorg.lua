-- lua/plugins/neorg.lua (Fixed configuration)
return {
  -- Luarocks dependency for Neorg (must be loaded first)
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-utils.nvim", "nvim-nio", "pathlib.nvim" }
    }
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      "vhyrro/luarocks.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    version = "*", -- Pin to latest stable release
    ft = "norg",   -- Load for .norg files
    cmd = "Neorg", -- Load when Neorg command is used
    keys = {
      -- Neorg workspace management
      { "<leader>nw", "<cmd>Neorg workspace<cr>",         desc = "Neorg workspaces" },
      { "<leader>nr", "<cmd>Neorg return<cr>",            desc = "Return to index" },
      { "<leader>ni", "<cmd>Neorg index<cr>",             desc = "Open workspace index" },

      -- Neorg journal
      { "<leader>nj", "<cmd>Neorg journal<cr>",           desc = "Open journal" },
      { "<leader>nt", "<cmd>Neorg journal today<cr>",     desc = "Today's journal" },
      { "<leader>ny", "<cmd>Neorg journal yesterday<cr>", desc = "Yesterday's journal" },
      { "<leader>nm", "<cmd>Neorg journal tomorrow<cr>",  desc = "Tomorrow's journal" },

      -- Neorg note management
      {
        "<leader>no",
        function()
          vim.ui.input({ prompt = "Note name: " }, function(name)
            if name then
              vim.cmd("Neorg new " .. name)
            end
          end)
        end,
        desc = "New note"
      },

      -- Neorg TOC and export
      { "<leader>ntc", "<cmd>Neorg toc left<cr>",            desc = "Table of contents" },
      { "<leader>nts", "<cmd>Neorg tangle current-file<cr>", desc = "Tangle current file" },
    },
    config = function()
      require("neorg").setup({
        load = {
          -- Core modules (essential)
          ["core.defaults"] = {},      -- Loads default behaviour
          ["core.concealer"] = {       -- Adds pretty icons to your documents
            config = {
              icon_preset = "diamond", -- diamond, varied, basic
              icons = {
                heading = {
                  icons = { "◉", "◎", "○", "✺", "▶", "⤷" }
                },
                todo = {
                  done = { icon = "✓" },
                  pending = { icon = "○" },
                  undone = { icon = "✗" },
                },
              },
            },
          },

          -- Directory and workspace management
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
                work = "~/notes/work",
                personal = "~/notes/personal",
                projects = "~/notes/projects",
              },
              default_workspace = "notes",
              index = "index.norg", -- Default index file name
            },
          },

          -- Completion integration
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },

          -- Journal functionality
          ["core.journal"] = {
            config = {
              strategy = "nested",
              workspace = "notes",
            },
          },

          -- Export functionality
          ["core.export"] = {},

          -- Table of contents
          ["core.qol.toc"] = {},

          -- Todo items
          ["core.qol.todo_items"] = {},

          -- Better looking glass for code blocks
          ["core.looking-glass"] = {},

          -- Summary generation
          ["core.summary"] = {},

          -- Code extraction
          ["core.tangle"] = {
            config = {
              report_on_empty = false,
            },
          },
        },
      })

      -- Ensure Treesitter parser for Neorg is installed
      local function ensure_norg_parser()
        local parsers = require("nvim-treesitter.parsers")
        if not parsers.has_parser("norg") then
          vim.cmd("TSInstall norg")
        end
      end

      -- Install parser on Neorg load
      vim.api.nvim_create_autocmd("User", {
        pattern = "NeorgStarted",
        callback = ensure_norg_parser,
      })

      -- Auto-create workspace directories
      local function create_workspaces()
        local workspaces = {
          "~/notes",
          "~/notes/work",
          "~/notes/personal",
          "~/notes/projects",
        }

        for _, workspace in ipairs(workspaces) do
          local expanded_path = vim.fn.expand(workspace)
          if vim.fn.isdirectory(expanded_path) == 0 then
            vim.fn.mkdir(expanded_path, "p")
          end
        end

        -- Create default index files
        local index_files = {
          { path = "~/notes/index.norg",          title = "Notes Index" },
          { path = "~/notes/work/index.norg",     title = "Work Notes" },
          { path = "~/notes/personal/index.norg", title = "Personal Notes" },
          { path = "~/notes/projects/index.norg", title = "Project Notes" },
        }

        for _, index in ipairs(index_files) do
          local expanded_path = vim.fn.expand(index.path)
          if vim.fn.filereadable(expanded_path) == 0 then
            local content = {
              "* " .. index.title,
              "",
              "  Welcome to your " .. index.title:lower() .. "!",
              "",
              "** Getting Started",
              "   - Create new notes with `:Neorg new <name>`",
              "   - Link to other notes with `{:note-name:}[Display Text]`",
              "   - Use `* Heading` for sections",
              "",
              "** Quick Links",
              "   - {:index:}[Main Index]",
              "",
              "** Tasks",
              "   - ( ) Set up note-taking system",
              "   - ( ) Create first project note",
              "",
            }

            local file = io.open(expanded_path, "w")
            if file then
              file:write(table.concat(content, "\n"))
              file:close()
            end
          end
        end
      end

      -- Create workspaces when Neorg is loaded
      vim.api.nvim_create_autocmd("User", {
        pattern = "NeorgStarted",
        callback = create_workspaces,
      })

      -- Neorg-specific key mappings (only in .norg files)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "norg",
        callback = function()
          local opts = { buffer = true, silent = true }

          -- Task management
          vim.keymap.set("n", "<C-Space>", function()
            vim.cmd("Neorg keybind norg core.qol.todo_items.todo.task_cycle")
          end, vim.tbl_extend("force", opts, { desc = "Cycle task state" }))

          -- Navigation
          vim.keymap.set("n", "<CR>", function()
            vim.cmd("Neorg keybind norg core.esupports.hop.hop-link")
          end, vim.tbl_extend("force", opts, { desc = "Follow link" }))

          -- List management
          vim.keymap.set("n", "<M-l>", function()
            vim.cmd("Neorg keybind norg core.promo.promote")
          end, vim.tbl_extend("force", opts, { desc = "Promote object" }))

          vim.keymap.set("n", "<M-h>", function()
            vim.cmd("Neorg keybind norg core.promo.demote")
          end, vim.tbl_extend("force", opts, { desc = "Demote object" }))

          -- Heading navigation with Treesitter
          vim.keymap.set("n", "]]", function()
            vim.cmd("Neorg keybind norg core.integrations.treesitter.next.heading")
          end, vim.tbl_extend("force", opts, { desc = "Next heading" }))

          vim.keymap.set("n", "[[", function()
            vim.cmd("Neorg keybind norg core.integrations.treesitter.previous.heading")
          end, vim.tbl_extend("force", opts, { desc = "Previous heading" }))
        end,
      })

      -- Better syntax highlighting for Neorg
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "norg",
        callback = function()
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nc"
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.opt_local.breakindent = true
        end,
      })
    end,
  },
}
