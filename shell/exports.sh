# EDITOR
export EDITOR="code"
export BUNDLER_EDITOR="$EDITOR"
export GEM_EDITOR="$EDITOR"
export VISUAL="$EDITOR"
export HISTFILE="$HOME/.zsh_history"
export HISTCONTROL="ignoreboth:erasedups" # Erase duplicates in history
export HISTSIZE=10000 # Store 10k history entries
export GPG_TTY=$(tty)

# ASDF
export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl@1.1)"
export ASDF_GOLANG_MOD_VERSION_ENABLED=true

# WORK
export RUBY_CONFIGURE_OPTS="--with-jemalloc"
export GOPATH="$HOME/go"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export RUBYOPT='-W0'
export TRR_DIR="$HOME/Code/trr"

# DIRENV
export DIRENV_LOG_FORMAT=

# PERSONAL
export PRIVY_DIR="$HOME/.dotfiles/privy"

# PATH
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.privy:$PATH"
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
