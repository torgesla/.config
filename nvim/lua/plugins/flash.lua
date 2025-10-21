---@module 'lazy.core.spec'
---@type LazySpec[]
return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    keys = {
      -- {
      --   's',
      --   mode = { 'n', 'x', 'o' },
      --   function()
      --     require('flash').jump()
      --   end,
      --   desc = 'Flash',
      -- },
      {
        'r',
        mode = { 'o' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter search',
      },
      {
        'R',
        mode = { 'o' },
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
    },
  },
}
