return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  enabled = false,
  cmd = { 'FzfLua' },
  opts = {
    defaults = {
      git_icons = false,
      file_icons = false,
      color_icons = false,
    },
    lsp = {
      code_actions = {
        previewer = 'codeaction_native',
        preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
      },
      formatter = 'path.filename_first',
      jump_to_single_result = true,
    },
    oldfiles = {
      cwd_only = true,
      formatter = 'path.filename_first',
    },
    files = {
      formatter = 'path.filename_first',
    },
  },
  keys = {
    {
      '<leader><leader>',
      function()
        require('fzf-lua').oldfiles {
          cwd_only = function()
            return vim.api.nvim_command 'pwd' ~= vim.env.HOME
          end,
        }
      end,
      desc = 'Fzf Recent Files',
    },
    {
      '<leader>e',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Fzf Files',
    },
    {
      '<leader>f',
      function()
        require('fzf-lua').live_grep_native { resume = true }
      end,
      desc = 'Fzf search in project',
    },
    {
      '<leader>/',
      function()
        require('fzf-lua').lgrep_curbuf()
      end,
      desc = 'Search in current buffer',
    },
  },
}
