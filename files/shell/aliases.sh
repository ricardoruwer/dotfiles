# Dirs
# ====
alias code="cd ~/code"
alias sublconf="cd ~/Library/Application\ Support/Sublime\ Text\ 3"
alias ptec="cd ~/ptec"

# Config
# ======
alias reload=". ~/.zshrc && echo 'ZSH reloaded! :D'"

# Shell
# =====
alias ll="ls -FGlahs"
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"
alias ls="ls -G"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias lip="ipconfig getifaddr en0"
alias key="cat ~/.ssh/id_rsa.pub | pbcopy; echo 'SSH key copied to clipboard!'"
alias hex="openssl rand -hex"
alias fd="find . -type d -name"
alias ff="find . -type f -name"
alias bigclass="find . -name '*.rb' -not -path '*test*' -not -path '*spec*' | xargs wc -l | sort -rn | head"
alias longparams="ack 'def\s.+\((.*,.*,.*,.*)\)' --ignore-dir='spec' --ignore-dir='test'"

# Show/hide hidden files in Finder
# ================================
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Bundler
# =======
alias b="bundle"
alias bi="b install --jobs=2"
alias bu="b update"
alias be="b exec"
alias bo="b open"

# Rails
# =====
alias rc="bin/rails c"
alias rs="bin/rails s"
alias s="bin/spring"
alias sr="bin/rspec"
alias st="bin/teaspoon"
alias rdm="bin/rake db:migrate"
alias rdr="bin/rake db:rollback"
alias rof="bin/rspec --only-failures"

# Others
# ======
alias dotfiles="subl ~/.dotfiles"
alias g="git"
alias gib="gem install bundler"
