local map = vim.keymap.set

-- Space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better escape
map("i", "jk", "<Esc>")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Better up/down (respects line wrap)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Move lines
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Keep cursor centred when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Save
map({ "n", "i" }, "<C-s>", "<cmd>w<CR><Esc>")
