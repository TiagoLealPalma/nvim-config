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

-- lualine's "a" section already shows the mode via a colored badge, so the
-- plain "-- INSERT --" text on the command line below it is redundant.
vim.o.showmode = false

-- cmdheight = 0 collapses that command-line row entirely when idle (no
-- pending command/search/message), instead of always reserving an empty
-- line there. Neovim pops it back in on demand for ":", "/", errors, etc.
-- Net effect: lualine sits flush against the tmux status bar instead of
-- leaving a dead gap above it.
vim.o.cmdheight = 0

-- ahmedkhalf/project.nvim (unmaintained upstream) still calls the removed
-- vim.lsp.buf_get_clients(), which prints a deprecation warning on every
-- buffer with "lsp" root detection. Point it at the current API instead of
-- patching the plugin file directly, since that would get overwritten on
-- the next plugin update. Must run before plugins/project.lua's setup().
if vim.lsp.buf_get_clients then
  vim.lsp.buf_get_clients = vim.lsp.get_clients
end
