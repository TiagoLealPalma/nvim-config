-- Indent guides. Linked to existing highlight groups (not hardcoded colors)
-- so it adapts automatically to whatever colorscheme is active, except on
-- matte-black where both get a dedicated tuning: dimmer/softer guides for
-- regular indents (closer to bg, less visual noise) and a brighter, bolder
-- one for the current scope so it actually pops instead of both competing
-- for attention at the same intensity. Re-applied on every ColorScheme
-- event since `hi clear` (used by custom colorschemes like
-- colors/ristretto.lua) wipes plain nvim_set_hl calls made before it.
local function set_links()
  if vim.g.colors_name == "matte-black" then
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2a2a" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#f5a623", bold = true })
  else
    vim.api.nvim_set_hl(0, "IblIndent", { link = "Comment" })
    vim.api.nvim_set_hl(0, "IblScope", { link = "Function" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_links })
set_links()

require("ibl").setup({
  indent = { char = "│" },
  scope = { show_start = false, show_end = false },
})
