return {
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    enabled = false,
    opts = { use_default_keymaps = false, max_join_length = 1000 },
    keys = {
      {
        '<leader>jl',
        function()
          require('treesj').toggle()
        end,
        'Toggle [J]oin [L]ines',
      },
    },
  },
}
