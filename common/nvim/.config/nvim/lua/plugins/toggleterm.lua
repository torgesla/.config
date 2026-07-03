return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    direction = 'float',
  },
  keys = {
    {
      '<leader>tt',
      function()
        require('toggleterm').toggle()
      end,
      desc = 'Floating terminal',
    },
  },
}
