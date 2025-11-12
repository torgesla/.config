---@type LazySpec[]
return {
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    event = { 'BufWritePre' },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        go = { 'goimports', 'gofmt' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        lua = { 'stylua', stop_after_first = true },
        markdown = { 'markdownlint-cli2', 'prettierd', 'prettier' },
        python = { 'ruff' },
        rust = { 'rustfmt' },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },

        ['_'] = { 'prettierd', 'prettier' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters = {
        -- eslint_d = {
        --   command = 'eslint_d',
        --   args = { '--fix' },
        -- },
      },
    },
  },
}
