return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    jump_to_single_result = true,
    defaults = {
      git_icons = false,
      file_icons = false,
      color_icons = false,
    },
    lsp = {
      code_actions = {
        previewer = 'codeaction_native',
        --preview_pager = 'delta --side-by-side --width=$FZF_PREVIEW_COLUMNS',
        preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
      },
    },
  },
  config = function(_, opts)
    require('fzf-lua').setup(opts)
  end,
  keys = {
    {
      '<leader><leader>',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Fzf Files',
    },
    {
      '<leader>e',
      function()
        require('fzf-lua').live_grep_native()
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
