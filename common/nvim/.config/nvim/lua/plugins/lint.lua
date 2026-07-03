return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'InsertLeave' },
    opts = {
      linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        python = { 'ruff' },
      },
    },
    config = function(_)
      local lint = require 'lint'
      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        python = { 'ruff' },
      }
      -- vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
      --   callback = function()
      --     lint.try_lint()
      --   end,
      -- })
    end,
  },
}
