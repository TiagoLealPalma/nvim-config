-- Renders markdown in-buffer (headings, code blocks, checkboxes, tables,
-- etc.) while editing — switches back to raw text automatically on the
-- line your cursor is on, and in insert mode, so it never gets in the way
-- of actually editing.

require("render-markdown").setup({
  -- fenced code blocks get a background one shade lighter than the editor
  -- bg (matte-black's bg_alt), matching how the rest of this config treats
  -- "lifted" surfaces (bufferline's active tab, popup menus, etc.).
  code = {
    style = "full",
    width = "block",
  },
  heading = {
    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
  },
  bullet = {
    icons = { "●", "○", "◆", "◇" },
  },
  checkbox = {
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },
})
