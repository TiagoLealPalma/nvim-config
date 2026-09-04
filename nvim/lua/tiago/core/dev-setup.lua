-- "Dev Setup" dashboard action: pick a project (same Telescope picker + same
-- project.nvim history "p"/Open Project uses) and hand off to its own
-- independent tmux session (nvim/claude/shell/lazygit), creating it via
-- `dev --no-attach` if it doesn't exist yet.
--
-- Two paths depending on whether nvim is already inside tmux:
--   - Inside tmux: `tmux switch-client` just changes what the terminal
--     displays, current session keeps running untouched in the background.
--   - Outside tmux: nvim can't turn a plain terminal into a tmux client by
--     itself, so it writes the target session name to a marker file and
--     quits. The `nvim` shell function (shell/nvim-wrapper.sh) checks for
--     that marker after nvim exits and execs `tmux attach` in its place —
--     nvim acts purely as a project picker here, then yields the terminal.

local M = {}

local pending_file = vim.env.HOME .. "/.cache/nvim-dev-setup-pending"

-- Must match bin/dev's basename + `${session//[^a-zA-Z0-9_-]/-}` sanitization.
local function session_name_for(dir)
  local name = vim.fn.fnamemodify(dir, ":t")
  return (name:gsub("[^%w_-]", "-"))
end

local function launch(dir)
  vim.fn.system(string.format("dev --no-attach %s", vim.fn.shellescape(dir)))
  if vim.v.shell_error ~= 0 then
    vim.notify("dev --no-attach failed for " .. dir, vim.log.levels.ERROR)
    return
  end

  local session = session_name_for(dir)

  if vim.env.TMUX ~= nil then
    vim.fn.system(string.format("tmux switch-client -t %s", vim.fn.shellescape(session)))
  else
    vim.fn.writefile({ session }, pending_file)
    vim.cmd("qa")
  end
end

function M.pick_and_launch()
  local history = require("project_nvim.utils.history")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local telescope_config = require("telescope.config").values
  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")

  local results = history.get_recent_projects()
  if #results == 0 then
    vim.notify("No recent projects — open one with 'p' first.", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "Dev Setup: pick a project",
    finder = finders.new_table({ results = results }),
    sorter = telescope_config.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local entry = state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          launch(entry.value)
        end
      end)
      return true
    end,
  }):find()
end

return M
