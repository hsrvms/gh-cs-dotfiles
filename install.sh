#!/bin/bash

echo "Starting Codespaces Dotfiles Installation..."

# 1. Ensure local bin exists for custom installations
mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

# 2. Update and install standard package dependencies
sudo apt-get update
sudo apt-get install -y build-essential ripgrep fd-find luarocks nodejs npm python3-venv

# Ubuntu names the 'fd' command 'fdfind'. We need to link it so LazyVim can find it.
ln -sf $(which fdfind) ~/.local/bin/fd

# 3. Install Tree-sitter CLI globally via npm
sudo npm install -g tree-sitter-cli neovim

# 4. Install Lazygit (Optional, but highly recommended by LazyVim)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit ~/.local/bin
rm lazygit.tar.gz lazygit

# 5. Install the latest Neovim (Nightly >= 0.11)
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
mv nvim-linux-x86_64 ~/.local/nvim
ln -sf ~/.local/nvim/bin/nvim ~/.local/bin/nvim
rm nvim-linux-x86_64.tar.gz

# 6. Symlink the Neovim configuration to the correct spot
mkdir -p ~/.config
# This points ~/.config/nvim to the nvim folder inside your dotfiles repo
ln -sf $(pwd)/nvim ~/.config/nvim

# Ensure ~/.local/bin is permanently in the PATH for interactive shells
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
fi

echo "Installation complete! Enjoy Neovim."
