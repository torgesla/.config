return {
  { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'folke/tokyonight.nvim', name = 'tokyonight' },
  { 'ellisonleao/gruvbox.nvim', name = 'gruvbox' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'EdenEast/nightfox.nvim', name = 'nightfox' },
  { 'navarasu/onedark.nvim', name = 'onedark' },
  { 'Mofiqul/dracula.nvim', name = 'dracula' },
  { 'craftzdog/solarized-osaka.nvim', name = 'solarized-osaka' },
  { 'marko-cerovac/material.nvim', name = 'material' },
  { 'maxmx03/solarized.nvim', name = 'solarized' },
  --  { 'Tsuzat/NeoSolarized.nvim', name = 'neo-solarized', opts = { style = 'dark', transparent = false } },
  {
    'oxfist/night-owl.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme night-owl'
    end,
  },
}
