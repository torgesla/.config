---@type LazySpec[]
return {
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    event = { 'BufWritePre' },
    config = function(_, opts)
      require('conform').setup(opts)
      -- Restart prettierd daemon when a prettier config file is saved so it picks up the new config.
      -- Without this, the daemon caches "no config" for a project and ignores newly added config files.
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = {
          '.prettierrc',
          '.prettierrc.json',
          '.prettierrc.yml',
          '.prettierrc.yaml',
          '.prettierrc.json5',
          '.prettierrc.js',
          '.prettierrc.cjs',
          '.prettierrc.mjs',
          '.prettierrc.toml',
          'prettier.config.js',
          'prettier.config.cjs',
          'prettier.config.mjs',
        },
        callback = function()
          vim.fn.system('prettierd stop')
          vim.notify('prettierd restarted (config changed)', vim.log.levels.INFO)
        end,
        desc = 'Restart prettierd when prettier config changes',
      })
    end,
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        go = { 'goimports', 'gofmt' },
        javascript = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
        lua = { 'stylua', stop_after_first = true },
        markdown = { 'markdownlint-cli2', 'prettierd', 'prettier' },
        python = { 'ruff' },
        rust = { 'rustfmt' },
        typescript = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },

        ['_'] = { 'prettierd', 'prettier' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters = {
        oxfmt = {
          command = 'oxc',
          args = { 'format', '--stdin', '--stdin-filename', '$FILENAME' },
          stdin = true,
          condition = function(self, ctx)
            local root = vim.fs.root(ctx.buf, { 'package.json' })
            if not root then
              return false
            end
            local package_json = vim.fn.readfile(root .. '/package.json')
            local content = vim.fn.join(package_json, '\n')
            return content:match('"oxc"') or content:match('"@oxc[-/]')
          end,
        },
        -- eslint_d = {
        --   command = 'eslint_d',
        --   args = { '--fix' },
        -- },
      },
    },
  },
}
