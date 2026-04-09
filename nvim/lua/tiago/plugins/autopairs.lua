-- Auto-closing brackets, quotes, and parentheses.
-- Treesitter-aware (check_ts) to avoid pairing inside strings/comments.
-- Integrates with nvim-cmp so pairs are inserted after confirming a completion.

local autopairs = require("nvim-autopairs")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

autopairs.setup({
  check_ts = true,
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
