---@type LazySpec
return {
  { 'xzbdmw/colorful-menu.nvim', opts = {} },
  { 'zbirenbaum/copilot.lua', enabled = false, cmd = 'Copilot', event = 'InsertEnter', opt = {} },
  {
    'saghen/blink.cmp',
    -- event = { 'InsertEnter', 'CmdwinEnter' },
    dependencies = {
      'rafamadriz/friendly-snippets',
      'giuxtaposition/blink-cmp-copilot',
      { 'nvim-mini/mini.icons', opts = {} },
    },
    version = '*',
    opts = {
      appearance = {
        -- use_nvim_cmp_as_default = true,
        -- nerd_font_variant = 'mono',
      },
      cmdline = {
        completion = {
          ghost_text = { enabled = true },
          menu = { auto_show = true },
        },
        keymap = {
          preset = 'inherit',
          -- ['<CR>'] = { 'accept', 'fallback' },
        },
      },
      keymap = { preset = 'default' },
      completion = {
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
        keyword = { range = 'full' },
        menu = {
          auto_show = true,
          draw = {
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              -- label = {
              --   text = function(ctx)
              --     return require('colorful-menu').blink_components_text(ctx)
              --   end,
              --   highlight = function(ctx)
              --     return require('colorful-menu').blink_components_highlight(ctx)
              --   end,
              -- },
            },
          },
        },
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        sorts = { 'exact', 'score', 'sort_text' },
      },
      signature = { enabled = true },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          -- 'copilot',
          'omni',
          -- 'spell',
        },
        per_filetype = {
          lua = { inherit_defaults = true, 'lazydev' },
        },
        providers = {
          -- copilot = {
          --   name = 'copilot',
          --   module = 'blink-cmp-copilot',
          --   score_offset = 100,
          --   async = true,
          -- },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          snippets = {
            should_show_items = function(ctx)
              return ctx.trigger.initial_kind ~= 'trigger_character'
            end,
          },
        },
      },
    },
  },
}
