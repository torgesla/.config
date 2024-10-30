return {
  'nvimtools/none-ls.nvim',
  enabled = false,
  opts = function()
    local none_ls = require 'null-ls'

    return {
      sources = {
        none_ls.builtins.formatting.stylua,
        none_ls.builtins.completion.spell,
      },
    }
  end,
}
