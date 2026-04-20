-- Centralized keymap reference for the entire configuration.
-- Keymaps defined here are global. Keymaps defined elsewhere are buffer-local
-- and noted with their source file so this file serves as a single overview.
--
-- ┌──────────────┬────────────────────────────────────────────────────────┐
-- │ GENERAL      │                                                        │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ jk           │ Exit insert mode                                       │
-- │ <C-s>        │ Save file                                              │
-- │ <leader>ev   │ Edit init.lua ($MYVIMRC)                               │
-- │ <leader>sv   │ Source init.lua (reload config)                        │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ FILE NAV     │                                                        │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ <leader>p    │ Project picker (project.nvim + Telescope)              │
-- │ <leader>ft   │ Toggle file tree (nvim-tree)                           │
-- │ <leader><leader>│ Find files (Telescope)                                │
-- │ <leader>fg   │ Live grep (Telescope)                                  │
-- │ <leader>fb   │ Switch buffer (Telescope)                              │
-- │ <leader>fh   │ Search help tags (Telescope)                           │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ TERMINAL     │ ↳ defined in core/terminal.lua                         │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ <leader>t    │ Open floating terminal in current file's directory     │
-- │ q            │ Close floating terminal (terminal mode, buffer-local)  │
-- │ <Esc>        │ Close floating terminal (terminal mode, buffer-local)  │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ LSP          │ ↳ defined in plugins/lsp.lua (buffer-local, LspAttach) │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ gd           │ Go to definition                                       │
-- │ gD           │ Go to declaration                                      │
-- │ gi           │ Go to implementation                                   │
-- │ gr           │ List references                                        │
-- │ K            │ Hover documentation                                    │
-- │ <leader>rn   │ Rename symbol                                          │
-- │ <leader>ca   │ Code action                                            │
-- │ <leader>ds   │ Document symbols                                       │
-- │ [d           │ Previous diagnostic                                    │
-- │ ]d           │ Next diagnostic                                        │
-- │ <leader>e    │ Show diagnostic float                                  │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ GIT          │ ↳ defined in plugins/gitsigns.lua (buffer-local)       │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ ]h           │ Next hunk                                              │
-- │ [h           │ Previous hunk                                          │
-- │ <leader>hp   │ Preview hunk                                           │
-- │ <leader>hs   │ Stage hunk                                             │
-- │ <leader>hr   │ Reset hunk                                             │
-- │ <leader>hb   │ Blame line                                             │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ COMPLETION   │ ↳ defined in core/completion.lua (insert mode)         │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ <C-Space>    │ Trigger completion menu                                │
-- │ <CR>         │ Confirm selected completion                            │
-- │ <Tab>        │ Select next completion item                            │
-- │ <S-Tab>      │ Select previous completion item                        │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ GUI FONT     │ ↳ defined in ui/font.lua (GUI clients only)            │
-- ├──────────────┼────────────────────────────────────────────────────────┤
-- │ <leader>+    │ Increase font size                                     │
-- │ <leader>-    │ Decrease font size                                     │
-- └──────────────┴────────────────────────────────────────────────────────┘

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "jk", "<Esc>", opts)
map("n", "<C-s>", ":w<CR>", opts)

map("n", "<leader>ev", ":edit $MYVIMRC<CR>", opts)
map("n", "<leader>sv", ":source $MYVIMRC<CR>", opts)

map("n", "<leader>p", ":Telescope projects<CR>", opts)
map("n", "<leader>ft", ":NvimTreeToggle<CR>", opts)
map("n", "<leader><leader>", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

local terminal = require("tiago.core.terminal")
vim.keymap.set("n", "<leader>t", terminal.open_floating_terminal, {
	desc = "Floating terminal (cwd = file dir)",
})
