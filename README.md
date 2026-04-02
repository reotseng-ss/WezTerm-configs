# WezTerm Configs

Personal WezTerm configuration for Windows with WSL as the primary shell environment.

## Overview

- Default shell domain on Windows: `wsl:ubuntu-zsh`
- Fallback WSL shell domain: `wsl:ubuntu-bash`
- Local launch menu entries: PowerShell, Command Prompt, MSYS2, WSL Bash, Git Bash
- Custom key bindings for tabs, panes, resizing, background selection, and quick Neovim launch

## Requirements

### Windows

- [WezTerm](https://wezfurlong.org/wezterm/installation.html)
- A Nerd Font if you want icons to render correctly
- WSL with an Ubuntu distribution installed
- Git for Windows if you want the `Git Bash` launch menu entry

### WSL Packages

Inside Ubuntu WSL, install the tools this config expects or benefits from:

```bash
sudo apt update
sudo apt install -y zsh git curl neovim nnn
```

Optional but commonly useful:

```bash
sudo apt install -y unzip build-essential
```

## Oh My Zsh Setup

Install Oh My Zsh inside WSL:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

If you want `zsh` to be your default shell in WSL generally, not just inside WezTerm:

```bash
chsh -s "$(which zsh)"
```

## Install This Config

Clone this repository into your WezTerm config directory:

### Windows

```powershell
git clone git@github.com:reotseng-ss/WezTerm-configs.git $HOME\.config\wezterm
```

## Machine-Specific Settings

- [config/domains.lua](./config/domains.lua) for WSL domains and default shell domain
- [config/launch.lua](./config/launch.lua) for local shell launch entries
- [config/fonts.lua](./config/fonts.lua) if your installed font names differ

## Workflow Notes

- `Alt+e` sends `nvim` in the current shell
- `Alt+t` opens a new tab in the default domain
- `Alt+Ctrl+t` opens a new tab in `wsl:ubuntu-bash`
- Right-clicking the new-tab button opens the custom launch/domain selector

## Helpful WSL Tooling

These are not strictly required by WezTerm, but they make the terminal workflow much nicer:

- `nnn` for terminal file browsing
- `neovim` for editing

## Notes

- This config assumes your WSL distribution is named `Ubuntu`
- The default Windows startup domain is currently `wsl:ubuntu-zsh`
- Oh My Zsh requires `zsh`; it is not a separate shell by itself

## References

- <https://wezfurlong.org/wezterm/>
- <https://ohmyz.sh/>
