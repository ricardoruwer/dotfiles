# EDITOR
export EDITOR="cursor"
export BUNDLER_EDITOR="$EDITOR"
export GEM_EDITOR="$EDITOR"
export VISUAL="$EDITOR"
export HISTFILE="$HOME/.zsh_history"
export HISTCONTROL="ignoreboth:erasedups" # Erase duplicates in history
export HISTSIZE=10000 # Store 10k history entries
export GPG_TTY=$(tty)

# ASDF
export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --disable-jit --without-javac --without-odbc --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --with-wx-config=$(which wx-config) --enable-darwin-64bit --with-ssl=$(brew --prefix openssl)"
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
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.privy:$PATH"
export PATH="$ASDF_DATA_DIR/shims:$PATH"
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
