return {
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
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
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
    },
  },
}
