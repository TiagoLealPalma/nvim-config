-- Statusline showing mode, git branch, diff, diagnostics, filename, and cursor position.
-- Custom theme matching colors/matte-black.lua (the "a" section changes color
-- per mode: orange/gold/red/etc, same palette used by the colorscheme itself).
-- globalstatus = true means one statusline for the whole editor, not per-split.

local c = {
  bg = "#121212",
  bg_alt = "#333333",
  fg = "#bebebe",
  black_bright = "#8a8a8d",
  red = "#D35F5F",
  gold = "#D9B361",
  crimson_bright = "#b90a0a",
  orange = "#e68e0d",
  cyan_bright = "#eaeaea",
}

local matte_black_theme = {
  normal = {
    a = { fg = c.bg, bg = c.orange, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_alt },
    c = { fg = c.fg, bg = c.bg },
  },
  insert = { a = { fg = c.bg, bg = c.gold, gui = "bold" } },
  visual = { a = { fg = c.bg, bg = c.red, gui = "bold" } },
  replace = { a = { fg = c.bg, bg = c.crimson_bright, gui = "bold" } },
  command = { a = { fg = c.bg, bg = c.cyan_bright, gui = "bold" } },
  inactive = {
    a = { fg = c.black_bright, bg = c.bg_alt },
    b = { fg = c.black_bright, bg = c.bg_alt },
    c = { fg = c.black_bright, bg = c.bg },
  },
}

require("lualine").setup({
  options = {
    theme = matte_black_theme,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
