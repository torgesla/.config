return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    direction = 'float',
  },
  keys = {
    {
      '<leader>t',
      function()
        require('toggleterm').toggle()
      end,
      desc = 'Floating terminal',
    },
  },
}
