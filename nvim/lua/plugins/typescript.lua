return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commmentstring').setup { enable_autocmd = false }
    end,
  },
}
