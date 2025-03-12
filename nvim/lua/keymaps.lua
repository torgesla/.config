local kmap = vim.keymap

kmap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
--kmap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
kmap.set('n', '<leader>sv', '<cmd>source $MYVIMRC<CR>', { desc = 'Source VIM config' })

kmap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
kmap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
kmap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
kmap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
kmap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- vim: ts=2 sts=2 sw=2
