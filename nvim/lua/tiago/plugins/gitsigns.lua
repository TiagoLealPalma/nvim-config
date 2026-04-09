-- Git gutter signs and per-hunk operations (stage, reset, blame).
-- Lazy-loaded on BufReadPre/BufNewFile so it only activates for real files.
-- Keymaps are buffer-local via on_attach: ]h/[h navigate, <leader>h* for actions.

require("gitsigns").setup({
  signs = {
    add          = { text = "+" },
    change       = { text = "~" },
    delete       = { text = "_" },
    topdelete    = { text = "-" },
    changedelete = { text = "~" },
  },
  on_attach = function(buf)
    local gs = require("gitsigns")
    local opts = function(desc) return { buffer = buf, silent = true, desc = desc } end

    vim.keymap.set("n", "]h", gs.next_hunk, opts("Next hunk"))
    vim.keymap.set("n", "[h", gs.prev_hunk, opts("Prev hunk"))
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts("Preview hunk"))
    vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts("Stage hunk"))
    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts("Reset hunk"))
    vim.keymap.set("n", "<leader>hb", gs.blame_line, opts("Blame line"))
  end,
})
