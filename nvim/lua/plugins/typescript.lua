return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      on_attach = function(client, bufnr)
        require('twoslash-queries').attach(client, bufnr)
      end,
      -- handlers = {
      --   ['textDocument/publishDiagnostics'] = function() end,
      -- },
      settings = {
        tsserver_file_preferences = {
          importModuleSpecifierEnding = 'minimal',
        },
        complete_function_calls = true,
        expose_as_code_action = 'all',
        code_lens = 'off',
        include_completions_with_insert_text = true,
        jsx_close_tag = {
          enable = true,
          filetypes = { 'javascriptreact', 'typescriptreact' },
        },
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
  {
    'marilari88/twoslash-queries.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {
      multi_line = true,
      is_enabled = true,
    },
    keys = {
      {
        '<C-k>',
        '<cmd>TwoslashQueriesInspect<CR>',
        desc = 'Twoslash: inspect type',
      },
    },
  },
}
