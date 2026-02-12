return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  -- {
  --   'OXY2DEV/markview.nvim',
  --   enabled = false,
  --   lazy = false, -- Recommended
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini-icons' },
  --   opts = { preview = { icon_provider = 'mini' } },
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  -- },
}
