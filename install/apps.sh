source ~/.dotfiles/shell/colors.sh
source ~/.dotfiles/shell/functions.sh

case "$1" in
  macos)
    echo "${Blue}=> Updating MacOS${ColorOff}"
    if ask "Would you like to install any remaining software updates?"; then
      sudo softwareupdate --install --all
    fi
    ;;

  xcode)
    echo "${Blue}=> Installing Xcode Command Line tools${ColorOff}"
    sudo xcode-select --install &>/dev/null
    sudo xcodebuild -license accept &>/dev/null
    ;;

  homebrew|brew)
    echo "${Blue}=> Installing Homebrew${ColorOff}"
    if command_exists brew; then
      echo "${Green}Homebrew already installed${ColorOff}"
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "${Green}Linking ~/.Brewfile${ColorOff}"
    ln -sf ~/.dotfiles/Brewfile ~/.Brewfile

    echo "${Blue}=> Installing Homebrew apps from Brewfile${ColorOff}"
    confirm "${Yellow}Please log in to Mac App Store manually before continuing${ColorOff}"
    brew bundle --global
    brew cleanup
    ;;

  fzf)
    echo "${Blue}=> Installing fzf key bindings and completion${ColorOff}"
    $(brew --prefix)/opt/fzf/install
    ;;

  npm)
    echo "${Blue}=> Installing global NPM packages${ColorOff}"
    cat ~/.dotfiles/npm.txt | xargs npm i -g
    ;;

  zsh)
    echo "${Blue}=> Installing Oh my ZSH${ColorOff}"
    if [ -d "$ZSH" ]; then
      echo "${Green}Oh my ZSH already installed${ColorOff}"
    else
      sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

      echo "${Green}Installing zInit for Oh my ZSH${ColorOff}"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    fi
    ;;

  asdf)
    echo "${Blue}=> Installing asdf plugins${ColorOff}"
    asdf plugin-add elixir
    asdf plugin-add erlang
    asdf plugin-add golang
    asdf plugin-add ruby
    asdf plugin-add nodejs

    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

    echo "${Blue}=> Installing asdf default package versions${ColorOff}"
    asdf install
    ;;

  "")
    args=`sh $BASH_SOURCE _args`

    if ask "=> Install all the apps: ${Yellow}${args}${ColorOff}, continue?"; then
      for arg in $args; do
        sh $BASH_SOURCE $arg
      done
    else
      echo
      sh $BASH_SOURCE --help
    fi
    ;;

  _args)
    echo "macos xcode brew zsh fzf npm asdf"
    ;;

  help|-h|--help)
    echo "Usage: dotfiles apps <arg>"
    echo
    echo "* Available arguments:"
    for arg in `sh $BASH_SOURCE _args`; do
      printf "${UYellow}${arg}${ColorOff} "
    done
    echo
    ;;

  *)
    echo "Unknown arg \`${1}\`. Known are: $(sh $BASH_SOURCE _args)"
    exit 1
    ;;
esac
