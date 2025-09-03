---@module 'lazy.core.spec'
---@type LazySpec[]
return {
  {
    'm4xshen/hardtime.nvim',
    enabled = true,
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      disabled_keys = {
        ['<Up>'] = false,
        ['<Down>'] = false,
        ['<Left>'] = false,
        ['<Right>'] = false,
        -- ['h'] = { '' },
        -- ['j'] = { '' },
        -- ['k'] = { '' },
        -- ['l'] = { '' },
      },
      disable_mouse = false,
      restricted_keys = {
        ['h'] = false,
        ['j'] = false,
        ['k'] = false,
        ['l'] = false,
      },
    },
    keys = {
      {
        '<leader>ht',
        function()
          require('hardtime').toggle()
        end,
        desc = 'Hardtime toggle',
      },
    },
  },
}
