local kmap = vim.keymap

kmap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
--kmap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
kmap.set('n', '<leader>sv', '<cmd>source $MYVIMRC<CR>', { desc = 'Source VIM config' })
kmap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Source VIM config' })

kmap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
kmap.set('n', 'c', '"_c', { desc = 'Change operation without overwriting clipboard' })

-- Keybinds to make split navigation easier.
kmap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
kmap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
kmap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
kmap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

kmap.set('n', '<C-d>', '<C-d>zz')
kmap.set('n', '<C-u>', '<C-u>zz')
kmap.set('n', '<C-f>', '<C-f>zz')
kmap.set('n', '<C-b>', '<C-b>zz')

-- kmap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Moves lines down in visual mode' })
-- kmap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Moves lines up in visual mode' })

kmap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down in buffer with cursor centered' })
kmap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up in buffer with cursor centered' })
kmap.set('n', 'n', 'nzzzv')
kmap.set('n', 'N', 'Nzzzv')

-- Tabs navigation
kmap.set('n', '<leader>to', '<cmd>tabnew<CR>') --open new tab
kmap.set('n', '<leader>tn', '<cmd>tabn<CR>') --go to next
kmap.set('n', '<leader>tp', '<cmd>tabp<CR>') --go to pre
-- kmap.set('n', '<leader>tf', '<cmd>tabnew %<CR>') --open current tab in new tab

--Split management
kmap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
-- Split window vertically
kmap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
-- Split window horizontally
kmap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
-- Close current split window
kmap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

kmap.set('n', 'Q', '<nop>')
kmap.set('n', 'U', '<nop>')

kmap.set('v', 'gs', "<cmd>'<,'>%sort<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- prevent x delete from registering when next paste
kmap.set('n', 'x', '"_x')
-- Replace the word cursor is on globally
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word cursor is on globally' })
