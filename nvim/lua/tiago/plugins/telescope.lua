-- Fuzzy finder setup for files, grep, buffers, and help.
-- Uses fd (respects .gitignore) and rg by default.
-- Keymaps in core/keymaps.lua: <leader>ff, <leader>fg, <leader>fb, <leader>fh.

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
