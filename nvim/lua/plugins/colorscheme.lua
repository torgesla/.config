local function enable_transparency()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
end

---@module 'lazy.core.spec'
---@type LazySpec[]
return {
  { 'EdenEast/nightfox.nvim', lazy = true },
  { 'Mofiqul/dracula.nvim', lazy = true },
  { 'abreujp/scholar.nvim', lazy = true },
  { 'catppuccin/nvim', lazy = true },
  { 'craftzdog/solarized-osaka.nvim', lazy = true },
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  { 'folke/tokyonight.nvim', lazy = true },
  { 'marko-cerovac/material.nvim', lazy = true },
  { 'maxmx03/solarized.nvim', lazy = true },
  { 'navarasu/onedark.nvim', lazy = true },
  { 'rebelot/kanagawa.nvim', lazy = true },
  { 'rose-pine/neovim', lazy = true },
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
