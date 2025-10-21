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
      matcher = {
        cwd_bonus = true,
        filename_bonus = true,
        frecency = true,
        fuzzy = true,
        history_bonus = true,
        ignorecase = true,
        smartcase = true,
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
            height = 0.4,
            min_height = 10,
            width = 0.6,
            min_width = 80,
            box = 'vertical',
            border = 'rounded',
            position = 'top',
            title = '{title}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
            { win = 'preview', title = '{preview}', width = 0.6, height = 0.4, border = 'top' },
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
    -- {
    --   '<leader>dB',
    --   function()
    --     require('snacks').bufdelete()
    --   end,
    --   desc = 'Delete or Close Buffer  (Confirm)',
    -- },
    {
      '<leader><leader>',
      function()
        local buffers = vim.fn.getbufinfo { buflisted = 1 }

        if #buffers < 2 then
          return require('snacks.picker').smart {}
        end

        if #buffers == 2 then
          return vim.cmd.bnext()
        end

        require('snacks.picker').buffers {
          current = false,
          on_show = function()
            vim.cmd.stopinsert()
          end,
        }
      end,
      desc = 'Find buffers',
    },
    {
      '<leader>cs',
      function()
        require('snacks').picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    {
      '<leader>e',
      function()
        require('snacks').picker.smart()
      end,
      desc = 'Find smart file',
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
        require('snacks').picker.grep {
          regex = false,
          exclude = { 'package-lock.json', 'changelog.txt' },
        }
      end,
      desc = 'Fzf search in project',
    },
    {
      '<leader>fr',
      function()
        require('snacks').picker.resume()
      end,
      desc = 'Resume last picker search',
    },
    -- {
    --   '<leader>/',
    --   function()
    --     require('snacks').picker.lines()
    --   end,
    --   desc = 'Fzf search in project',
    -- },
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
    -- {
    --   'gD',
    --   function()
    --     require('snacks').picker.lsp_declarations()
    --   end,
    --   desc = 'Goto Declaration',
    -- },
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
    -- {
    --   '<leader>sS',
    --   function()
    --     require('snacks').picker.lsp_workspace_symbols()
    --   end,
    --   desc = 'LSP Workspace Symbols',
    -- },
    {
      '<leader>ca',
      function()
        vim.lsp.buf.code_action {
          apply = true,
          only = { 'source' },
        }
      end,
      desc = 'LSP Code Actions',
    },
    {
      '<leader>cA',
      function()
        vim.lsp.buf.code_action {
          apply = true,
        }
      end,
      desc = 'LSP All Code Actions',
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
