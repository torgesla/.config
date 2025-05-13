return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true, replace_netrw = false, layout = { cycle = false } },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    picker = {
      enabled = true,
      matchers = {
        frecency = true,
        cwd_bonus = true,
      },
      formatters = {
        file = {
          filename_first = true,
          filename_only = false,
          icon_width = 2,
        },
      },
      layout = { preset = 'select', cycle = false },
      layouts = {
        select = {
          preview = 'main',
          layout = {
            backdrop = false,
            width = 0.6,
            min_width = 80,
            height = 0.4,
            min_height = 10,
            box = 'vertical',
            border = 'rounded',
            title = '{title}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
            { win = 'preview', title = '{preview}', width = 0.6, height = 0.4, border = 'top' },
          },
        },
        telescope = {
          reverse = false, -- set to false for search bar to be on top
          layout = {
            box = 'horizontal',
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = 'none',
            {
              box = 'vertical',
              { win = 'list', title = ' Results ', title_pos = 'center', border = 'rounded' },
              { win = 'input', height = 1, border = 'rounded', title = '{title} {live} {flags}', title_pos = 'center' },
            },
            {
              win = 'preview',
              title = '{preview:Preview}',
              width = 0.50,
              border = 'rounded',
              title_pos = 'center',
            },
          },
        },
        ivy = {
          layout = {
            box = 'vertical',
            backdrop = false,
            width = 0,
            height = 0.4,
            position = 'bottom',
            border = 'top',
            title = ' {title} {live} {flags}',
            title_pos = 'left',
            { win = 'input', height = 1, border = 'bottom' },
            {
              box = 'horizontal',
              { win = 'list', border = 'none' },
              { win = 'preview', title = '{preview}', width = 0.5, border = 'left' },
            },
          },
        },
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    {
      '<leader>gl',
      function()
        require('snacks').lazygit.log()
      end,
      desc = 'Lazygit Logs',
    },
    {
      '<leader>rN',
      function()
        require('snacks').rename.rename_file()
      end,
      desc = 'Fast Rename Current File',
    },
    {
      '<leader>dB',
      function()
        require('snacks').bufdelete()
      end,
      desc = 'Delete or Close Buffer  (Confirm)',
    },
    {
      '<leader><leader>',
      function()
        require('snacks').picker.smart()
      end,
      desc = 'Find file',
    },
    {
      '<leader>ff',
      function()
        require('snacks').picker.smart()
      end,
      desc = 'Find file',
    },
    {
      '<leader>:',
      function()
        require('snacks').picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>fe',
      function()
        require('snacks').explorer { layout = { layout = { position = 'right' } } }
      end,
      desc = 'File Explorer',
    },
    {
      '<leader>fs',
      function()
        require('snacks').picker.grep()
      end,
      desc = 'Fzf search in project',
    },
    {
      '<leader>/',
      function()
        require('snacks').picker.lines()
      end,
      desc = 'Fzf search in project',
    },
    {
      '<leader>lg',
      function()
        require('snacks').lazygit.open()
      end,
      desc = 'Lazygit',
    },
    {
      'gd',
      function()
        require('snacks').picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gD',
      function()
        require('snacks').picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      'gr',
      function()
        require('snacks').picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      'gI',
      function()
        require('snacks').picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        require('snacks').picker.lsp_type_definitions()
      end,
      desc = 'Goto T[y]pe Definition',
    },
    {
      '<leader>ss',
      function()
        require('snacks').picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>sS',
      function()
        require('snacks').picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace Symbols',
    },
    {
      '<leader>ca',
      function()
        vim.lsp.buf.code_action()
      end,
      desc = 'LSP Code Actions',
    },
    {
      '<leader>km',
      function()
        require('snacks').picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>fb',
      function()
        require('snacks').picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>hp',
      function()
        require('snacks').picker.help()
      end,
      desc = 'Help Pages',
    },
  },
}
