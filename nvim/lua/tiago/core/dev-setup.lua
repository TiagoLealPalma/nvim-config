-- "Dev Setup" dashboard action: pick a project and switch to its own
-- independent tmux session (nvim/claude/shell/lazygit), creating it via
-- `dev --no-attach` if it doesn't exist yet. Doesn't touch the current
-- session — `tmux switch-client` just changes what the terminal displays.

local M = {}

-- Must match bin/dev's basename + `${session//[^a-zA-Z0-9_-]/-}` sanitization.
local function session_name_for(dir)
  local name = vim.fn.fnamemodify(dir, ":t")
  return (name:gsub("[^%w_-]", "-"))
end

function M.pick_and_launch()
  if vim.env.TMUX == nil then
    vim.notify("Not running inside tmux — Dev Setup needs a tmux client to switch into.", vim.log.levels.WARN)
    return
  end

  local projects_root = vim.env.DEV_PROJECTS_ROOT or (vim.env.HOME .. "/Git")
  local dirs = vim.fn.systemlist(string.format(
    "find %s -mindepth 1 -maxdepth 2 -type d -name .git 2>/dev/null | sed 's|/\\.git$||'",
    vim.fn.shellescape(projects_root)
  ))

  if #dirs == 0 then
    vim.notify("No projects found under " .. projects_root, vim.log.levels.WARN)
    return
  end

  vim.ui.select(dirs, { prompt = "Dev Setup: pick a project" }, function(dir)
    if not dir then
      return
    end

    vim.fn.system(string.format("dev --no-attach %s", vim.fn.shellescape(dir)))
    if vim.v.shell_error ~= 0 then
      vim.notify("dev --no-attach failed for " .. dir, vim.log.levels.ERROR)
      return
    end

    local session = session_name_for(dir)
    vim.fn.system(string.format("tmux switch-client -t %s", vim.fn.shellescape(session)))
  end)
end

return M
