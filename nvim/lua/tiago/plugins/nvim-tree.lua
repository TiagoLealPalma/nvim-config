-- File explorer setup.
-- Syncs root with the global cwd so the tree reflects the directory where nvim was launched.
-- Toggled via <leader>ft in core/keymaps.lua.

require("nvim-tree").setup({
  hijack_cursor = true,

  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },

  view = {
    width = 30,
    side = "left",
  },
})
