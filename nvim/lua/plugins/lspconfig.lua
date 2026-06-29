return {
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks', 'snacks' } },
      },
    },
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
        -- Full emmylua_ls config (correct `emmylua` settings schema) lives in
        -- after/lsp/emmylua_ls.lua; here we only enable it.
        emmylua_ls = {},
        eslint = {},
        fallow = {},
        gopls = {},
        oxfmt = {},
        oxlint = {},
        jsonls = {},
        marksman = {},
        -- lua_ls disabled — using emmylua_ls as the single Lua server. Re-enable
        -- this block (and disable emmylua_ls) to switch back.
        -- copilot = {
        --   on_attach = function(client, bufnr)
        --     if client:supports_method('textDocument/inlineCompletion', bufnr) then
        --       vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
        --     end
        --   end,
        -- },
        prismals = {},
        pyright = {},
        tailwindcss = {},
        typos_lsp = {
          filetypes = { '*', 'oil' },
        },
        -- tsgo = {
        --   filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
        --   on_attach = function(client, _)
        --     -- diagnostics-only: ts_ls + typescript-tools handle all other capabilities
        --     client.server_capabilities = {}
        --   end,
        -- },
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                kubernetes = '*.yaml',
                ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
                ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
                ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
                ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
                ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
                ['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
                ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
                ['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
                ['https://json.schemastore.org/gitlab-ci'] = '*gitlab-ci*.{yml,yaml}',
                ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
                ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
              },
            },
          },
        },
      },
    },
  },
}
