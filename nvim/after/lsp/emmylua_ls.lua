return {
  cmd = { 'emmylua_ls' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.emmyrc.json', '.luacheckrc', '.git' },
  settings = {
    Lua = {
      completion = { callSnippet = 'Replace' },
      diagnostics = { globals = { 'vim', 'require' } },
      runtime = { version = 'LuaJIT' },
      telemetry = { enable = false },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
    },
  },
  workspace_required = false,
}
