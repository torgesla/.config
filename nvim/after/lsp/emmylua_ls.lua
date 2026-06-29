-- emmylua_ls (emmylua-analyzer-rust) uses its OWN settings schema, nested under
-- `emmylua` — NOT the lua_ls `Lua` schema. It also does not honor lazydev's
-- workspace/configuration library injection in Neovim (that pull only happens
-- under VSCode), so the Neovim runtime must be added here via workspace.library.
-- Schema reference: nvim-lspconfig/lsp/emmylua_ls.lua.
return {
  cmd = { 'emmylua_ls' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.emmyrc.json', '.luacheckrc', '.git' },
  workspace_required = false,
  on_init = function(client)
    -- If a project has its own .emmyrc.json/.luarc.json, defer to it — but
    -- always apply these settings to the Neovim config dir itself.
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath 'config'
        and (vim.uv.fs_stat(path .. '/.emmyrc.json') or vim.uv.fs_stat(path .. '/.luarc.json'))
      then
        client.config.settings = {}
      end
    end
  end,
  settings = {
    emmylua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim', 'require' } },
      codeLens = { enable = true },
      hint = { enable = true },
      -- Make the server aware of the Neovim runtime (defines `vim` + the API).
      -- VIMRUNTIME only — pulling all of 'runtimepath' can stack-overflow emmylua
      -- when the workspace IS the Neovim config dir (upstream issue #674).
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          vim.api.nvim_get_runtime_file('lua/lspconfig', false)[1],
        },
      },
    },
  },
}
