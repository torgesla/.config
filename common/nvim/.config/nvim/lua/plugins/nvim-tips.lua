return {
  {
    'm4xshen/hardtime.nvim',
    enabled = true,
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      disabled_keys = {
        ['<Up>'] = false,
        ['<Down>'] = false,
        ['<Left>'] = false,
        ['<Right>'] = false,
      },
      disable_mouse = true,
      restricted_keys = {
        ['h'] = { 'n', 'x' },
        ['j'] = false,
        ['k'] = false,
        ['l'] = { 'n', 'x' },
      },
      restriction_mode = 'hint',
      max_count = 5,
    },
    keys = {
      {
        '<leader>ht',
        function()
          require('hardtime').toggle()
        end,
        desc = 'Hardtime toggle',
      },
    },
  },
  -- {
  --   'shahshlok/vim-coach.nvim',
  --   dependencies = { 'folke/snacks.nvim' },
  --   config = function()
  --     require('vim-coach').setup()
  --   end,
  --   keys = {
  --     { '<leader>?', '<cmd>VimCoach<cr>', desc = 'Vim Coach' },
  --   },
  -- },
  -- {
  --   'saxon1964/neovim-tips',
  --   version = '*', -- Only update on tagged releases
  --   dependencies = {
  --     'MunifTanjim/nui.nvim',
  --     'MeanderingProgrammer/render-markdown.nvim',
  --   },
  --   opts = {
  --     -- OPTIONAL: Location of user defined tips (default value shown below)
  --     user_file = vim.fn.stdpath 'config' .. '/neovim_tips/user_tips.md',
  --     -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
  --     user_tip_prefix = '[User] ',
  --     -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
  --     warn_on_conflicts = true,
  --     -- 0 = off, 1 = once per day, 2 = every startup
  --     daily_tip = 2,
  --   },
  --   init = function()
  --     -- OPTIONAL: Change to your liking or drop completely
  --     -- The plugin does not provide default key mappings, only commands
  --     local map = vim.keymap.set
  --     map('n', '<leader>nto', ':NeovimTips<CR>', { desc = 'Neovim tips', noremap = true, silent = true })
  --     map('n', '<leader>nte', ':NeovimTipsEdit<CR>', { desc = 'Edit your Neovim tips', noremap = true, silent = true })
  --     map('n', '<leader>nta', ':NeovimTipsAdd<CR>', { desc = 'Add your Neovim tip', noremap = true, silent = true })
  --     map('n', '<leader>nth', ':help neovim-tips<CR>', { desc = 'Neovim tips help', noremap = true, silent = true })
  --     map('n', '<leader>ntr', ':NeovimTipsRandom<CR>', { desc = 'Show random tip', noremap = true, silent = true })
  --     map('n', '<leader>ntp', ':NeovimTipsPdf<CR>', { desc = 'Open Neovim tips PDF', noremap = true, silent = true })
  --   end,
  -- },
}
