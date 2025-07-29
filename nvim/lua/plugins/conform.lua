return {
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    event = { 'BufWritePre' },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier' },
        javascriptreact = { 'prettierd', 'prettier' },
        lua = { 'stylua' },
        markdown = { 'markdownlint-cli2', 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        typescriptreact = { 'prettierd', 'prettier' },

        ['*'] = { 'prettierd', 'prettier' },
      },
      format_on_save = {
        lsp_fallback = 'fallback',
        timeout_ms = 500,
      },
    },
  },
}
