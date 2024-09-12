return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('fzf-lua').setup {}

    vim.keymap.set('n', '<leader><leader>', ":lua require('fzf-lua').files()<cr>", { desc = 'Fzf Files' })
    vim.keymap.set('n', '<leader>E', ":lua require('fzf-lua').grep_project()<cr>", { desc = 'Fzf search in project' })
    vim.keymap.set('n', '<leader>w', ':w<cr>', { desc = 'Write buffer' })
  end,
}
