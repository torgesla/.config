vim.opt.number = false
vim.opt.relativenumber = false

vim.opt.iskeyword:append '-'
vim.opt.path:append '**'

vim.opt.spellfile = vim.fn.stdpath 'config' .. '/spell/custom.utf-8.add'
vim.opt.spelllang = 'en_us' --,nb_no'
-- vim.opt.spell = true

-- Enable mouse mode, can be useful for resizing splits for example!
-- vim.opt.mouse = 'a'
vim.opt.mouse = ''

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes:2'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key pop-up sooner
vim.opt.timeoutlen = 300

-- Hide command line when not in use (works with noice.nvim)
vim.opt.cmdheight = 0

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Configure how new splits should be opened
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.textwidth = 100
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.termguicolors = true
vim.opt.virtualedit = 'block'
vim.opt.scrolloff = 8

vim.diagnostic.config {
  float = { max_width = math.floor(0.8 * vim.o.columns), max_height = math.floor(0.8 * vim.o.lines) },

  virtual_lines = false,
  virtual_text = false,
}

vim.opt.isfname:append '@-@'
vim.opt.backspace = { 'start', 'eol', 'indent' }

vim.g.editorconfig = true

-- vim.opt.winborder = 'rounded'

-- vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor'
-- vim.cmd [[highlight Cursor guifg=NONE guibg=red]]
-- vim.o.cursorline = true -- Ensure the cursorline is enabled
-- vim.cmd [[
--   highlight CursorLine guibg=#1e1e2e guifg=NONE
-- ]]
