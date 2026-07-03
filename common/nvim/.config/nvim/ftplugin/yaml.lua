function _G.NavigateFold(direction)
  local cmd = 'normal! ' .. direction
  local view = vim.fn.winsaveview()
  local lnum = view.lnum
  local new_lnum = lnum
  local open = true

  while lnum == new_lnum or open do
    vim.cmd(cmd)
    new_lnum = vim.fn.line '.'
    open = vim.fn.foldclosed(new_lnum) < 0
  end

  if open then
    vim.fn.winrestview(view)
  end
end

vim.opt_local.cursorcolumn = true -- Highlight the current column
vim.opt_local.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt_local.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt_local.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt_local.expandtab = true -- Expand tab to 2 spaces

vim.opt_local.foldmethod = 'indent'
vim.opt_local.foldlevel = 99
vim.api.nvim_buf_set_keymap(0, 'n', 'zj', ':lua NavigateFold("j")<CR>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', 'zk', ':lua NavigateFold("k")<CR>', { noremap = true, silent = true })
