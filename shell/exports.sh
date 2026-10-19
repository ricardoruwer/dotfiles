# EDITOR
export EDITOR="cursor --wait"
export BUNDLER_EDITOR="cursor"
export GEM_EDITOR="cursor"
export VISUAL="$EDITOR"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000 # Keep 100k history entries in memory
export SAVEHIST=100000 # ...and in the history file
export GPG_TTY=$TTY

# ASDF
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export ASDF_DATA_DIR=${HOME}/.asdf

# WORK
# export RUBY_CONFIGURE_OPTS="--with-jemalloc"
# export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export RUBYOPT='-W0'
export GOPATH="$HOME/go"
export TRR_DIR="$HOME/Code/trr"

# STARSHIP
export STARSHIP_CONFIG="$HOME/.starship.toml"

# FZF
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# DIRENV
export DIRENV_LOG_FORMAT=

# PERSONAL
export PRIVY_DIR="$HOME/.dotfiles/privy"

# PATH
export PATH="$PATH:/usr/local/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.privy:$PATH"
export PATH="$ASDF_DATA_DIR/shims:$PATH"
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# Keep PATH entries unique (reassign so existing duplicates are dropped)
typeset -U path
path=($path)
