return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<leader>v',
          node_incremental = '<leader><TAB>',
          scope_incremental = '<leader>sc',
          node_decremental = '<leader><S-TAB>',
        },
      },
      indent = { enable = true, disable = { 'ruby' } },
      config = function(_, opts)
        -- Prefer git instead of curl in order to improve connectivity in some environments
        require('nvim-treesitter.install').prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)
      end,

      textobjects = {
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
-- vim: ts=2 sts=2 sw=2 et
