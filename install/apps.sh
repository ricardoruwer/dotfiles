source ~/.dotfiles/shell/colors.sh
source ~/.dotfiles/shell/functions.sh

# Install Command Line Tools
############################
echo "${Blue}=> Updating MacOS and installing Xcode Command Line tools${ColorOff}"

if question "Would you like to install any remaining software updates?"; then
  sudo softwareupdate --install --all
fi

sudo xcode-select --install &>/dev/null
sudo xcodebuild -license accept &>/dev/null

# Install Homebrew & apps
#########################
echo "${Blue}=> Installing Homebrew${ColorOff}"
if command_exists brew; then
  echo "${Green}Homebrew already installed${ColorOff}"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "${Green}Linking ~/.Brewfile${ColorOff}"
  ln -sf ${HOME}/.dotfiles/Brewfile ${HOME}/.Brewfile
fi

echo "${Blue}=> Installing Homebrew apps from Brewfile${ColorOff}"
confirm "Please log in to Mac App Store manually before continuing"
brew bundle --global
brew cleanup

# Configure/install formulaes
#############################
echo "${Blue}=> Installing fzf key bindings and completion${ColorOff}"
$(brew --prefix)/opt/fzf/install

# Install NPM packages
######################
echo "${Blue}=> Installing global NPM packages${ColorOff}"
cat npm.txt | xargs npm i -g
