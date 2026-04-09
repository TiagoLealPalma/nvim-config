-- Entry point for the Neovim configuration.
-- Loads options first (mapleader must be set before lazy),
-- then plugins via lazy.nvim, then keymaps, autocmds, and UI.

require("tiago.core.options")
require("tiago.plugins.lazy")
require("tiago.core.keymaps")
require("tiago.core.autocmds")

require("tiago.ui.theme")
require("tiago.ui.font")
