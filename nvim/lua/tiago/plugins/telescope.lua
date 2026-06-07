-- Fuzzy finder setup for files, grep, buffers, and help.
-- Uses fd (respects .gitignore) and rg by default.
-- Keymaps in core/keymaps.lua: <leader>ff, <leader>fg, <leader>fb, <leader>fh.

-- plenary removed if_nil; patch it back for telescope compatibility
local ok, utils = pcall(require, "plenary.utils")
if ok and utils.if_nil == nil then
  utils.if_nil = function(val, default)
    return val == nil and default or val
  end
end

require('telescope').setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
    dynamic_preview_title = true,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
  },
})
