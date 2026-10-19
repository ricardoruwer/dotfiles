# EDITOR
export EDITOR="cursor"
export BUNDLER_EDITOR="$EDITOR"
export GEM_EDITOR="$EDITOR"
export VISUAL="$EDITOR"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000 # Store 10k history entries
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
