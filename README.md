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

## Install

Run the script for your OS — it installs all dependencies above.

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

## Setup

1. Run the install script for your OS.
2. Clone this repo and symlink the `nvim` folder to your Neovim config directory:

   **macOS / Linux**
   ```sh
   git clone https://github.com/youruser/nvim-config.git
   ln -s "$PWD/nvim-config/nvim" ~/.config/nvim
   ```

   **Windows** (PowerShell as Administrator)
   ```powershell
   git clone https://github.com/youruser/nvim-config.git
   New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "$(pwd)\nvim-config\nvim"
   ```

3. Open Neovim — lazy.nvim auto-installs plugins on first launch.
4. Run `:TSUpdate` to build Treesitter parsers.
