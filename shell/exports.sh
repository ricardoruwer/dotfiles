# Sublime as default editor.
export BUNDLER_EDITOR="subl"
export GEM_EDITOR="subl"
export EDITOR="subl -w"
export VISUAL="$EDITOR"

export HISTFILE="$HOME/.zsh_history"
export HISTCONTROL="ignoreboth:erasedups" # Erase duplicates in history
export HISTSIZE=10000 # Store 10k history entries

export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"

# PATH
export PATH="$HOME/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="./bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi
