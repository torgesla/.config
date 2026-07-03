return {
  {
    -- nvim-treesitter main branch requires Neovim 0.12+; incompatible with old master API
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- nvim 0.12 ships built-in treesitter incremental selection (see
      -- $VIMRUNTIME/lua/vim/_core/defaults.lua) on `an`/`in`, but mini.ai owns
      -- those keys here — so drive vim.treesitter._select directly instead, with
      -- the same LSP selectionRange fallback the defaults use. Mapped to <CR>
      -- (init/expand) and <BS> (shrink) to match the old incremental_selection
      -- keymaps, buffer-local in parser-backed files so <CR> stays intact in
      -- quickfix/help. (Sibling nav `]n`/`[n` remain the global builtins.)
      local function expand(count)
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require('vim.treesitter._select').select_parent(count)
        else
          vim.lsp.buf.selection_range(count)
        end
      end
      local function shrink(count)
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require('vim.treesitter._select').select_child(count)
        else
          vim.lsp.buf.selection_range(-count)
        end
      end

      -- Charwise-select a 0-indexed, end-exclusive node range.
      local function visual_select(srow, scol, erow, ecol)
        if ecol == 0 and erow > srow then
          erow = erow - 1
          ecol = #vim.fn.getline(erow + 1)
        end
        vim.fn.setpos('.', { 0, srow + 1, scol + 1, 0 })
        if vim.api.nvim_get_mode().mode ~= 'v' then
          vim.cmd.normal { 'v', bang = true }
        end
        vim.fn.setpos('.', { 0, erow + 1, math.max(ecol, 1), 0 })
      end

      -- Init: select the smallest node under the cursor, INCLUDING anonymous
      -- tokens (keywords like `export`/`function`). select_parent uses
      -- named_descendant_for_range, which would skip those and jump straight to
      -- the enclosing named node — so resolve the node ourselves here.
      local function init()
        local parser = vim.treesitter.get_parser(nil, nil, { error = false })
        if not parser then
          vim.cmd.normal { 'v', bang = true }
          expand(1) -- no parser: fall back to LSP selectionRange
          return
        end
        local cur = vim.api.nvim_win_get_cursor(0)
        local row, col = cur[1] - 1, cur[2]
        parser:parse { row, col, row, col + 1 }
        local lt = parser:language_for_range { row, col, row, col }
        local tree = lt:tree_for_range({ row, col, row, col }, { ignore_injections = false })
        local node = tree and tree:root():descendant_for_range(row, col, row, col)
        if not node then
          vim.cmd.normal { 'v', bang = true }
          expand(1)
          return
        end
        visual_select(node:range())
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('TSIncSelectKeys', { clear = true }),
        desc = 'Treesitter incremental selection on <CR>/<BS>',
        callback = function(ev)
          if vim.bo[ev.buf].buftype ~= '' then
            return
          end
          if not pcall(vim.treesitter.get_parser, ev.buf) then
            return
          end
          local function map(mode, lhs, fn, desc)
            vim.keymap.set(mode, lhs, fn, { buffer = ev.buf, silent = true, desc = desc })
          end
          map('n', '<CR>', init, 'TS selection: select node under cursor')
          map('x', '<CR>', function()
            expand(vim.v.count1)
          end, 'TS selection: expand to parent node')
          map('x', '<BS>', function()
            shrink(vim.v.count1)
          end, 'TS selection: shrink to child node')
        end,
      })
      -- Install parsers on first load; use :TSUpdate to update them
      require('nvim-treesitter.install').install {
        'angular',
        'c',
        'css',
        'csv',
        'dockerfile',
        'go',
        'git_config',
        'java',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'prisma',
        'python',
        'query',
        'rust',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
