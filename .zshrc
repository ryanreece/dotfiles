# Display a welcome message 
echo ".zshrc is a symlink ;)"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Fix AnyConnect SAML prompt
export WEBKIT_DISABLE_DMABUF_RENDERER=1

# Source .bash_functions
if [ -f $HOME/.bash_functions ]; then
    source $HOME/.bash_functions
fi

# Make vim command open Neovim
alias n="nvim"

# Load Node Version Manager [nvm](https://github.com/nvm-sh/nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load rbenv
eval "$(~/.rbenv/bin/rbenv init - --no-rehash zsh)"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add gems to path
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# Add go to path
export PATH=$PATH:/usr/local/go/bin
export GOPATH="$(go env GOPATH)"
export PATH="$PATH:$GOPATH/bin"

# Set GTK scaling for high res displays (Regolith v3.4)
export GDK_SCALE=1
export GDK_DPI_SCALE=1.25
