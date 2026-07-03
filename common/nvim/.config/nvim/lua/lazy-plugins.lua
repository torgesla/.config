require('lazy').setup({
  --{
  --'vhyrro/luarocks.nvim',
  --priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  --config = true,
  --},
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { import = 'plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
