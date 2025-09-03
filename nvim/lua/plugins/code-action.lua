---@module 'lazy.core.spec'
---@type LazySpec[]
return {
  {
    'rachartier/tiny-code-action.nvim',
    enabled = false,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'folke/snacks.nvim', opts = { terminal = {} } },
    },
    event = 'LspAttach',
    opts = { picker = 'snacks' },
    keys = {
      {
        '<leader>ca',
        function(_, opts)
          require('tiny-code-action').code_action(opts)
        end,
        'Code actions',
      },
    },
  },
  -- {
  --   'ThePrimeagen/refactoring.nvim',
  --   lazy = true,
  --   ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'lua', 'c', 'cpp', 'go', 'python', 'java', 'php' },
  --   event = 'BufReadPost',
  --   config = function()
  --     require('refactoring').setup {}
  --   end,
  -- },
}
