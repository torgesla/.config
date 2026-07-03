return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = function(ctx)
        return ctx.plugin and 0 or 500
      end,
    },
  },
}
