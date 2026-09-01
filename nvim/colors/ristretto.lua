-- Custom colorscheme matching the Omarchy "Ristretto" terminal theme
-- (Monokai Ristretto palette), so nvim and the terminal/tmux look consistent.
-- Hex values pulled directly from omarchy's ristretto/alacritty.toml.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "ristretto"

local c = {
  bg = "#2c2525",
  bg_alt = "#403e41",
  fg = "#e6d9db",
  black = "#72696a",
  black_bright = "#948a8b",
  red = "#fd6883",
  red_bright = "#ff8297",
  green = "#adda78",
  green_bright = "#c8e292",
  yellow = "#f9cc6c",
  yellow_bright = "#fcd675",
  orange = "#f38d70", -- theme calls this "blue", it's actually orange
  orange_bright = "#f8a788",
  magenta = "#a8a9eb",
  magenta_bright = "#bebffd",
  cyan = "#85dacc",
  cyan_bright = "#9bf1e1",
  white = "#e6d9db",
  white_bright = "#f1e5e7",
  cursor = "#c3b7b8",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Core editor UI
hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg_alt })
hl("FloatBorder", { fg = c.black_bright, bg = c.bg_alt })
hl("Cursor", { fg = c.bg, bg = c.cursor })
hl("CursorLine", { bg = c.bg_alt })
hl("CursorLineNr", { fg = c.orange, bold = true })
hl("LineNr", { fg = c.black })
hl("SignColumn", { bg = c.bg })
hl("Visual", { bg = c.bg_alt })
hl("Search", { fg = c.bg, bg = c.yellow })
hl("IncSearch", { fg = c.bg, bg = c.orange })
hl("MatchParen", { fg = c.orange, bold = true })
hl("Folded", { fg = c.black_bright, bg = c.bg_alt })
hl("WinSeparator", { fg = c.black })
hl("VertSplit", { fg = c.black })
hl("StatusLine", { fg = c.fg, bg = c.bg_alt })
hl("StatusLineNC", { fg = c.black_bright, bg = c.bg })
hl("TabLine", { fg = c.black_bright, bg = c.bg_alt })
hl("TabLineSel", { fg = c.fg, bg = c.bg })
hl("Pmenu", { fg = c.fg, bg = c.bg_alt })
hl("PmenuSel", { fg = c.bg, bg = c.orange })
hl("PmenuSbar", { bg = c.bg_alt })
hl("PmenuThumb", { bg = c.black_bright })
hl("Directory", { fg = c.orange })
hl("Title", { fg = c.orange, bold = true })
hl("NonText", { fg = c.black })
hl("Whitespace", { fg = c.black })
hl("ColorColumn", { bg = c.bg_alt })

-- Diffs / git
hl("DiffAdd", { fg = c.green, bg = c.bg_alt })
hl("DiffChange", { fg = c.yellow, bg = c.bg_alt })
hl("DiffDelete", { fg = c.red, bg = c.bg_alt })
hl("DiffText", { fg = c.orange, bg = c.bg_alt })

-- Syntax
hl("Comment", { fg = c.black_bright, italic = true })
hl("String", { fg = c.green })
hl("Character", { fg = c.green })
hl("Number", { fg = c.magenta })
hl("Boolean", { fg = c.magenta })
hl("Float", { fg = c.magenta })
hl("Function", { fg = c.yellow })
hl("Identifier", { fg = c.fg })
hl("Statement", { fg = c.red })
hl("Keyword", { fg = c.red })
hl("Conditional", { fg = c.red })
hl("Repeat", { fg = c.red })
hl("Operator", { fg = c.fg })
hl("Type", { fg = c.cyan })
hl("StorageClass", { fg = c.cyan })
hl("Structure", { fg = c.cyan })
hl("Constant", { fg = c.magenta })
hl("PreProc", { fg = c.orange })
hl("Include", { fg = c.orange })
hl("Special", { fg = c.orange })
hl("Delimiter", { fg = c.fg })
hl("Error", { fg = c.red, bold = true })
hl("Todo", { fg = c.bg, bg = c.yellow, bold = true })

-- Treesitter
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.orange })
hl("@function", { link = "Function" })
hl("@function.builtin", { fg = c.yellow })
hl("@keyword", { link = "Keyword" })
hl("@string", { link = "String" })
hl("@number", { link = "Number" })
hl("@comment", { link = "Comment" })
hl("@type", { link = "Type" })
hl("@constant", { link = "Constant" })
hl("@constant.builtin", { fg = c.magenta })
hl("@punctuation.bracket", { fg = c.fg })
hl("@punctuation.delimiter", { fg = c.fg })
hl("@tag", { fg = c.red })
hl("@tag.attribute", { fg = c.yellow })
hl("@property", { fg = c.cyan })

-- LSP diagnostics
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.cyan })
hl("DiagnosticHint", { fg = c.magenta })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.cyan })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.magenta })

-- gitsigns
hl("GitSignsAdd", { fg = c.green })
hl("GitSignsChange", { fg = c.yellow })
hl("GitSignsDelete", { fg = c.red })

-- bufferline / nvim-tree fall back to the core groups above (Directory,
-- TabLine, etc.) reasonably well without needing explicit overrides.
