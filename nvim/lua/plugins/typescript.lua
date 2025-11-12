return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      complete_function_calls = true,
      expose_as_code_action = 'all',
      code_lens = 'all',
      include_completions_with_insert_text = true,
      jsx_close_tag = {
        enable = true,
        filetypes = { 'javascriptreact', 'typescriptreact' },
      },
    },
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {},
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {},
    -- config = function()
    --   require('ts_context_commmentstring').setup { enable_autocmd = false }
    -- end,
  },
}
