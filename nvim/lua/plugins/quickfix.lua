return {
  {
    'stevearc/quicker.nvim',
    enabled = false,
    ft = 'qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    keys = {
      {
        '<leader>qq',
        function()
          require('quicker').toggle()
        end,
      },
      {
        '<leader>QQ',
        function()
          require('quicker').toggle { loclist = true }
        end,
      },
    },
  },
}
