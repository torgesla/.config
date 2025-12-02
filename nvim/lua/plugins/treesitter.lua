return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function(_, opts)
      -- require('nvim-treesitter.install').prefer_git = true
      require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {
      auto_install = true,
      ensure_installed = {
        'angular',
        'c',
        'css',
        'csv',
        'dockerfile',
        'go',
        'git_config',
        'java',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'prisma',
        'python',
        'query',
        'rust',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
      },

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
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
