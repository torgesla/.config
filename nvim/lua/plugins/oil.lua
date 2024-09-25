return {
  'stevearc/oil.nvim',
  cmd = 'Oil',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = { 'VimEnter */*,.*', 'BufNew */*,.*' },
  keys = {
    {
      '-',
      function()
        require('oil').open()
      end,
      desc = 'Open parent directory',
    },
    {
      '<leader>o',
      function()
        require('oil').open_float()
      end,
      desc = 'Open parent directory in floating window',
    },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
}
