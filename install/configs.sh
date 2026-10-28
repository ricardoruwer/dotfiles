source ~/.dotfiles/shell/colors.sh
source ~/.dotfiles/shell/functions.sh

for file in ~/.dotfiles/configs/*; do
  if [ -r "$file" ] && [ -f "$file" ]; then
    target="${HOME}/.${file##*/}"
    echo "${Green}Linking ${target}${ColorOff}"
    ln -sf $file $target
  fi
done

# Vim Catppuccin theme (Vim 8+ native package)
if [ ! -d ~/.vim/pack/vendor/start/catppuccin ]; then
  echo "${Green}Installing Catppuccin for Vim${ColorOff}"
  git clone --depth 1 https://github.com/catppuccin/vim.git ~/.vim/pack/vendor/start/catppuccin
fi

# Vim Elixir syntax
if [ ! -d ~/.vim/pack/vendor/start/vim-elixir ]; then
  echo "${Green}Installing vim-elixir${ColorOff}"
  git clone --depth 1 https://github.com/elixir-editors/vim-elixir.git ~/.vim/pack/vendor/start/vim-elixir
fi

# iTerm2 AutoLaunch script
echo "${Green}Linking iTerm2 AutoLaunch script${ColorOff}"
mkdir -p "$HOME/Library/Application Support/iTerm2/Scripts/AutoLaunch"
ln -sf ~/.dotfiles/configs/iterm2/sync_tab_title.py "$HOME/Library/Application Support/iTerm2/Scripts/AutoLaunch/sync_tab_title.py"

# Log in to Google Drive to import private things from there
echo "${Blue}=> Setting up Google Drive${ColorOff}"
while [ ! -d ~/Google\ Drive/My\ Drive ]; do
  confirm "${Yellow}Please open and log in to Google Drive before continuing - You must have your files in ${Green}~/Google Drive/My Drive${ColorOff}"
done

# Make iTerm2 load (and keep saving) its preferences from the Google Drive folder
echo "${Green}Setting iTerm2 preferences folder${ColorOff}"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/Google Drive/My Drive/iTerm"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Set up Itermocil
echo "${Green}Linking ${HOME}/.itermocil${ColorOff}"
ln -sf ~/Google\ Drive/My\ Drive/.itermocil ~/.itermocil

# Import GPG key
echo "${Green}Importing GPG key${ColorOff}"
pushd ~/Google\ Drive/My\ Drive/Dev
gpg --import gpg.key
popd
echo "pinentry-program `which pinentry-mac`" > ~/.gnupg/gpg-agent.conf

# Install fonts
echo "${Green}Installing fonts${ColorOff}"
find ~/Google\ Drive/My\ Drive/Dev/Fonts -type f -exec cp {} ~/Library/Fonts \;
