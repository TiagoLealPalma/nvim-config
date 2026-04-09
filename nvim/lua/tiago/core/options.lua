-- Editor-wide settings: indentation, line numbers, clipboard, font, and leader key.
-- Loaded first in init.lua so mapleader is available before lazy.nvim binds plugin keymaps.

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.o.guifont = "FiraCode Nerd Font:h14"

vim.g.mapleader = " "
