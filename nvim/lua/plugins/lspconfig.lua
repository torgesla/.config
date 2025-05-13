return {
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require 'lspconfig'
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
      -- EslintFixAll on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.js', '*.ts', '*.jsx', '*.tsx' },
        command = 'EslintFixAll',
      })
    end,
    opts = {
      servers = {
        eslint = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim', 'require' } },
              runtime = { version = 'LuaJIT' },
              telemetry = { enable = false },
              workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            },
          },
        },
      },
    },
  },
}
