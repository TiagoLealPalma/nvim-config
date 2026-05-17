#!/usr/bin/env bash
set -e

install_font() {
  local font_dir="$HOME/.local/share/fonts"
  mkdir -p "$font_dir"
  echo "Downloading FiraCode Nerd Font..."
  curl -fLo "$font_dir/FiraCodeNerdFont-Regular.ttf" \
    "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf"
  fc-cache -fv
  echo "Font installed."
}

if command -v pacman &>/dev/null; then
  sudo pacman -Sy --noconfirm neovim git zig fd ripgrep
  install_font

elif command -v apt &>/dev/null; then
  sudo apt update
  sudo apt install -y neovim git fd-find ripgrep snapd
  # fd is installed as fdfind on Debian/Ubuntu — make an alias
  if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
    echo "Linked fdfind -> ~/.local/bin/fd (make sure ~/.local/bin is in your PATH)"
  fi
  # zig is not in apt; install via snap
  sudo snap install zig --classic --beta
  install_font

elif command -v dnf &>/dev/null; then
  sudo dnf install -y neovim git zig fd-find ripgrep
  install_font

else
  echo "Unsupported package manager. Install neovim, git, zig, fd, and ripgrep manually."
  exit 1
fi

echo "Done."
