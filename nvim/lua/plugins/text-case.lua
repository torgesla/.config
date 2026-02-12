return {
  {
    'johmsalas/text-case.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      default_keymappings_enabled = false,
    },
    keys = {
      {
        'gtc',
        '<CMD>TextCaseOpenTelescopeLSPChange<CR>',
        desc = 'Change case of text',
      },
    },
  },
}
