return {
  { 'nvim-mini/mini.ai', opts = { n_lines = 500 } },
  { 'nvim-mini/mini.icons' },
  {
    'nvim-mini/mini.misc',
    setup = function()
      require('nvim-mini/mini.misc').setup_termbg_sync()
    end,
  },
  { 'nvim-mini/mini.bufremove', opts = {} },
  { 'nvim-mini/mini.cursorword', opts = {} },
  {
    'nvim-mini/mini.pick',
    opts = {},
    keys = {
      {
        '<leader>mp',
        function()
          require('mini.pick').builtin.grep()
        end,
      },
    },
  },
  {
    'nvim-mini/mini.splitjoin',
    opts = {},
    keys = {
      {
        '<leader>jj',
        function()
          require('mini.splitjoin').toggle()
        end,
      },
    },
  },
  { 'nvim-mini/mini.surround', opts = {} },
  {
    'nvim-mini/mini.comment',
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    'nvim-mini/mini.files',
    enabled = false,
    opts = {
      options = {
        permanent_delete = false,
        use_as_default_explorer = false,
      },
    },
    keys = {
      {
        '-',
        function()
          require('mini.files').open()
        end,
        desc = 'Open mini files',
      },
    },
  },

  -- {
  --   -- Collection of various small independent plugins/modules
  --   'nvim-mini/mini.nvim',
  --   version = false,
  --   config = function()
  --     require('mini.misc').setup_termbg_sync()
  --   end,
  --   -- keys = {
  --   --   {
  --   --     '-',
  --   --     function()
  --   --       require('mini.files').open()
  --   --     end,
  --   --     desc = 'Open mini files',
  --   --   },
  --   -- },
  -- },
}
