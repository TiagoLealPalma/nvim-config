#!/usr/bin/env bash
set -e

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install neovim git zig fd ripgrep
brew install --cask font-fira-code-nerd-font

echo "Done. Open a new terminal to use the updated font."
