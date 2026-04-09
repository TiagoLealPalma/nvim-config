-- GUI font size adjustment keymaps (<leader>+ and <leader>-).
-- Only functional in GUI clients (Neovide, nvim-qt) where guifont is set.
-- Loaded from init.lua after theme. Reads the base font from core/options.lua.

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>+', function()
  local font = vim.o.guifont
  local name, size = font:match("(.+):h(%d+)")
  if not name then return end -- no-op in terminal nvim where guifont is empty
  vim.o.guifont = name .. ":h" .. (tonumber(size) + 1)
end, opts)

map('n', '<leader>-', function()
  local font = vim.o.guifont
  local name, size = font:match("(.+):h(%d+)")
  if not name then return end
  vim.o.guifont = name .. ":h" .. (tonumber(size) - 1)
end, opts)
