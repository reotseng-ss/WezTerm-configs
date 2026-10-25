# WezTerm Configs

Personal WezTerm configuration for Windows with WSL as the primary shell environment.

## Overview

- Default shell domain on Windows: `wsl:ubuntu-zsh`
- Fallback WSL shell domain: `wsl:ubuntu-bash`
- Local launch menu entries: PowerShell, Command Prompt, MSYS2, WSL Bash, Git Bash
- Custom key bindings for tabs, panes, resizing, and background selection

## Requirements

### Windows

- [WezTerm](https://wezfurlong.org/wezterm/installation.html)
- [JetBrainsMono Nerd Font](https://github.com/DevelopersCommunity/wix-JetBrainsMonoNF) — install via `winget install -e --id DEVCOM.JetBrainsMonoNerdFont --source winget`
- WSL with an Ubuntu distribution installed

## Install This Config

Clone this repository into your WezTerm config directory:

### Windows

```powershell
git clone git@github.com:reotseng-ss/WezTerm-configs.git $HOME/.config/wezterm
```

Then run the WSL setup (zsh, Oh My Zsh, nnn with previews) inside WSL:

```bash
bash /mnt/c/Users/<windows-user>/.config/wezterm/wsl/setup.sh
```

## Machine-Specific Settings

- [config/domains.lua](./config/domains.lua) for WSL domains and default shell domain
- [config/launch.lua](./config/launch.lua) for local shell launch entries
- [config/fonts.lua](./config/fonts.lua) if your installed font names differ

## Workflow Notes

- `Alt+e` sends `nvim` in the current shell
- `Alt+t` opens a new tab in the default domain
- `Alt+Ctrl+t` opens a new tab in `wsl:ubuntu-bash`
- `Alt+y` opens `nnn` in a new tab with the [preview-tui](https://github.com/jarun/nnn/blob/master/plugins/preview-tui) plugin (needs `wsl/setup.sh`)
- Right-clicking the new-tab button opens the custom launch/domain selector


## Notes

- This config assumes your WSL distribution is named `Ubuntu`
- The default Windows startup domain is currently `wsl:ubuntu-zsh`
- Oh My Zsh requires `zsh`; it is not a separate shell by itself

## References

- <https://wezfurlong.org/wezterm/>
- <https://ohmyz.sh/>
