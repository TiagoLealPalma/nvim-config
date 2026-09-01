#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_font() {
  local font_dir="$HOME/.local/share/fonts"
  local tmp_zip="/tmp/FiraCodeNerdFont-$$.zip"
  mkdir -p "$font_dir"
  echo "Downloading FiraCode Nerd Font..."
  curl -fLo "$tmp_zip" \
    "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
  unzip -oq "$tmp_zip" -d "$font_dir"
  rm -f "$tmp_zip"
  fc-cache -f "$font_dir"
  echo "Font installed."
}

link_configs() {
  mkdir -p "$HOME/.config" "$HOME/.config/tmux" "$HOME/.local/bin"

  ln -sfn "$script_dir/nvim" "$HOME/.config/nvim"
  ln -sf "$script_dir/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
  ln -sf "$script_dir/bin/dev" "$HOME/.local/bin/dev"

  echo "Linked nvim config -> ~/.config/nvim"
  echo "Linked tmux config -> ~/.config/tmux/tmux.conf"
  echo "Linked dev launcher -> ~/.local/bin/dev (make sure ~/.local/bin is in your PATH)"
}

# Check /etc/pacman.conf, not just `command -v pacman` — Debian/Ubuntu ship an
# unrelated game package also called "pacman", which would otherwise misdetect.
if [ -f /etc/pacman.conf ]; then
  sudo pacman -Sy --noconfirm neovim git zig fd ripgrep tmux unzip
  install_font

elif command -v apt >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y neovim git fd-find ripgrep snapd tmux unzip
  # fd is installed as fdfind on Debian/Ubuntu — make an alias
  if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
    echo "Linked fdfind -> ~/.local/bin/fd (make sure ~/.local/bin is in your PATH)"
  fi
  # zig is not in apt; install via snap
  sudo snap install zig --classic --beta
  install_font

elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y neovim git zig fd-find ripgrep tmux unzip
  install_font

else
  echo "Unsupported package manager. Install neovim, git, zig, fd, ripgrep, and tmux manually."
  exit 1
fi

link_configs

echo "Done."
