-- Fuzzy finder setup for files, grep, buffers, and help.
-- find_files uses fd for speed and .gitignore support, with aggressive static file filtering.
-- live_grep uses rg with default debounce (no 0ms override) to avoid excessive spawning.
-- Keymaps in core/keymaps.lua: <leader>ff, <leader>fg, <leader>fb, <leader>fh.

require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    dynamic_preview_title = true,
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git" },
      file_ignore_patterns = {
        "node_modules/",
        "dist/",
        "build/",
        "static/",
        "cache/",
        "%.next/",
        "%.png$", "%.jpg$", "%.jpeg$", "%.gif$", "%.ico$", "%.svg$", "%.webp$", "%.avif$",
        "%.woff$", "%.woff2$", "%.ttf$", "%.eot$", "%.otf$",
        "%.min%.js$", "%.min%.css$", "%.map$",
        "%.zip$", "%.tar$", "%.gz$", "%.pdf$",
        "package%-lock%.json$", "yarn%.lock$",
      },
      debounce = 0,
    },
  },
})
