return {
  'folke/snacks.nvim',
  priority = 1000,

  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true, replace_netrw = false, layout = { cycle = false } },
    gh = { enabled = true },
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
        sort_empty = true,
      },
      formatters = { file = { filename_first = true, filename_only = false, icon_width = 2 } },
      layout = { preset = 'select', cycle = false },
      win = {
        input = {
          keys = {
            ['<C-f>'] = { 'toggle_fuzzy', mode = { 'n', 'i' } },
            ['<C-i>'] = { 'toggle_ignorecase', mode = { 'n', 'i' } },
          },
        },
      },
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
      '<leader><leader>',
      function()
        local function fallback_buffer_picker()
          local buffers = vim.fn.getbufinfo { buflisted = 1 }

          if #buffers < 2 then
            return require('fff').find_files()
          end

          if #buffers == 2 then
            return vim.cmd.bnext()
          end

          require('snacks.picker').buffers {
            current = false,
            sort_lastused = true,
            on_show = function()
              vim.cmd.stopinsert()
            end,
          }
        end

        local git_check = vim.system({ 'git', 'status', '--porcelain' }):wait()

        if git_check.code == 0 then
          local files = vim.split(git_check.stdout, '\n', { trimempty = true })
          local file_count = #files

          if file_count > 1 then
            return require('snacks.picker').git_status {
              current = false,
              sort_lastused = true,
            }
          end
        end

        return fallback_buffer_picker()
      end,
      desc = 'Git status (if >1) / Buffers',
    },

    {
      '<leader>cs',
      function()
        require('snacks').picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },

    -- {
    --   '<leader>e',
    --   function()
    --     require('snacks').picker.smart()
    --   end,
    --   desc = 'Find smart file',
    -- },

    {
      '<leader>fe',
      function()
        ---@type snacks.picker.explorer.Config
        local opts = { layout = { layout = { position = 'right' } } }
        require('snacks').explorer(opts)
      end,
      desc = 'File Explorer',
    },

    -- {
    --   '<leader>s',
    --   function()
    --     ---@type snacks.picker.grep.Config
    --     local opts = {
    --       exclude = { 'package-lock.json', 'changelog.txt' },
    --       regex = false,
    --     }
    --     require('snacks').picker.grep(opts)
    --   end,
    --   desc = 'Fzf search in project',
    -- },

    {
      '<leader>fr',
      function()
        require('snacks').picker.resume()
      end,
      desc = 'Find Resume',
    },

    -- {
    --   '<leader>lg',
    --   function()
    --     require('snacks').lazygit.open()
    --   end,
    --   desc = 'Lazygit',
    -- },

    {
      'gd',
      function()
        require('snacks').picker.lsp_definitions()
      end,
      desc = 'Go Definition',
    },

    {
      'gr',
      function()
        require('snacks').picker.lsp_references()
      end,
      nowait = true,
      desc = 'Go References',
    },

    {
      '<leader>ca',
      function()
        local params = vim.lsp.util.make_range_params()
        params.context = {
          diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 }),
        }

        vim.lsp.buf_request_all(0, 'textDocument/codeAction', params, function(results)
          local actions = {}
          for client_id, result in pairs(results) do
            if result.result then
              for _, action in pairs(result.result) do
                table.insert(actions, action)
              end
            end
          end

          local auto_fix = nil
          for _, action in ipairs(actions) do
            if action.title == 'Fix all auto-fixable problems' then
              auto_fix = action
              break
            end
          end

          if auto_fix then
            vim.lsp.buf.code_action {
              apply = true,
              filter = function(action)
                return action.title == 'Fix all auto-fixable problems'
              end,
            }
          else
            vim.lsp.buf.code_action { apply = true }
          end
        end)
      end,
      desc = 'Code Actions (auto-fix)',
    },

    {
      '<leader>km',
      function()
        require('snacks').picker.keymaps()
      end,
    },

    {
      '<leader>bb',
      function()
        ---@type snacks.picker.buffers.Config
        local opts = { current = false }
        require('snacks').picker.buffers(opts)
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
    {
      '<leader>pr',
      function()
        require('snacks').picker.gh_pr()
      end,
      desc = 'Github Pull Requests (open)',
    },
    {
      '<leader>td',
      function()
        require('snacks').picker.todo_comments()
      end,
      desc = 'Todo',
    },
    {
      '<leader>tD',
      function()
        require('snacks').picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
      end,
      desc = 'Todo/Fix/Fixme',
    },

    -- {
    --   '<leader>gl',
    --   function()
    --     require('snacks').lazygit.log()
    --   end,
    --   desc = 'Lazygit Logs',
    -- },
    -- {
    --   '<leader>rN',
    --   function()
    --     require('snacks').rename.rename_file()
    --   end,
    --   desc = 'Fast Rename Current File',
    -- },
    -- {
    --   '<leader>dB',
    --   function()
    --     require('snacks').bufdelete()
    --   end,
    --   desc = 'Delete or Close Buffer  (Confirm)',
    -- },
    -- {
    --   '<leader>:',
    --   function()
    --     require('snacks').picker.command_history()
    --   end,
    --   desc = 'Command History',
    -- },
    -- {
    --   '<leader>/',
    --   function()
    --     require('snacks').picker.lines()
    --   end,
    --   desc = 'Fzf search in project',
    -- },
    -- {
    --   'gD',
    --   function()
    --     require('snacks').picker.lsp_declarations()
    --   end,
    --   desc = 'Goto Declaration',
    -- },
    -- {
    --   'gI',
    --   function()
    --     require('snacks').picker.lsp_implementations()
    --   end,
    --   desc = 'Goto Implementation',
    -- },
    -- {
    --   'gy',
    --   function()
    --     require('snacks').picker.lsp_type_definitions()
    --   end,
    --   desc = 'Goto T[y]pe Definition',
    -- },
    -- {
    --   '<leader>ss',
    --   function()
    --     require('snacks').picker.lsp_symbols()
    --   end,
    --   desc = 'LSP Symbols',
    -- },
    -- {
    --   '<leader>sS',
    --   function()
    --     require('snacks').picker.lsp_workspace_symbols()
    --   end,
    --   desc = 'LSP Workspace Symbols',
    -- },
    -- {
    --   '<leader>cA',
    --   function()
    --     vim.lsp.buf.code_action {
    --       apply = true,
    --     }
    --   end,
    --   desc = 'LSP All Code Actions',
    -- },
  },
}
