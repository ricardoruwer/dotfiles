# Shell
# =====
alias ..="cd .."
alias ...="cd ../.."
alias reload=". ~/.zshrc && echo 'ZSH reloaded!'"
alias grep="grep --color=auto"
alias ls="exa"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias lip="ipconfig getifaddr en0"
alias key="cat ~/.ssh/id_rsa.pub | pbcopy; echo 'SSH key copied to clipboard!'"
alias chunk="curl -s -T - chunk.io | pbcopy; echo 'URL copied to clipboard!'"
alias hex="openssl rand -hex"
alias cat="bat"
alias g="git"
alias ping="prettyping --nolegend"
alias prev="fzf --preview 'bat --color always {}'"
alias tree="exa -T -I '.git|node_modules|bower_components|.DS_Store' --group-directories-first"
alias port="lsof -i"
alias ff="find . -type f -name"
alias fd="find . -type d -name"
alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew upgrade --cask; brew cleanup"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias alert='osascript -e "display notification \"Stuff is done.\" with title \"Back to work!\""; tput bel'

# Finder
# ======
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Bundler
# =======
alias b="bundle"
alias bi="b install --jobs=2"
alias bu="b update"
alias be="b exec"
alias bo="b open"

# Ruby/Rails
# ==========
alias rc="bin/rails c"
alias rs="bin/rails s"
alias sr="bin/rspec"
alias rt="bin/rspec"
alias rdm="bin/rake db:migrate"
alias rdr="bin/rake db:rollback"
alias rof="bin/rspec --only-failures"

# Elixir/Phoenix
# ==============
alias ms="mix phx.server"
alias mc="iex -S mix"
alias mt="mix test"
alias mem="mix ecto.migrate"
alias mer="mix ecto.rollback"

# Brew
# ====
alias bs="brew services"

# Jest
# ====
alias yt="yarn test"
