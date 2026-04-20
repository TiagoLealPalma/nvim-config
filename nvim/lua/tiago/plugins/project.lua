-- Project picker setup using project.nvim + Telescope.
-- Detects git roots automatically. Opened via <leader>p or on bare nvim launch (autocmds.lua).

require("project_nvim").setup({
  detection_methods = { "lsp", "pattern" },
  patterns = { ".git" },
  search_dirs = { "~/Git" },
  show_hidden = false,
  silent_chdir = true,
})

require("telescope").load_extension("projects")
