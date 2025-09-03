---@module 'lazy.core.spec'
---@type LazySpec[]
return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- Better Around/Inside textobjects
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Common configuration presets
      -- require('mini.basics').setup {}

      -- Remove buffers
      require('mini.bufremove').setup {}

      -- Autohighlight word under cursor
      require('mini.cursorword').setup {}

      -- Text edit operators
      -- require('mini.operators').setup {}
      --
      -- Autopairs
      require('mini.pairs').setup {}

      -- Add splitjoin functionality
      require('mini.splitjoin').setup { mappings = { toggle = '<leader>jl' } }

      -- saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- sd'   - [S]urround [D]elete [']quotes
      -- sr)'  - [S]urround [R]eplace [)] [']
      -- Add surround motions
      require('mini.surround').setup {}

      require('mini.misc').setup_termbg_sync()
    end,
  },
}
