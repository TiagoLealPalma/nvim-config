-- Startup dashboard. Shows automatically on bare `nvim` (no file args).
-- "Open Project" = nvim-only project switch (project.nvim/Telescope).
-- "Dev Setup" = also repoints the claude/shell/lazygit tmux windows —
-- see core/dev-setup.lua.

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                  ",
  "  ███╗   ██╗██╗   ██╗██╗███╗   ███╗              ",
  "  ████╗  ██║██║   ██║██║████╗ ████║              ",
  "  ██╔██╗ ██║██║   ██║██║██╔████╔██║              ",
  "  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║              ",
  "  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║              ",
  "  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝              ",
  "                                                  ",
}

dashboard.section.buttons.val = {
  dashboard.button("p", "  Open Project", ":Telescope projects<CR>"),
  dashboard.button("d", "  Dev Setup", function()
    require("tiago.core.dev-setup").pick_and_launch()
  end),
  dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

dashboard.config.opts.autostart = true

alpha.setup(dashboard.config)
