-- Fuzzy finder setup for files, grep, buffers, and help.
-- Uses fd (respects .gitignore) and rg by default.
-- Keymaps in core/keymaps.lua: <leader>ff, <leader>fg, <leader>fb, <leader>fh.
-- <leader>fb uses a custom action: if the chosen buffer is already open in
-- bufferline it jumps to that tab instead of opening a second copy.

-- plenary removed if_nil; patch it back for telescope compatibility
local ok, utils = pcall(require, "plenary.utils")
if ok and utils.if_nil == nil then
  utils.if_nil = function(val, default)
    return val == nil and default or val
  end
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function switch_to_buffer(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  if entry and entry.bufnr then
    vim.api.nvim_set_current_buf(entry.bufnr)
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
  pickers = {
    buffers = {
      mappings = {
        i = { ["<CR>"] = switch_to_buffer },
        n = { ["<CR>"] = switch_to_buffer },
      },
    },
  },
})
