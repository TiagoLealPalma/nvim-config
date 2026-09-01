# nvim-config

my neovim config. yes, I could've just used VSCode.

## Dependencies

| Dependency | Purpose |
|---|---|
| [Neovim](https://neovim.io/) >= 0.9 | the whole point |
| [Git](https://git-scm.com/) | plugin manager (lazy.nvim) |
| [zig](https://ziglang.org/download/) | C compiler for Treesitter parsers |
| [fd](https://github.com/sharkdp/fd) | fast file search (Telescope) |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | live grep (Telescope) |
| [FiraCode Nerd Font](https://www.nerdfonts.com/) | icons everywhere |
| [tmux](https://github.com/tmux/tmux) | terminal multiplexer (Linux/macOS; needs WSL on Windows) |
| [fzf](https://github.com/junegunn/fzf) | fuzzy project picker for the `dev` launcher |

## Install

Clone the repo, then run the script for your OS — it installs all dependencies above and symlinks the configs into place (`~/.config/nvim`, `~/.config/tmux/tmux.conf`, `~/.local/bin/dev`).

```sh
git clone https://github.com/youruser/nvim-config.git
cd nvim-config
```

**macOS**
```sh
bash install-mac.sh
```

**Linux**
```sh
bash install-linux.sh
```

**Windows** (PowerShell as Administrator)
```powershell
.\install-windows.ps1
```
Only the nvim config is linked natively on Windows — tmux doesn't run outside WSL, so run `install-linux.sh` inside WSL too if you want the tmux/`dev` setup there.

## Setup

1. Run the install script for your OS (above).
2. Open Neovim — lazy.nvim auto-installs plugins on first launch.
3. Run `:TSUpdate` to build Treesitter parsers.
4. Run `dev` from any project directory to launch the tmux layout (`nvim` / `claude` / `shell` windows).

## Plugins

| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | plugin manager |
| [nordic.nvim](https://github.com/AlexvZyl/nordic.nvim) | colorscheme (catppuccin / tokyonight / nightfox also available) |
| [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) | file explorer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | fuzzy finder |
| [project.nvim](https://github.com/ahmedkhalf/project.nvim) | project switcher |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | buffer tab bar |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | status line |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | syntax highlighting |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason](https://github.com/williamboman/mason.nvim) | LSP (ts_ls, html, cssls, jsonls) |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | completion |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | formatting (prettier, project-local) |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | git decorations |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | bracket auto-close |

## Keymaps

Leader key is `Space`.

### General

| Key | Action |
|---|---|
| `jk` | Exit insert mode |
| `Ctrl+s` | Save file |
| `<leader>ev` | Edit init.lua |
| `<leader>sv` | Reload config |

### Files & Navigation

| Key | Action |
|---|---|
| `<leader><leader>` | Find files (Telescope) |
| `<leader>fg` | Live grep |
| `<leader>fb` | Switch buffer — jumps to existing tab |
| `<leader>fh` | Search help tags |
| `<leader>p` | Project picker |
| `<leader>ft` | Toggle file tree |
| `Ctrl+h/j/k/l` | Move to split in that direction (also crosses into tmux panes) |

### Buffers

| Key | Action |
|---|---|
| `Shift+h` | Previous buffer |
| `Shift+l` | Next buffer |
| `<leader>1`–`9` | Jump to buffer by index |
| `<leader>x` | Close current buffer (keeps window) |

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | List references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>ds` | Document symbols |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>e` | Show diagnostic float |

### Git

| Key | Action |
|---|---|
| `]h` / `[h` | Next / previous hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hb` | Blame line |

### Other

| Key | Action |
|---|---|
| `<leader>f` | Format buffer (prettier) |
| `<leader>+` / `<leader>-` | Increase / decrease font size (GUI only) |

## Tmux

Run `dev` to open a tmux session with three windows: `nvim`, `claude`, `shell`.
- `dev` — if cwd is already a git repo, uses it; otherwise fuzzy-picks one from `~/Git` (override with `DEV_PROJECTS_ROOT`)
- `dev <path>` — use that directory directly

Prefix is `Ctrl+t` (not the tmux default `Ctrl+b`).

| Key | Action |
|---|---|
| `Ctrl+t s` / `\|` | Split pane side-by-side |
| `Ctrl+t -` | Split pane top/bottom |
| `Ctrl+t n` | New window |
| `Ctrl+t q` | Kill current window |
| `Ctrl+t x` | Kill current pane (confirms) |
| `Ctrl+h/j/k/l` | Move between panes (crosses into nvim splits) |
| `Alt+1`–`9` | Jump to window N, creating it if it doesn't exist |
