# Dotfiles

My personal collection of dotfiles. Use at your own risk ;)

## File Structure

The structure of this repository mirrors the structure of the files in your home directory.

- `.zshrc` is located at the root of the repo, just as it would be at the root of your home directory.
- Configuration files that typically live in `~/.config` are placed in the `.config` folder in this repo.

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/ryanreece/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:
   ```
   ./install_dotfiles.sh
   ```

> The installation script will create backups of existing files before creating symlinks. 

## How It Works

The installation script creates symlinks from your home directory to the files in this repository. This approach has several benefits:

1. **Central Management**: You can manage all your configuration files in one place (this repo).
2. **Version Control**: Your configurations are version-controlled, allowing you to track changes and revert if necessary.
3. **Easy Updates**: When you update a file in this repo, the change is immediately reflected in your system because of the symlinks.
4. **Portability**: It's easy to set up your preferred environment on a new machine by cloning this repo and running the install script.

## Customization

To add new dotfiles to be managed by this repo:

1. Add the file to this repository, maintaining the correct directory structure.
2. Edit the `install_dotfiles.sh` script and add the file path to the `dotfiles` array.

