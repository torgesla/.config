local function enable_transparency()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
end

-- night-owl.nvim hasn't mapped the new treesitter capture names from nvim-treesitter main.
-- These bridge the gap using night-owl's own palette colours.
local function fix_treesitter_captures()
  local p = require 'night-owl.palette'
  local hl = vim.api.nvim_set_hl
  -- @field was renamed to @variable.member
  hl(0, '@variable.member', { fg = p.cyan5 })
  -- @parameter was renamed to @variable.parameter (already in theme but ensure it)
  hl(0, '@variable.parameter', { fg = p.parameter })
  -- @namespace → @module (generic module/namespace)
  hl(0, '@module', { fg = p.orange2, italic = true })
  -- method calls (was @method)
  hl(0, '@function.method', { fg = p.blue })
  hl(0, '@function.method.call', { fg = p.blue })
  -- keyword subtypes new in treesitter main
  hl(0, '@keyword.modifier', { link = 'Statement' }) -- static, readonly, abstract, etc.
  hl(0, '@keyword.type', { link = 'Statement' }) -- type, interface, enum keywords
  hl(0, '@keyword.import', { link = 'Statement' })
  hl(0, '@keyword.exception', { link = 'Statement' })
  hl(0, '@keyword.conditional', { link = 'Statement' })
  -- @string.special subtypes
  hl(0, '@string.special', { fg = p.cyan })
  hl(0, '@string.regexp', { fg = p.blue }) -- @string.regex renamed
  -- @number / @float
  hl(0, '@number', { fg = p.orange })
  hl(0, '@number.float', { fg = p.orange })
  -- @comment.documentation (jsdoc style)
  hl(0, '@comment.documentation', { fg = p.gray6, italic = true })
  -- @punctuation subtypes
  hl(0, '@punctuation.special', { fg = p.cyan2 })
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
      fix_treesitter_captures()
    end,
  },
}
