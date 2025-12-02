return {
  {
    'OXY2DEV/markview.nvim',
    enabled = false,
    lazy = false, -- Recommended
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini-icons' },
    opts = { preview = { icon_provider = 'mini' } },
    -- ft = "markdown" -- If you decide to lazy-load anyway
  },
}
