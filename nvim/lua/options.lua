vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

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
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Configure how new splits should be opened
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.termguicolors = true
vim.opt.virtualedit = 'block'
vim.opt.scrolloff = 8

vim.diagnostic.config {
  virtual_lines = false,
  virtual_text = false,
}

vim.opt.isfname:append '@-@'
vim.opt.backspace = { 'start', 'eol', 'indent' }

vim.g.editorconfig = true

-- vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor'
-- vim.cmd [[highlight Cursor guifg=NONE guibg=red]]
-- vim.o.cursorline = true -- Ensure the cursorline is enabled
-- vim.cmd [[
--   highlight CursorLine guibg=#1e1e2e guifg=NONE
-- ]]
