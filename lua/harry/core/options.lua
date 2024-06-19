-- options.lua

-- Set your options
-- line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.statuscolumn = "%s %l %r "
vim.o.colorcolumn = "80"

-- fix python indents
vim.g.pyindent_open_paren = '0'
vim.g.pyindent_nested_paren = '&sw'
vim.g.pyindent_continue = '&sw'


-- tabs and indentations
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

-- line wrapping
vim.o.wrap = false

-- search settings
vim.o.ignorecase = true
vim.o.smartcase = true

-- cursor line
vim.o.cursorline = true

-- appearance
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.signcolumn = "yes"

-- backspace
vim.o.backspace = "indent,eol,start"

-- clipboard
vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'

-- split windows
vim.o.splitright = true
vim.o.splitbelow = true
