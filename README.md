# nvim-config

Personal Neovim configuration.

## Dependencies

| Dependency | Purpose | Install (Windows) |
|---|---|---|
| [Neovim](https://neovim.io/) (>= 0.9) | Editor | `winget install Neovim.Neovim` |
| [Git](https://git-scm.com/) | Plugin manager (lazy.nvim) | `winget install Git.Git` |
| [zig](https://ziglang.org/download/) | C compiler for Treesitter parsers | `winget install zig.zig` |
| [fd](https://github.com/sharkdp/fd) | Fast file search (Telescope) | `winget install sharkdp.fd` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Live grep (Telescope) | `winget install BurntSushi.ripgrep` |
| [A Nerd Font](https://www.nerdfonts.com/) | Icons (nvim-tree, lualine) | Download from website |

## Setup

1. Install the dependencies above.
2. Clone this repo and symlink/copy the `nvim` folder to your Neovim config directory:
   - **Windows:** `%LOCALAPPDATA%\nvim`
   - **Linux/macOS:** `~/.config/nvim`
3. Open Neovim — lazy.nvim will auto-install plugins on first launch.
4. Run `:TSUpdate` to build Treesitter parsers.
