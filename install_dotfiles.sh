#!/bin/bash

# Set the path of the dotfiles repo to the current working directory
DOTFILES_DIR="$(pwd)"

# Function to create the symlink for the dotfile within the repo
create_symlink() {
    local source_file="$1"
    local target_file="$2"
    local target_dir=$(dirname "$target_file")

    # Create the target directory if it doesn't exist
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
        echo "Created directory: $target_dir"
    fi

    # Check if the target file already exists
    if [ -e "$target_file" ]; then
        # If it's already a symlink to our dotfile, skip it
        if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
            echo "Symlink already exists: $target_file"
            return
        fi

        # Backup the existing file
        mv "$target_file" "${target_file}.backup.$(date +%Y%m%d%H%M%S)"
        echo "Backed up existing file: ${target_file}.backup.$(date +%Y%m%d%H%M%S)"
    fi

    # Create the symlink
    ln -s "$source_file" "$target_file"
    echo "Created symlink: $target_file -> $source_file"
}

# Function to install a specific dotfile
install_dotfile() {
    local file="$1"
    local source_file="$DOTFILES_DIR/$file"
    local target_file="$HOME/$file"

    if [ -f "$source_file" ]; then
        create_symlink "$source_file" "$target_file"
    else
        echo "Source file $source_file does not exist. Skipping."
    fi
}

# Main installation
echo "Installing dotfiles..."

# List of dotfiles to install
dotfiles=(
    ".zshrc"
    ".config/alacritty/alacritty.toml"
)

# Install each dotfile
for file in "${dotfiles[@]}"; do
    install_dotfile "$file"
done

echo "Dotfiles installation complete!"
