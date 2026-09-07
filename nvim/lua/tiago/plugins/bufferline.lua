-- Buffer tab bar with thin separators.
-- Keymaps: <S-h>/<S-l> cycle, <leader>1-9 jump by index, <leader>x close.
-- <leader>fb (Telescope buffers) is patched in plugins/telescope.lua to jump
-- to an existing bufferline tab instead of opening a duplicate.

-- Hardcoded matte-black hex (not linked highlight groups) — same tradeoff
-- as tmux/tmux.conf: bufferline's `highlights` table wants concrete colors
-- up front, not something reactive to a ColorScheme event, so this is only
-- accurate while matte-black is the active colorscheme.
local mb_bg = "#121212"
local mb_bg_alt = "#333333"
local mb_fg = "#bebebe"
local mb_dim = "#8a8a8d"
local mb_accent = "#e68e0d"
-- The tabline needs its own background, distinct from the editor bg —
-- otherwise unselected tabs (which sat on plain mb_bg) made the whole strip
-- look like an empty black gap instead of a bar with tabs in it.
local mb_strip = "#1c1c1c"

require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "thin",
    show_buffer_close_icons = false,
    show_close_icon = false,
    -- Only show once there's an actual choice to make between tabs — with
    -- one buffer (or on the dashboard, which has none) it was just a bare
    -- dark strip with nothing useful in it.
    always_show_bufferline = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Files",
        highlight = "Directory",
        separator = true,
      },
    },
  },
  highlights = {
    fill = { bg = mb_strip },
    background = { fg = mb_dim, bg = mb_strip },
    buffer_visible = { fg = mb_fg, bg = mb_strip },
    buffer_selected = { fg = mb_fg, bg = mb_bg_alt, bold = true },
    numbers = { fg = mb_dim, bg = mb_strip },
    numbers_selected = { fg = mb_accent, bg = mb_bg_alt, bold = true },
    modified = { fg = mb_accent, bg = mb_strip },
    modified_visible = { fg = mb_accent, bg = mb_strip },
    modified_selected = { fg = mb_accent, bg = mb_bg_alt },
    separator = { fg = mb_bg, bg = mb_strip },
    separator_visible = { fg = mb_bg, bg = mb_strip },
    separator_selected = { fg = mb_bg, bg = mb_bg_alt },
    -- The colored bar marking the active buffer — the one deliberate spot
    -- of accent color, so it reads as "this tab is selected" at a glance.
    indicator_selected = { fg = mb_accent, bg = mb_bg_alt },
    indicator_visible = { fg = mb_bg_alt, bg = mb_strip },
    pick = { fg = mb_accent, bg = mb_strip, bold = true },
    pick_visible = { fg = mb_accent, bg = mb_strip, bold = true },
    pick_selected = { fg = mb_accent, bg = mb_bg_alt, bold = true },
    duplicate = { fg = mb_dim, bg = mb_strip, italic = true },
    duplicate_visible = { fg = mb_dim, bg = mb_strip, italic = true },
    duplicate_selected = { fg = mb_fg, bg = mb_bg_alt, italic = true },
    close_button = { fg = mb_dim, bg = mb_strip },
    close_button_visible = { fg = mb_dim, bg = mb_strip },
    close_button_selected = { fg = mb_fg, bg = mb_bg_alt },
    trunc_marker = { fg = mb_dim, bg = mb_strip },
    offset_separator = { fg = mb_bg_alt, bg = mb_strip },
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
