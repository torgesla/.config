return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<leader><leader>',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Fzf Files',
    },
    {
      '<leader>e',
      function()
        require('fzf-lua').grep_project()
      end,
      desc = 'Fzf search in project',
    },
    {
      '<leader>/',
      function()
        require('fzf-lua').blines()
      end,
    },
  },
}
