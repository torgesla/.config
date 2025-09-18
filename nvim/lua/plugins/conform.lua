---@module 'lazy.core.spec'
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

        -- ['*'] = { 'prettierd', 'prettier' },
        ['_'] = { 'prettierd', 'prettier' },
      },
      format_on_save = {
        -- Removed the 'filter' function to allow all configured formatters to run on save.
        -- The default behavior is usually what you want for this setup.
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      -- Added the 'formatters' table to configure the eslint formatter specifically.
      formatters = {
        -- -- eslint_fallback = {
        -- --   command = find_eslint,
        -- --   args = { '--fix' },
        -- -- },
        -- eslint = {
        --   command = 'eslint',
        --   args = { '--fix' },
        -- },
        -- eslint_d = {
        --   command = 'eslint_d',
        --   args = { '--fix' },
        -- },
      },
    },
  },
}

-- local function find_eslint()
--   -- Check for local eslint_d in node_modules
--   local local_eslint = vim.fn.findfile("node_modules/.bin/eslint_d", vim.fn.getcwd())
--   if local_eslint ~= "" then
--     return local_eslint
--   end
--
--   -- Fallback to global eslint_d if local is not found
--   local global_eslint = vim.fn.exepath("eslint_d")
--   if global_eslint ~= "" then
--     return global_eslint
--   end
--
--   -- As a last resort, fall back to global eslint
--   local global_eslint_fallback = vim.fn.exepath("eslint")
--   if global_eslint_fallback ~= "" then
--     return global_eslint_fallback
--   end
--
--   -- Return nil if nothing is found
--   return nil
-- end
