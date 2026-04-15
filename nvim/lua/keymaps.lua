local kmap = vim.keymap

kmap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- kmap.set({ 'i', 'x', 'n', 's' }, '<D-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
kmap.set('n', '<leader>cpa', ':let @+=expand("%:p")<CR>', { desc = 'Copy path (absolute)' })
kmap.set('n', '<leader>cpr', ':let @+=expand("%")<CR>', { desc = 'Copy path (relative)' })

kmap.set('n', 'grn', '<nop>')
kmap.set('n', 'gra', '<nop>')
kmap.set('n', 'grr', '<nop>')
kmap.set('n', 'gri', '<nop>')
kmap.set('n', 'grt', '<nop>')

-- kmap.set({ 'n', 'x' }, '<leader>ca', function()
--   require('tiny-code-action').code_action {}
-- end, { noremap = true, silent = true })
--
-- kmap.set('n', '<leader>ff', function()
--   require 'typescript-tools'
--   vim.cmd 'TSToolsAddMissingImports | TSToolsFixAll'
-- end, { desc = 'Add missing imports and fix all issues' })

--kmap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

kmap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })

kmap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

kmap.set('n', 'x', '"_x', { desc = 'Prevent x delete from registering when next paste' })
kmap.set('n', 'c', '"_c', { desc = 'Change operation without overwriting clipboard' })

-- Keybinds to make split navigation easier.
kmap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
kmap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
kmap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
kmap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

kmap.set('n', '<C-b>', '<C-b>zz', { desc = 'Move one page up and recenter cursor ' })
kmap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move half page down and recenter cursor ' })
kmap.set('n', '<C-f>', '<C-f>zz', { desc = 'Move one page down and recenter cursor ' })
kmap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move half page up and recenter cursor ' })
kmap.set('n', '<C-F>', '<C-F>zz', { desc = 'Move one page down and recenter cursor ' })
kmap.set('n', '<C-U>', '<C-U>zz', { desc = 'Move half page up and recenter cursor ' })
kmap.set('n', '<PgDown>', '<PgDown>zz', { desc = 'Move one page down and recenter cursor ' })
kmap.set('n', '<PgUp>', '<PgUp>zz', { desc = 'Move one page down and recenter cursor ' })

kmap.set('n', 'N', 'Nzzzv')
kmap.set('n', 'n', 'nzzzv')

-- Better J behavior
kmap.set('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position' })

-- kmap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Moves lines down in visual mode' })
-- kmap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Moves lines up in visual mode' })

-- Tabs navigation
kmap.set('n', '<leader>to', '<cmd>tabnew<CR>') --open new tab
kmap.set('n', '<leader>tn', '<cmd>tabn<CR>') --go to next
kmap.set('n', '<leader>tp', '<cmd>tabp<CR>') --go to pre

--Split management
-- kmap.set('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })
-- kmap.set('n', '<leader>sh', '<cmd>split<CR>', { desc = 'Split window horizontally' })

kmap.set('n', 'Q', '<nop>')
kmap.set('n', 'U', '<nop>')

kmap.set('n', '<Tab>', '<C-o>', { desc = 'Jump to previous location in jumplist' })
kmap.set('n', '<S-Tab>', '<C-i>', { desc = 'Jump to next location in jumplist' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank { timeout = 500 }
  end,
  -- group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  -- pattern = "*"
})

kmap.set('n', '<leader>d', function()
  vim.diagnostic.open_float()
end, { desc = 'Open diagnostic in floating window' })
-- vim.keymap.set('n', '<leader>d', function()
--   require('nvim-pretty-ts-errors').show_line_diagnostics()
-- end)

-- Replace the word cursor is on globally
-- kmap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word cursor is on globally' })

-- kmap.set('n', '<leader>ti', function()
--   require('custom-functions.').toggle_typescript_interface_type()
-- end, { desc = 'Toggle TypeScript interface/type' })

-- Node specific
local build_win = nil
kmap.set('n', '<leader>bn', function()
  if build_win and vim.api.nvim_win_is_valid(build_win) then
    vim.api.nvim_win_call(build_win, function()
      vim.cmd 'close'
    end)
    build_win = nil
  else
    vim.cmd 'split'
    vim.cmd 'wincmd j'
    vim.cmd 'terminal npm run build'
    build_win = vim.api.nvim_get_current_win()
    vim.cmd 'normal! G'
    vim.cmd 'wincmd k'
  end
end, { desc = 'Toggle npm build in bottom split' })
