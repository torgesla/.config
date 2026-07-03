local colors = {
  bg = '#202328',
  blue = '#51afef',
  cyan = '#008080',
  darkblue = '#081633',
  fg = '#bbc2cf',
  green = '#98be65',
  magenta = '#c678dd',
  orange = '#FF8800',
  red = '#ec5f67',
  violet = '#a9a1e1',
  white = '#ffffff',
  yellow = '#ECBE7B',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      -- 'christopher-francisco/tmux-status.nvim',
      'nvim-mini/mini.icons',
    },
    config = function()
      -- local tmux_status = require 'tmux-status'
      -- tmux_status.setup {}
      require('lualine').setup {
        options = {
          always_show_tabline = false,
          component_separators = '',
          section_separators = '',
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          lualine_c = {
            {
              function()
                return '▊'
              end,
              color = { fg = colors.blue }, -- Sets highlighting of component
              padding = { left = 0, right = 1 }, -- We don't need space before this
            },
            -- {
            --   tmux_status.tmux_session,
            --   cond = tmux_status.show,
            --   -- padding = { left = 3 },
            -- },
            -- {
            --   tmux_status.tmux_windows,
            --   cond = tmux_status.show,
            --   -- padding = { left = 3 },
            -- },
            {
              'mode',
              separator = { left = '' },
              right_padding = 2,
              color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                  n = colors.white,
                  i = colors.green,
                  v = colors.blue,
                  [''] = colors.blue,
                  V = colors.blue,
                  c = colors.magenta,
                  no = colors.red,
                  s = colors.orange,
                  S = colors.orange,
                  [''] = colors.orange,
                  ic = colors.yellow,
                  R = colors.violet,
                  Rv = colors.violet,
                  cv = colors.red,
                  ce = colors.red,
                  r = colors.cyan,
                  rm = colors.cyan,
                  ['r?'] = colors.cyan,
                  ['!'] = colors.red,
                  t = colors.red,
                }
                return { fg = mode_color[vim.fn.mode()] }
              end,
            },
            {
              'branch',
              icon = '',
              color = { fg = colors.violet, gui = 'bold' },
            },
            {
              function()
                return '%='
              end,
            },
            {
              'filename',
              path = 1,
              cond = conditions.buffer_not_empty,
              color = { fg = colors.magenta, gui = 'bold' },
            },
            {
              'diff',
              symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
              diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
              },
              cond = conditions.hide_in_width,
            },
          },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = { error = ' ', warn = ' ', info = ' ' },
              diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.cyan },
              },
            },
            {
              function()
                local msg = 'No Lsp'
                local buf_ft = vim.bo.filetype
                local clients = vim.lsp.get_clients {
                  bufnr = vim.api.nvim_get_current_buf(),
                }
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
                return msg
              end,
              icon = ' :',
              color = { fg = colors.white, gui = 'bold' },
            },
            {
              function()
                return '▊'
              end,
              color = { fg = colors.blue },
              padding = { left = 1 },
            },
          },
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }
    end,
  },
}
