-- Buffer tab bar, styled to match tmux/tmux.conf's window list: flat
-- "N:name" text, no icons, active buffer a solid accent block with bold
-- dark text (same as tmux's active-window badge), everything else plain.
-- Keymaps: <S-h>/<S-l> cycle, <leader>1-9 jump by index, <leader>x close.
-- <leader>fb (Telescope buffers) is patched in plugins/telescope.lua to jump
-- to an existing bufferline tab instead of opening a duplicate.

-- Hardcoded matte-black hex (not linked highlight groups) — same tradeoff
-- as tmux/tmux.conf: bufferline's `highlights` table wants concrete colors
-- up front, not something reactive to a ColorScheme event, so this is only
-- accurate while matte-black is the active colorscheme.
local mb_bg = "#121212"
local mb_fg = "#bebebe"
local mb_dim = "#8a8a8d"
local mb_accent = "#e68e0d"
local mb_red = "#D35F5F"
local mb_gold = "#D9B361"

require("bufferline").setup({
  options = {
    mode = "buffers",
    -- "N:name" prefix, matching tmux's window-status-format exactly
    -- ("#I:#W") rather than bufferline's own "N. name" ordinal style.
    numbers = function(opts)
      return string.format("%d:", opts.ordinal)
    end,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = { " ", " " }, -- plain gap, same as tmux's window-status-separator
    indicator = { style = "none" }, -- the selected buffer's solid fill is the indicator
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
    fill = { bg = mb_bg },
    background = { fg = mb_dim, bg = mb_bg },
    buffer_visible = { fg = mb_fg, bg = mb_bg },
    -- Solid accent block with dark bold text — exactly tmux's active-window
    -- badge (`window-status-current-style "fg=$mb_bg,bg=$mb_accent,bold"`).
    buffer_selected = { fg = mb_bg, bg = mb_accent, bold = true },
    numbers = { fg = mb_dim, bg = mb_bg },
    numbers_selected = { fg = mb_bg, bg = mb_accent, bold = true },
    modified = { fg = mb_accent, bg = mb_bg },
    modified_visible = { fg = mb_accent, bg = mb_bg },
    modified_selected = { fg = mb_bg, bg = mb_accent },
    separator = { fg = mb_bg, bg = mb_bg },
    separator_visible = { fg = mb_bg, bg = mb_bg },
    separator_selected = { fg = mb_bg, bg = mb_bg },
    pick = { fg = mb_accent, bg = mb_bg, bold = true },
    pick_visible = { fg = mb_accent, bg = mb_bg, bold = true },
    pick_selected = { fg = mb_bg, bg = mb_accent, bold = true },
    duplicate = { fg = mb_dim, bg = mb_bg, italic = true },
    duplicate_visible = { fg = mb_dim, bg = mb_bg, italic = true },
    duplicate_selected = { fg = mb_bg, bg = mb_accent, italic = true },
    close_button = { fg = mb_dim, bg = mb_bg },
    close_button_visible = { fg = mb_dim, bg = mb_bg },
    close_button_selected = { fg = mb_bg, bg = mb_accent },
    -- Left unset, these auto-derive a background a shade off the rest of
    -- the bar — pin them to the same plain background as everything else.
    error = { fg = mb_red, bg = mb_bg },
    error_visible = { fg = mb_red, bg = mb_bg },
    error_selected = { fg = mb_bg, bg = mb_accent, bold = true },
    error_diagnostic = { fg = mb_red, bg = mb_bg },
    error_diagnostic_visible = { fg = mb_red, bg = mb_bg },
    error_diagnostic_selected = { fg = mb_bg, bg = mb_accent, bold = true },
    warning = { fg = mb_gold, bg = mb_bg },
    warning_visible = { fg = mb_gold, bg = mb_bg },
    warning_selected = { fg = mb_bg, bg = mb_accent, bold = true },
    warning_diagnostic = { fg = mb_gold, bg = mb_bg },
    warning_diagnostic_visible = { fg = mb_gold, bg = mb_bg },
    warning_diagnostic_selected = { fg = mb_bg, bg = mb_accent, bold = true },
    info = { fg = mb_dim, bg = mb_bg },
    info_visible = { fg = mb_dim, bg = mb_bg },
    info_selected = { fg = mb_bg, bg = mb_accent },
    info_diagnostic = { fg = mb_dim, bg = mb_bg },
    info_diagnostic_visible = { fg = mb_dim, bg = mb_bg },
    info_diagnostic_selected = { fg = mb_bg, bg = mb_accent },
    hint = { fg = mb_dim, bg = mb_bg },
    hint_visible = { fg = mb_dim, bg = mb_bg },
    hint_selected = { fg = mb_bg, bg = mb_accent },
    hint_diagnostic = { fg = mb_dim, bg = mb_bg },
    hint_diagnostic_visible = { fg = mb_dim, bg = mb_bg },
    hint_diagnostic_selected = { fg = mb_bg, bg = mb_accent },
    trunc_marker = { fg = mb_dim, bg = mb_bg },
    offset_separator = { fg = mb_dim, bg = mb_bg },
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
