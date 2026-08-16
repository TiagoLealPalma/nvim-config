-- Buffer tab bar with padded-slant separators.
-- Keymaps: <S-h>/<S-l> cycle, <leader>1-9 jump by index, <leader>x close.
-- <leader>fb (Telescope buffers) is patched in plugins/telescope.lua to jump
-- to an existing bufferline tab instead of opening a duplicate.

require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "padded_slant",
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Files",
        highlight = "Directory",
        separator = true,
      },
    },
  },
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", opts)
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", opts)

for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", opts)
end

-- Close current buffer without closing the window: switch first if others exist.
map("n", "<leader>x", function()
  local cur = vim.api.nvim_get_current_buf()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed > 1 then
    vim.cmd("BufferLineCyclePrev")
  end
  vim.cmd("bd " .. cur)
end, { noremap = true, silent = true, desc = "Close buffer" })
