-- Custom colorscheme matching the Omarchy "Matte Black" terminal theme,
-- so nvim and the terminal/tmux look consistent.
-- Hex values pulled directly from omarchy's matte-black/alacritty.toml.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "matte-black"

local c = {
  bg = "#121212",
  bg_alt = "#333333",
  fg = "#bebebe",
  black = "#333333",
  black_bright = "#8a8a8d",
  red = "#D35F5F",
  red_bright = "#B91C1C",
  gold = "#D9B361", -- theme calls this "green" (desaturated from #FFC107, easier on the eyes)
  gold_bright = "#D9B361",
  crimson = "#b91c1c", -- theme calls this "yellow"
  crimson_bright = "#b90a0a",
  orange = "#e68e0d", -- theme calls this "blue"
  orange_bright = "#f59e0b",
  bracket = "#f2e2c9", -- near-white with a faint orange tint, for unmatched brackets/braces/parens
  green = "#8fd9a0", -- bright, low-saturation green for diff/gitsigns additions
  diff_red = "#e29a9a", -- bright, low-saturation red for diff/gitsigns deletions
  magenta = "#D35F5F",
  magenta_bright = "#B91C1C",
  cyan = "#bebebe", -- theme calls this "cyan", same as fg
  cyan_bright = "#eaeaea",
  white = "#bebebe",
  white_bright = "#ffffff",
  cursor = "#eaeaea",
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
hl("LineNr", { fg = c.black_bright })
hl("SignColumn", { bg = c.bg })
hl("Visual", { bg = c.bg_alt })
hl("Search", { fg = c.bg, bg = c.gold })
hl("IncSearch", { fg = c.bg, bg = c.orange })
hl("MatchParen", { fg = c.orange_bright, bold = true })
hl("Folded", { fg = c.black_bright, bg = c.bg_alt })
hl("WinSeparator", { fg = c.black_bright })
hl("VertSplit", { fg = c.black_bright })
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
hl("NonText", { fg = c.black_bright })
hl("Whitespace", { fg = c.black_bright })
hl("ColorColumn", { bg = c.bg_alt })

-- Diffs / git
hl("DiffAdd", { fg = c.green, bg = c.bg_alt })
hl("DiffChange", { fg = c.green, bg = c.bg_alt })
hl("DiffDelete", { fg = c.diff_red, bg = c.bg_alt })
hl("DiffText", { fg = c.diff_red, bg = c.bg_alt, bold = true })

-- Syntax
hl("Comment", { fg = c.black_bright, italic = true })
hl("String", { fg = c.gold })
hl("Character", { fg = c.gold })
hl("Number", { fg = c.magenta })
hl("Boolean", { fg = c.magenta })
hl("Float", { fg = c.magenta })
hl("Function", { fg = c.orange })
hl("Identifier", { fg = c.fg })
hl("Statement", { fg = c.red })
hl("Keyword", { fg = c.red })
hl("Conditional", { fg = c.red })
hl("Repeat", { fg = c.red })
hl("Operator", { fg = c.fg })
hl("Type", { fg = c.cyan_bright })
hl("StorageClass", { fg = c.cyan_bright })
hl("Structure", { fg = c.cyan_bright })
hl("Constant", { fg = c.magenta })
hl("PreProc", { fg = c.orange })
hl("Include", { fg = c.orange })
hl("Special", { fg = c.orange })
hl("Delimiter", { fg = c.bracket })
hl("Error", { fg = c.crimson_bright, bold = true })
hl("Todo", { fg = c.bg, bg = c.gold, bold = true })

-- Treesitter
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.orange })
hl("@function", { link = "Function" })
hl("@function.builtin", { fg = c.orange })
hl("@keyword", { link = "Keyword" })
hl("@string", { link = "String" })
hl("@number", { link = "Number" })
hl("@comment", { link = "Comment" })
hl("@type", { link = "Type" })
hl("@constant", { link = "Constant" })
hl("@constant.builtin", { fg = c.magenta })
hl("@punctuation.bracket", { fg = c.bracket })
hl("@punctuation.delimiter", { fg = c.fg })
hl("@tag", { fg = c.red })
hl("@tag.attribute", { fg = c.gold })
hl("@property", { fg = c.cyan_bright })

-- LSP diagnostics
hl("DiagnosticError", { fg = c.crimson_bright })
hl("DiagnosticWarn", { fg = c.gold })
hl("DiagnosticInfo", { fg = c.cyan_bright })
hl("DiagnosticHint", { fg = c.magenta })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.crimson_bright })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.gold })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.cyan_bright })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.magenta })

-- gitsigns
hl("GitSignsAdd", { fg = c.green })
hl("GitSignsChange", { fg = c.green })
hl("GitSignsDelete", { fg = c.diff_red })

-- bufferline / nvim-tree fall back to the core groups above (Directory,
-- TabLine, etc.) reasonably well without needing explicit overrides.
