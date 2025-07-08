-- lua/custom/plugins/dap.lua
return {
  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      require('dapui').setup()
      require('nvim-dap-virtual-text').setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[C]ontinue' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step [I]nto' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step [O]ver' })
      vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step [O]ut' })
      vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Open [R]EPL' })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Run [L]ast' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle [U]I' })
    end,
  },
}