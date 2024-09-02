local map = vim.keymap

-- Clear highlights on search when pressing <Esc> in normal mode
map.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
map.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
map.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Fzf lua
map.set('n', '<leader>e', ":lua require('fzf-lua').files()<cr>", { desc = 'Fzf Files' })
map.set('n', '<leader>se', ":lua require('fzf-lua').grep_project()<cr>", { desc = 'Fzf Files' })
map.set('n', '<leader>w', ':w<cr>', { desc = 'Write buffer' })
map.set('n', '<leader><leader>', function()
  require('oil').open_float()
end)

map.set('n', '<leader>t', '<cmd>ToggleTerm direction=float <cr>', { desc = 'Floating terminal' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
