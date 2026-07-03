return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  enabled = false,
  opts = {
    useLspFoldsWithTreesitterFallback = true,
    pauseFoldsOnSearch = true,
    foldtext = {
      enabled = true,
      padding = 3,
      lineCount = {
        template = '%d lines',
        hlgroup = 'Comment',
      },
      diagnosticsCount = true,
      gitsignsCount = true,
      disableOnFt = { 'snacks_picker_input' },
    },
    autoFold = {
      enabled = true,
      kinds = { 'comment' }, --'imports' },
    },
    foldKeymaps = {
      setup = true,
      closeOnlyOnFirstColumn = false,
      scrollLeftOnCaret = false,
    },
  },
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
