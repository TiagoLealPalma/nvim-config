#Requires -RunAsAdministrator

winget install --id Neovim.Neovim -e
winget install --id Git.Git -e
winget install --id zig.zig -e
winget install --id sharkdp.fd -e
winget install --id BurntSushi.ripgrep.MSVC -e

Write-Host ""
Write-Host "Done. Install FiraCode Nerd Font from https://www.nerdfonts.com/ and set it in your terminal."
