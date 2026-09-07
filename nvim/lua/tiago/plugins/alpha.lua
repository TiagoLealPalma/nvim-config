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
  vim.api.nvim_set_hl(0, "AlphaButtons", { link = "Normal" })
  vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#e5c07b", bold = true })
  vim.api.nvim_set_hl(0, "AlphaFooter", { link = "Comment" })
  -- Logo is golden — links to String, which matte-black.lua already uses
  -- a desaturated gold for, so it stays "golden" rather than the theme's
  -- orange accent even as colorschemes change.
  vim.api.nvim_set_hl(0, "AlphaLogo", { link = "String" })
  -- Starfield: dim most of the time, briefly brighter at each star's own
  -- twinkle peak.
  vim.api.nvim_set_hl(0, "AlphaStar", { link = "Comment" })
  vim.api.nvim_set_hl(0, "AlphaStarBright", { fg = "#eaeaea" })
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hls })
set_hls()

local nvim_logo = {
  "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
  "████╗  ██║██║   ██║██║████╗ ████║",
  "██╔██╗ ██║██║   ██║██║██╔████╔██║",
  "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

-- Doubled height (each row repeated) for a genuinely bigger logo — safe way
-- to scale up ASCII block art without risking new alignment mistakes, since
-- it's pure duplication of already-correct lines.
local logo_lines = {}
for _, line in ipairs(nvim_logo) do
  table.insert(logo_lines, line)
  table.insert(logo_lines, line)
end

-- Split into display cells (not bytes) up front — the logo is full of
-- multi-byte box-drawing glyphs, so byte-indexing would slice them apart.
-- '\zs' is a Vim regex "start match here" marker with an empty match width,
-- so splitting on it yields one entry per character.
local logo_cells = {}
local logo_width = 0
for _, line in ipairs(logo_lines) do
  local cells = vim.fn.split(line, [[\zs]])
  table.insert(logo_cells, cells)
  logo_width = math.max(logo_width, #cells)
end
local logo_height = #logo_cells

-- Nerd Font glyphs via explicit \u{} escapes (not pasted directly) so the
-- exact codepoint is unambiguous regardless of editor/encoding.
local icon_folder = "\u{f07c}" -- nf-fa-folder_open
local icon_rocket = "\u{f135}" -- nf-fa-rocket
local icon_search = "\u{f002}" -- nf-fa-search
local icon_power = "\u{f011}" -- nf-fa-power_off

local function styled_button(sc, txt, keybind)
  local b = dashboard.button(sc, txt, keybind)
  b.opts.hl = "AlphaButtons"
  b.opts.hl_shortcut = "AlphaShortcut"
  return b
end

dashboard.section.buttons.val = {
  styled_button("p", icon_folder .. "  Open Project", ":Telescope projects<CR>"),
  styled_button("d", icon_rocket .. "  Dev Setup", function()
    require("tiago.core.dev-setup").pick_and_launch()
  end),
  styled_button("f", icon_search .. "  Find File", ":Telescope find_files<CR>"),
  styled_button("q", icon_power .. "  Quit", ":qa<CR>"),
}
-- Needed up front to size the starfield canvas (fills everything above the
-- buttons/footer), so this has to happen before that sizing math below.
local buttons_height = (#dashboard.section.buttons.val * 2) - 1
local footer_height = 1
local bottom_margin = 2

-- Star field spans the whole window above the buttons — not just a small
-- box around the logo — so it reads as a night sky the logo floats in.
-- Star positions are stored as fractions of the canvas (0..1) rather than
-- fixed cells, so they redistribute correctly whenever the window (and so
-- the canvas) is a different size, instead of clumping in one corner.
math.randomseed(os.time())
local STAR_GLYPHS = { ".", "·", "*" }
local TWINKLE_SEQUENCE = { ".", "·", "*", "✦", "*", "·" }
local NUM_STARS = 80
local TWINKLE_CHANCE = 0.18

-- Density falls off toward the bottom of the sky, so it thins out and
-- fades to almost nothing by the time you reach the menu instead of
-- stopping abruptly at a hard edge. Each star gets a fixed "visibility
-- roll" at creation so this filtering is stable frame to frame — only the
-- twinkle glyphs change, stars don't blink in and out of existence.
local function density_at(row_frac)
  return math.max(0, 1 - row_frac ^ 1.6)
end

local stars = {}
for _ = 1, NUM_STARS do
  table.insert(stars, {
    row_frac = math.random(),
    col_frac = math.random(),
    glyph = STAR_GLYPHS[math.random(#STAR_GLYPHS)],
    twinkle = math.random() < TWINKLE_CHANCE,
    phase = math.random(0, #TWINKLE_SEQUENCE - 1),
    visible_roll = math.random(),
  })
end

-- How tall the header canvas should be: whatever's left of the window
-- after the buttons/footer/margins, so the starfield fills the screen
-- instead of a fixed-size box.
local function canvas_height()
  local reserved = buttons_height + footer_height + bottom_margin + 2
  return math.max(logo_height + 4, vim.o.lines - reserved)
end

local function canvas_width()
  return math.max(logo_width + 4, vim.o.columns)
end

-- Renders one frame at the window's current size: an empty grid, stars
-- placed (skipping any that land on the logo, and using the glyph for
-- their phase-shifted position in the twinkle sequence), then the logo
-- stamped on top, centered. Also returns extmark info for the currently
-- bright stars and the logo's own rows, since alpha wipes all highlight
-- extmarks on every redraw and they have to be reapplied after each one.
local function render(tick)
  local w, h = canvas_width(), canvas_height()
  local logo_row = math.max(0, math.floor((h - logo_height) / 2))
  local logo_col = math.max(0, math.floor((w - logo_width) / 2))

  local grid = {}
  for r = 1, h do
    local row = {}
    for c = 1, w do
      row[c] = " "
    end
    grid[r] = row
  end

  local bright_cells = {}
  for _, star in ipairs(stars) do
    local row = math.min(h - 1, math.floor(star.row_frac * h))
    local col = math.min(w - 1, math.floor(star.col_frac * w))
    local on_logo = row >= logo_row and row < logo_row + logo_height and col >= logo_col and col < logo_col + logo_width
    local faded_out = star.visible_roll > density_at(star.row_frac)
    if not on_logo and not faded_out then
      local glyph = star.glyph
      if star.twinkle then
        local idx = ((tick + star.phase) % #TWINKLE_SEQUENCE) + 1
        glyph = TWINKLE_SEQUENCE[idx]
        if glyph == "✦" then
          table.insert(bright_cells, { row = row, col = col })
        end
      end
      grid[row + 1][col + 1] = glyph
    end
  end

  local logo_rows = {}
  for r, cells in ipairs(logo_cells) do
    for c, ch in ipairs(cells) do
      grid[logo_row + r][logo_col + c] = ch
    end
    table.insert(logo_rows, { grid_row = logo_row + r - 1, from_col = logo_col, width = #cells })
  end

  local lines = {}
  for r = 1, h do
    lines[r] = table.concat(grid[r])
  end
  return lines, bright_cells, logo_rows
end

local star_ns = vim.api.nvim_create_namespace("alpha_stars")

-- alpha.draw() (called by AlphaRedraw) wipes all extmarks in the buffer via
-- nvim_buf_clear_namespace(-1, ...) on every redraw, so both the logo's
-- gold color and the twinkle highlight have to be reapplied after each one
-- rather than set once.
local function apply_highlights(lines, bright_cells, logo_rows)
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].filetype ~= "alpha" then
    return
  end
  for _, lr in ipairs(logo_rows) do
    local line = lines[lr.grid_row + 1]
    local byte_start = vim.fn.byteidx(line, lr.from_col)
    local byte_end = vim.fn.byteidx(line, lr.from_col + lr.width)
    pcall(vim.api.nvim_buf_set_extmark, buf, star_ns, lr.grid_row, byte_start, {
      end_col = byte_end,
      hl_group = "AlphaLogo",
    })
  end
  for _, cell in ipairs(bright_cells) do
    local line = lines[cell.row + 1]
    local byte_start = vim.fn.byteidx(line, cell.col)
    local byte_end = vim.fn.byteidx(line, cell.col + 1)
    pcall(vim.api.nvim_buf_set_extmark, buf, star_ns, cell.row, byte_start, {
      end_col = byte_end,
      hl_group = "AlphaStarBright",
    })
  end
end

do
  local lines, bright_cells, logo_rows = render(0)
  dashboard.section.header.val = lines
  dashboard.section.header.opts.hl = "AlphaStar"
  vim.schedule(function() apply_highlights(lines, bright_cells, logo_rows) end)
end

-- The starfield canvas already fills the space above the buttons, so there
-- is no separate top/middle padding to compute — just a small fixed gap
-- before the buttons.
dashboard.config.layout = {
  dashboard.section.header,
  { type = "padding", val = 1 },
  dashboard.section.buttons,
  dashboard.section.footer,
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

-- Twinkle animation: slow (every 600ms) and only ticking while the
-- dashboard is actually the current buffer, so it costs nothing once
-- you've opened a file.
local uv = vim.uv or vim.loop
local twinkle_timer = nil
local tick = 0

local function stop_twinkle()
  if twinkle_timer then
    twinkle_timer:stop()
    twinkle_timer:close()
    twinkle_timer = nil
  end
end

local function start_twinkle()
  stop_twinkle()
  twinkle_timer = uv.new_timer()
  twinkle_timer:start(
    600,
    600,
    vim.schedule_wrap(function()
      local buf = vim.api.nvim_get_current_buf()
      if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].filetype ~= "alpha" then
        stop_twinkle()
        return
      end
      tick = tick + 1
      local lines, bright_cells, logo_rows = render(tick)
      dashboard.section.header.val = lines
      pcall(vim.cmd.AlphaRedraw)
      apply_highlights(lines, bright_cells, logo_rows)
    end)
  )
end

vim.api.nvim_create_autocmd("User", { pattern = "AlphaReady", callback = start_twinkle })
vim.api.nvim_create_autocmd("User", { pattern = "AlphaClosed", callback = stop_twinkle })
