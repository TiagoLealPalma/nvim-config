-- Statusline showing mode, git branch, diff, diagnostics, filename, and cursor position.
-- Uses tokyonight theme to match the colorscheme set in ui/theme.lua.
-- globalstatus = true means one statusline for the whole editor, not per-split.

require("lualine").setup({
  options = {
    theme = "tokyonight",
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
