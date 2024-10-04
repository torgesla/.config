return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  opts = { single_file_support = false },
}
