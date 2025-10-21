return {
  {
    'Bilal2453/luvit-meta',
    lazy = true,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp', 'folke/lazydev.nvim' },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        vim.lsp.enable(server, true)
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        vim.lsp.config(server, config)
      end
    end,

    -- EslintFixAll on save
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   -- pattern = { '*.js', '*.ts', '*.jsx', '*.tsx' },
    --   pattern = { '*.ts', '*.tsx' },
    --   command = 'EslintFixAll',
    -- })
    opts = {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
      servers = {
        emmylua_ls = {
          filetypes = { 'lua' },
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
        eslint = {},
        pyright = {},
        tailwindcss = {},
        -- vtsls = {
        --   filetypes = {
        --     'javascript',
        --     'javascriptreact',
        --     'javascript.jsx',
        --     'typescript',
        --     'typescriptreact',
        --     'typescript.tsx',
        --   },
        --   settings = {
        --     complete_function_calls = true,
        --     vtsls = {
        --       enableMoveToFileCodeAction = true,
        --       autoUseWorkspaceTsdk = true,
        --       experimental = {
        --         maxInlayHintLength = 30,
        --         completion = {
        --           enableServerSideFuzzyMatch = true,
        --         },
        --       },
        --     },
        --     typescript = {
        --       updateImportsOnFileMove = { enabled = 'always' },
        --       suggest = {
        --         completeFunctionCalls = true,
        --       },
        --       inlayHints = {
        --         enumMemberValues = { enabled = true },
        --         functionLikeReturnTypes = { enabled = true },
        --         parameterNames = { enabled = 'literals' },
        --         parameterTypes = { enabled = true },
        --         propertyDeclarationTypes = { enabled = true },
        --         variableTypes = { enabled = false },
        --       },
        --     },
        --   },
        -- },
      },
    },
  },
}
