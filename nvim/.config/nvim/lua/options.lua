local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Misc
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.clipboard = "unnamedplus"
opt.updatetime = 250
