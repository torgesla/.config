return {
  {
    'rmagatti/auto-session',
    opts = {
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { '~/', '~/Downloads', '~/Documents', '~/Desktop/' },
    },
    keys = {
      { '<leader>wr', '<cmd>SessionRestore<CR>' },
      { '<leader>ws', '<cmd>SessionSave<CR>' },
    },
  },
}
