# Define the default editor
export BUNDLER_EDITOR="code"
export GEM_EDITOR="code"
export EDITOR="code"
export VISUAL="$EDITOR"

export HISTFILE="$HOME/.zsh_history"
export HISTCONTROL="ignoreboth:erasedups" # Erase duplicates in history
export HISTSIZE=10000 # Store 10k history entries

# TRR
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"
export GOPATH="$HOME/go"

export TRR_DIR="$HOME/Code/trr"
export TRR_BIN_DIR="$HOME/.dotfiles/bin-private"

# DIRENV
export DIRENV_LOG_FORMAT=

# PATH
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.bin-private:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
