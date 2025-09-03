---@module 'lazy.core.spec'
---@type LazySpec[]
return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    opts = {
      complete_function_calls = true,
      expose_as_code_action = 'all',
      code_lens = 'all',
      include_completions_with_insert_text = true,
      single_file_support = false,
      jsx_close_tag = { enable = true, filetypes = { 'javascriptreact', 'typescriptreact' } },
    },
  },
}
