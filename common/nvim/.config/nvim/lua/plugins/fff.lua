return {
  'dmtrKovalenko/fff.nvim',
  build = function()
    require('fff.download').download_or_build_binary()
  end,
  lazy = false,
  ---@module 'fff'
  opts = {
    -- keep defaults; grep supports plain/regex/fuzzy modes, git-status aware
  },
  keys = {
    {
      '<leader>e',
      function()
        require('fff').find_files()
      end,
      desc = 'Find smart file',
    },
    {
      '<leader>fd',
      function()
        require('fff').find_files_in_dir(vim.fn.expand '%:p:h')
      end,
      desc = 'Find files in current dir',
    },
    {
      '<leader>fw',
      function()
        require('fff').live_grep_under_cursor()
      end,
      mode = { 'n', 'x' },
      desc = 'Grep word/selection under cursor',
    },
    {
      '<leader>s',
      function()
        require('fff').live_grep()
      end,
      desc = 'Fzf search in project',
    },
  },
}
