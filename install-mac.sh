#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install neovim git zig fd ripgrep tmux fzf
brew install --cask font-fira-code-nerd-font

mkdir -p "$HOME/.config" "$HOME/.config/tmux" "$HOME/.local/bin"

ln -sfn "$script_dir/nvim" "$HOME/.config/nvim"
ln -sf "$script_dir/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
ln -sf "$script_dir/bin/dev" "$HOME/.local/bin/dev"

echo "Linked nvim config -> ~/.config/nvim"
echo "Linked tmux config -> ~/.config/tmux/tmux.conf"
echo "Linked dev launcher -> ~/.local/bin/dev (make sure ~/.local/bin is in your PATH)"

tpm_dir="$HOME/.tmux/plugins/tpm"
if [ ! -d "$tpm_dir" ]; then
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
fi
"$tpm_dir/scripts/install_plugins.sh" || \
  echo "tpm plugin install failed — run 'Ctrl-t I' inside tmux to retry manually."

echo "Done. Open a new terminal to use the updated font."
