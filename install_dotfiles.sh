#!/bin/bash

# Set the path of the dotfiles repo to the current working directory
DOTFILES_DIR="$(pwd)"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to create the symlink for the dotfile within the repo
create_symlink() {
    local source_file="$1"
    local target_file="$2"
    local target_dir=$(dirname "$target_file")

    # Create the target directory if it doesn't exist
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
        echo -e "${BLUE}Created directory:${NC} $target_dir"
    fi

    # Check if the target file already exists
    if [ -e "$target_file" ]; then
        # If it's already a symlink to our dotfile, skip it
        if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
            echo -e "${YELLOW}Symlink already exists:${NC} $target_file"
            return
        fi

        # Backup the existing file
        local backup_file="${target_file}.backup.$(date +%Y%m%d%H%M%S)"
        mv "$target_file" "$backup_file"
        echo -e "${YELLOW}Backed up existing file:${NC} $backup_file"
    fi

    # Create the symlink
    ln -s "$source_file" "$target_file"
    echo -e "${GREEN}Created symlink:${NC} $target_file -> $source_file"
}

# Function to install a specific dotfile
install_dotfile() {
    local file="$1"
    local source_file="$DOTFILES_DIR/$file"
    local target_file="$HOME/$file"

    if [ -f "$source_file" ]; then
        create_symlink "$source_file" "$target_file"
    else
        echo -e "${RED}Source file $source_file does not exist. Skipping.${NC}"
    fi
}

# Main installation
echo -e "${BLUE}Installing dotfiles...${NC}"

# List of dotfiles to install
dotfiles=(
    ".zshrc"
    ".config/alacritty/alacritty.toml"
    ".config/regolith3/Xresources"
)

# Install each dotfile
for file in "${dotfiles[@]}"; do
    install_dotfile "$file"
done

echo -e "${GREEN}Dotfiles installation complete!${NC}"
