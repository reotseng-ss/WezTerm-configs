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
EOF

grep -q '^nnn()' ~/.zshrc || cat >> ~/.zshrc <<'EOF'

# nnn that cds to its last dir on quit (q)
export NNN_TMPFILE="$HOME/.config/nnn/.lastd"
unalias nnn 2>/dev/null
nnn() {
  command nnn "$@"
  [ -f "$NNN_TMPFILE" ] && { . "$NNN_TMPFILE"; rm -f -- "$NNN_TMPFILE"; }
}
EOF

# don't exit the shell (and close the tab) on Ctrl+D
grep -q _ctrl_d ~/.zshrc || cat >> ~/.zshrc <<'EOF'

# Ctrl+D: delete char as usual, but do nothing (no exit, no message) on an empty line
# (IGNORE_EOF is required; with a function widget bound to ^D it doesn't print its warning)
_ctrl_d() { [[ -n $BUFFER ]] && zle delete-char-or-list }
setopt IGNORE_EOF
zle -N _ctrl_d
bindkey '^D' _ctrl_d
EOF
grep -q ignoreeof ~/.bashrc || printf '\nset -o ignoreeof\n' >> ~/.bashrc

echo "Done. Restart WezTerm."
