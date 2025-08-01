-- create dirs
vim
  .api
  .nvim_create_autocmd('BufWritePre', {
    callback = function()
      local dir = vim.fn.expand '<afile>:p:h'
      if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, 'p')
      end
    end,
  })
-- Go-specific keybindings (only active in Go files)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    -- Toggle Go method/function visibility
    vim.keymap.set('n', '<leader>gt', function()
      local word = vim.fn.expand('<cword>')
      if word == '' then
        vim.notify('No word under cursor', vim.log.levels.WARN)
        return
      end

      local first_char = word:sub(1, 1)
      local rest = word:sub(2)
      local new_word

      if first_char:match('%u') then
        new_word = first_char:lower() .. rest
        vim.notify('Making ' .. word .. ' private -> ' .. new_word)
      else
        new_word = first_char:upper() .. rest
        vim.notify('Making ' .. word .. ' public -> ' .. new_word)
      end

      vim.lsp.buf.rename(new_word)
    end, { desc = 'Go [t]oggle visibility', buffer = true })
    
    -- Other useful Go.nvim commands
    vim.keymap.set('n', '<leader>gf', '<cmd>GoFillStruct<cr>', { desc = 'Go [f]ill struct', buffer = true })
    vim.keymap.set('n', '<leader>ge', '<cmd>GoIfErr<cr>', { desc = 'Go if [e]rr', buffer = true })
    vim.keymap.set('n', '<leader>ga', '<cmd>GoAddTag<cr>', { desc = 'Go [a]dd tags', buffer = true })
    vim.keymap.set('n', '<leader>gr', '<cmd>GoRmTag<cr>', { desc = 'Go [r]emove tags', buffer = true })
    vim.keymap.set('n', '<leader>gs', '<cmd>GoFillSwitch<cr>', { desc = 'Go fill [s]witch', buffer = true })
    vim.keymap.set('n', '<leader>gi', '<cmd>GoToggleInlay<cr>', { desc = 'Go toggle [i]nlay hints', buffer = true })
    
    -- Register Go group with which-key (only when in Go files)
    require('which-key').add({
      { '<leader>g', group = '[G]o', buffer = true },
    })
  end,
})
