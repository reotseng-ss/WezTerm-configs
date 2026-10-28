#!/usr/bin/env bash
# WSL-side setup for this config. Run inside WSL.
set -euo pipefail
dir=$(cd "$(dirname "$0")" && pwd)
v=5.3 # nnn version

sudo apt-get update
sudo apt-get install -y zsh curl imagemagick tree

# oh my zsh (also makes zsh the login shell)
[ -d ~/.oh-my-zsh ] || RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# nnn + plugins (apt's nnn is too old)
mkdir -p ~/.local/bin ~/.config/nnn/plugins
tmp=$(mktemp -d)
curl -fsSL "https://github.com/jarun/nnn/releases/download/v$v/nnn-static-$v.x86_64.tar.gz" | tar xz -C "$tmp"
install -m755 "$tmp/nnn-static" ~/.local/bin/nnn
curl -fsSL "https://github.com/jarun/nnn/releases/download/v$v/nnn-v$v.tar.gz" | tar xz -C "$tmp"
cp -r "$tmp/nnn-$v/plugins/." ~/.config/nnn/plugins/
rm -rf "$tmp"

# helper scripts
ln -sf "$dir/wezterm" ~/.local/bin/wezterm
ln -sf "$dir/nnn-imgcat" ~/.local/bin/nnn-imgcat
ln -sf "$dir/wsl-open" ~/.local/bin/wsl-open

grep -q NNN_PLUG ~/.zshrc || cat >> ~/.zshrc <<'EOF'

# nnn
export PATH="$HOME/.local/bin:$PATH"
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG="p:preview-tui"
export NNN_OPENER=wsl-open  # open files with Windows default apps
export NNN_PREVIEWIMGPROG=nnn-imgcat
export LS_COLORS="${LS_COLORS}:ow=1;34:tw=1;34:"
alias nnn="nnn -P p"
EOF

echo "Done. Restart WezTerm."
