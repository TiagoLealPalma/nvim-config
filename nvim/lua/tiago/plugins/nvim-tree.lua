-- File explorer setup, floating (rarely used, no need for a permanent sidebar).
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
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        width = math.floor(vim.o.columns * 0.5),
        height = math.floor(vim.o.lines * 0.7),
        row = math.floor(vim.o.lines * 0.1),
        col = math.floor(vim.o.columns * 0.25),
        border = "rounded",
      },
    },
  },
})
