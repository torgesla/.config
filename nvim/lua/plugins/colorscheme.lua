local function enable_transparency()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
end

---@module 'lazy.core.spec'
---@type LazySpec[]
return {
  { 'EdenEast/nightfox.nvim' },
  { 'Mofiqul/dracula.nvim' },
  { 'abreujp/scholar.nvim' },
  { 'catppuccin/nvim' },
  { 'craftzdog/solarized-osaka.nvim' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'folke/tokyonight.nvim' },
  { 'marko-cerovac/material.nvim' },
  { 'maxmx03/solarized.nvim' },
  { 'navarasu/onedark.nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'rose-pine/neovim' },
  {
    'oxfist/night-owl.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require('night-owl').setup(opts)
      vim.cmd 'colorscheme night-owl'
      enable_transparency()
    end,
  },
}
