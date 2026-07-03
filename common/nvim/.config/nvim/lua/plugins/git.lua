---@module 'lazy.core.spec'
---@type LazySpec[]
return {
  { -- Git plugin
    'tpope/vim-fugitive',
    opts = {},
    keys = {
      { '<leader>gb', '<cmd>Git blame<cr>', 'Git blame' },
    },
  },
}
