#!/bin/bash

set -e

# Install dependencies
apt install curl zsh

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed, skipping..."
fi
# Symlink dotfiles
echo "Symlinking dotfiles..."

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# List of dotfiles to symlink (add more as needed)
DOTFILES=(".zshrc" ".zshrc.pre-oh-my-zsh")

for file in "${DOTFILES[@]}"; do
    if [ -f "$HOME/$file" ]; then
        echo "Backing up existing $file to $file.backup"
        mv "$HOME/$file" "$HOME/$file.backup"
    fi
    
    if [ -f "$DOTFILES_DIR/$file" ]; then
        ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
        echo "Symlinked $file"
    else
        echo "Warning: $file not found in dotfiles directory"
    fi
done

echo "Setup complete! Restart your terminal or run 'zsh' to start using your new setup."