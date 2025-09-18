return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function(_, opts)
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {
      auto_install = true,
      ensure_installed = 'all',
      ignore_install = { 'ipkg' },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<Enter>',
          node_incremental = '<Enter>',
          node_decremental = '<Backspace>',
          scope_incremental = false,
        },
      },
      indent = { enable = true, disable = { 'ruby' } },
      textobjects = {
        enable = false,
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['if'] = '@function.inner',
            ['af'] = '@function.outer',
            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'v', -- charwise
          },
          include_surrounding_whitespace = true,
        },
      },
    },
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
}
