-- Indent guides. Linked to existing highlight groups (not hardcoded colors)
-- so it adapts automatically to whatever colorscheme is active. Re-applied
-- on every ColorScheme event since `hi clear` (used by custom colorschemes
-- like colors/ristretto.lua) wipes plain nvim_set_hl calls made before it.
local function set_links()
  vim.api.nvim_set_hl(0, "IblIndent", { link = "Comment" })
  vim.api.nvim_set_hl(0, "IblScope", { link = "Function" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_links })
set_links()

require("ibl").setup({
  indent = { char = "│" },
  scope = { show_start = false, show_end = false },
})
