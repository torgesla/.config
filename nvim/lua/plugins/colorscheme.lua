return {
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme kanagawa-wave'
    end,
  },
  {
    'catppuccin/nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme catppuccin-mocha'
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd 'colorscheme tokyonight-night'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'oxfist/night-owl.nvim',
    enabled = true,
    lazy = false, 
    priority = 1000, 
    config = function()
      vim.cmd 'colorscheme night-owl'
    end,
  },
}
