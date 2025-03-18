return {
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    event = { 'BufWritePre' },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'markdownlint', stop_after_first = true },
      },
      format_on_save = {
        lsp_fallback = 'fallback',
        timeout_ms = 500,
      },
    },
  },
}
