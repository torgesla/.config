---@type vim.lsp.Config
return {
  cmd = { 'fallow-lsp' },
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  root_markers = { '.fallowrc.json', 'package.json', '.git' },
  init_options = {
    issueTypes = {
      ['circular-dependencies'] = false,
    },
  },
}
