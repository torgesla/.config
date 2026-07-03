return {
  'chrisgrieser/nvim-rulebook',
  event = 'LspAttach',
  keys = {
    {
      '<leader>ri',
      function()
        require('rulebook').ignoreRule()
      end,
      desc = 'Rulebook: Ignore rule',
    },
    {
      '<leader>rl',
      function()
        require('rulebook').lookupRule()
      end,
      desc = 'Rulebook: Lookup rule',
    },
    {
      '<leader>ry',
      function()
        require('rulebook').yankDiagnosticCode()
      end,
      desc = 'Rulebook: Yank diagnostic code',
    },
    {
      '<leader>rf',
      function()
        require('rulebook').suppressFormatter()
      end,
      mode = { 'n', 'x' },
      desc = 'Rulebook: Suppress formatter',
    },
  },
  config = function()
    require('rulebook').setup {
      ignoreComments = {
        typescript = {
          comment = '// @ts-expect-error %s',
          location = 'prevLine',
        },
        typescriptreact = {
          comment = '// @ts-expect-error %s',
          location = 'prevLine',
        },
        javascript = {
          comment = '// @ts-expect-error %s',
          location = 'prevLine',
        },
        javascriptreact = {
          comment = '// @ts-expect-error %s',
          location = 'prevLine',
        },
      },
    }

    -- Add prettifyError keymap for TypeScript files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      group = vim.api.nvim_create_augroup('rulebook.prettify-ts-error', { clear = true }),
      callback = function(ctx)
        vim.keymap.set('n', '<leader>rp', function()
          require('rulebook').prettifyError()
        end, { buffer = ctx.buf, desc = 'Rulebook: Prettify TypeScript error' })
      end,
    })
  end,
}
