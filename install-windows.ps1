#Requires -RunAsAdministrator

winget install --id Neovim.Neovim -e
winget install --id Git.Git -e
winget install --id zig.zig -e
winget install --id sharkdp.fd -e
winget install --id BurntSushi.ripgrep.MSVC -e

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "$scriptDir\nvim" -Force | Out-Null
Write-Host "Linked nvim config -> $env:LOCALAPPDATA\nvim"

Write-Host ""
Write-Host "Done. Install FiraCode Nerd Font from https://www.nerdfonts.com/ and set it in your terminal."
Write-Host ""
Write-Host "tmux does not run natively on Windows. To use the tmux setup (tmux/tmux.conf, bin/dev)," -ForegroundColor Yellow
Write-Host "install WSL, clone this repo inside it (or access it via /mnt/c/...), and run install-linux.sh there." -ForegroundColor Yellow
