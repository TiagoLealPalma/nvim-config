-- Startup dashboard. Shows automatically on bare `nvim` (no file args).
-- "Open Project" = nvim-only project switch (project.nvim/Telescope).
-- "Dev Setup" = also hands off to that project's own tmux session —
-- see core/dev-setup.lua.

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Most are linked (not hardcoded) so they adapt to whatever colorscheme is
-- active. AlphaShortcut is a fixed yellow instead — hotkey letters staying
-- visually consistent matters more than matching the theme, especially
-- since the theme keeps changing. Re-applied on every ColorScheme event
-- since `hi clear` (used by custom colorschemes like colors/ristretto.lua)
-- wipes plain nvim_set_hl calls made before it.
local function set_hls()
  vim.api.nvim_set_hl(0, "AlphaHeader", { link = "Special" })
  vim.api.nvim_set_hl(0, "AlphaButtons", { link = "Normal" })
  vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#e5c07b", bold = true })
  vim.api.nvim_set_hl(0, "AlphaFooter", { link = "Comment" })
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hls })
set_hls()

local nvim_logo = {
  "  ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
  "  ████╗  ██║██║   ██║██║████╗ ████║",
  "  ██╔██╗ ██║██║   ██║██║██╔████╔██║",
  "  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

-- Doubled height (each row repeated) for a genuinely bigger logo — safe way
-- to scale up ASCII block art without risking new alignment mistakes, since
-- it's pure duplication of already-correct lines.
dashboard.section.header.val = {}
for _, line in ipairs(nvim_logo) do
  table.insert(dashboard.section.header.val, line)
  table.insert(dashboard.section.header.val, line)
end
dashboard.section.header.opts.hl = "AlphaHeader"

-- Header starts ~33% down the window; buttons/footer anchored near the
-- bottom via a dynamically-computed gap. Both scale with terminal size
-- instead of being fixed guesses.
local function top_padding()
  return math.max(1, math.floor(vim.o.lines * 0.33))
end
local header_height = #dashboard.section.header.val
local buttons_height = (#dashboard.section.buttons.val * 2) - 1
local footer_height = 1
local bottom_margin = 2

local function middle_gap()
  local used = top_padding() + header_height + buttons_height + footer_height + bottom_margin
  return math.max(1, vim.o.lines - used)
end

dashboard.config.layout = {
  { type = "padding", val = top_padding },
  dashboard.section.header,
  { type = "padding", val = middle_gap },
  dashboard.section.buttons,
  dashboard.section.footer,
}

local function styled_button(sc, txt, keybind)
  local b = dashboard.button(sc, txt, keybind)
  b.opts.hl = "AlphaButtons"
  b.opts.hl_shortcut = "AlphaShortcut"
  return b
end

-- Nerd Font glyphs via explicit \u{} escapes (not pasted directly) so the
-- exact codepoint is unambiguous regardless of editor/encoding.
local icon_folder = "\u{f07c}" -- nf-fa-folder_open
local icon_rocket = "\u{f135}" -- nf-fa-rocket
local icon_search = "\u{f002}" -- nf-fa-search
local icon_power = "\u{f011}" -- nf-fa-power_off

dashboard.section.buttons.val = {
  styled_button("p", icon_folder .. "  Open Project", ":Telescope projects<CR>"),
  styled_button("d", icon_rocket .. "  Dev Setup", function()
    require("tiago.core.dev-setup").pick_and_launch()
  end),
  styled_button("f", icon_search .. "  Find File", ":Telescope find_files<CR>"),
  styled_button("q", icon_power .. "  Quit", ":qa<CR>"),
}

local function footer()
  local ok, lazy_stats = pcall(function() return require("lazy").stats() end)
  if not ok then
    return ""
  end
  local ms = math.floor((lazy_stats.startuptime or 0) * 100 + 0.5) / 100
  return string.format("⚡ %d plugins loaded in %sms", lazy_stats.loaded, ms)
end
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "AlphaFooter"

dashboard.config.opts.autostart = true

alpha.setup(dashboard.config)

-- Footer stats aren't final until lazy finishes loading everything.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    dashboard.section.footer.val = footer()
    pcall(vim.cmd.AlphaRedraw)
  end,
})
