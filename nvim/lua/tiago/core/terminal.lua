-- Floating terminal module.
-- Opens a centered floating window with a terminal in the current file's directory.
-- Uses lcd (not cd) so the global working directory is not affected,
-- keeping nvim-tree rooted at the original launch directory.
-- Required by core/keymaps.lua for the <leader>t mapping.

local M = {}

function M.open_floating_terminal()
  local file_dir = vim.fn.expand("%:p:h")
  if file_dir == "" then
    file_dir = vim.uv.cwd()
  end

  local buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, true, {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  })

  vim.cmd("lcd " .. vim.fn.fnameescape(file_dir))
  vim.cmd("terminal")
  vim.cmd("startinsert")

  vim.keymap.set("t", "q", "<cmd>bd!<CR>", { buffer = buf })
  vim.keymap.set("t", "<Esc>", "<cmd>bd!<CR>", { buffer = buf })
end

return M
