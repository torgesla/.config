-- return {
--   'folke/trouble.nvim',
--   opts = {}, -- for default options, refer to the configuration section for custom setup.
--   cmd = 'Trouble',
--   keys = {
--     {
--       '<leader>xx',
--       '<cmd>Trouble diagnostics toggle<cr>',
--       desc = 'Diagnostics (Trouble)',
--     },
--     {
--       '<leader>xX',
--       '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
--       desc = 'Buffer Diagnostics (Trouble)',
--     },
--     {
--       '<leader>cs',
--       '<cmd>Trouble symbols toggle focus=false<cr>',
--       desc = 'Symbols (Trouble)',
--     },
--     {
--       '<leader>cl',
--       '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
--       desc = 'LSP Definitions / references / ... (Trouble)',
--     },
--     {
--       '<leader>xL',
--       '<cmd>Trouble loclist toggle<cr>',
--       desc = 'Location List (Trouble)',
--     },
--     {
--       '<leader>xQ',
--       '<cmd>Trouble qflist toggle<cr>',
--       desc = 'Quickfix List (Trouble)',
--     },
--   },
-- }

return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    opts = { preset = 'modern' },
    config = function(_, opts)
      require('tiny-inline-diagnostic').setup(opts)
      vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    specs = {
      'folke/snacks.nvim',
      opts = function(_, opts)
        return vim.tbl_deep_extend('force', opts or {}, {
          picker = {
            actions = require('trouble.sources.snacks').actions,
            win = { input = { keys = { ['<c-t>'] = { 'trouble_open', mode = { 'n', 'i' } } } } },
          },
        })
      end,
    },
    keys = {
      {
        '<leader>xx',
        -- function()
        --   require('trouble').diagnostics.toggle { focus = true }
        -- end,
        '<cmd>Trouble diagnostics toggle focus=true<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>qq',
        '<cmd>Trouble qflist toggle<cr>',
        -- function()
        --   require('trouble').qflist.toggle()
        -- end,
        desc = 'Quickfix list (Trouble)',
      },

      -- {
      --   '<leader>xX',
      --   '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      --   desc = 'Buffer Diagnostics (Trouble)',
      -- },
      -- {
      --   '<leader>cs',
      --   '<cmd>Trouble symbols toggle focus=false<cr>',
      --   desc = 'Symbols (Trouble)',
      -- },
      -- {
      --   '<leader>cl',
      --   '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      --   desc = 'LSP Definitions / references / ... (Trouble)',
      -- },
      -- {
      --   '<leader>xL',
      --   '<cmd>Trouble loclist toggle<cr>',
      --   desc = 'Location List (Trouble)',
      -- },
      -- {
      --   '<leader>xQ',
      --   '<cmd>Trouble qflist toggle<cr>',
      --   desc = 'Quickfix List (Trouble)',
      -- },
    },
  },
}
