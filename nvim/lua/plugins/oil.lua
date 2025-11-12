return {
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    enabled = true,
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'VimEnter */*,.*', 'BufNew */*,.*' },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
      win_options = { signcolumn = 'yes:2' },
    },
    keys = {
      {
        '<leader>o',
        function()
          require('oil').open()
        end,
        desc = 'Open parent directory',
      },
      {
        '-',
        function()
          require('oil').open()
        end,
        desc = 'Open parent directory',
      },

      -- {
      --   '<leader>o',
      --   function()
      --     require('oil').open_float()
      --   end,
      --   desc = 'Open parent directory in floating window',
      -- },
    },
  },
  -- {
  --   'refractalize/oil-git-status.nvim',
  --   dependencies = { 'stevearc/oil.nvim' },
  --   opts = {},
  -- },
}
