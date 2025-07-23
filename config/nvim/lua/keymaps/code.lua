-- Code, Debug, and LSP operations keymaps

-- ============================================================================
-- CODE OPERATIONS
-- ============================================================================

-- Code actions
vim.keymap.set('n', '<leader>cf', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Code [f]ormat' })

-- ============================================================================
-- DEBUG OPERATIONS
-- ============================================================================

-- Debug operations (placeholders - will be set by nvim-dap)

-- ============================================================================
-- LSP OPERATIONS
-- ============================================================================

-- LSP navigation (gr prefix)
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { desc = '[G]oto [R]eferences' })
vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', { desc = '[G]oto [T]ype Definition' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = '[G]oto [R]ename' })
vim.keymap.set({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, { desc = '[G]oto [A]ction' })
vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })

-- LSP hover and signature help
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

-- LSP workspace operations
vim.keymap.set('n', '<leader>ws', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', { desc = 'Open Workspace Symbols' })

-- ============================================================================
-- TROUBLE DIAGNOSTICS
-- ============================================================================

-- Trouble diagnostics
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

-- Register groups with which-key (deferred until which-key loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ebug' },
      { '<leader>x', group = 'Trouble' },
      { 'gr', group = '[G]oto [R]eferences/LSP' },
    }
  end,
})
