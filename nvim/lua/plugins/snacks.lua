return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    image = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      '<leader><leader>',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Fzf Recent Files',
    },
    {
      '<leader>e',
      function()
        Snacks.picker.files()
      end,
      desc = 'Fzf Files',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Fzf search in project',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Fzf search in project',
    },
  },
}
