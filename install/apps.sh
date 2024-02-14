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
      (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ${HOME}/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo "${Green}Linking ~/.Brewfile${ColorOff}"
    ln -sf ~/.dotfiles/Brewfile ~/.Brewfile

    echo "${Blue}=> Installing Homebrew apps from Brewfile${ColorOff}"
    brew upgrade
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
    fi
    ;;

  zsh-plugins)
    echo "${Blue}=> Installing ZSH plugins${ColorOff}"
    pushd ~/.oh-my-zsh/custom/plugins
    git clone https://github.com/bernardop/iterm-tab-color-oh-my-zsh.git iterm-tab-color
    popd
    ;;

  spaceship)
    echo "${Blue}=> Installing spaceship theme${ColorOff}"
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    ;;

  asdf)
    echo "${Blue}=> Installing asdf plugins${ColorOff}"
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
    asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
    asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
    asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

    echo "${Blue}=> Installing asdf default package versions${ColorOff}"
    asdf plugin update --all
    asdf install
    ;;

  "")
    args=`sh $BASH_SOURCE _args`

    if ask "=> Install all the apps: ${Yellow}${args}${ColorOff}, continue?"; then
      for arg in $args; do
        sh $BASH_SOURCE $arg
      done
    fi
    ;;

  _args)
    echo "macos xcode brew asdf zsh zsh-plugins spaceship fzf npm"
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
