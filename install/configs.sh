source ~/.dotfiles/shell/colors.sh
source ~/.dotfiles/shell/functions.sh

for file in ~/.dotfiles/configs/*; do
  if [ -r "$file" ] && [ -f "$file" ]; then
    target="${HOME}/.${file##*/}"
    echo "${Green}Linking ${target}${ColorOff}"
    ln -sf $file $target
  fi
done

# Log in to Google Drive to import private things from there
echo "${Blue}=> Setting up Google Drive${ColorOff}"
while [ ! -d ~/Google\ Drive/My\ Drive ]; do
  confirm "${Yellow}Please open and log in to Google Drive before continuing - You must have your files in ${Green}~/Google Drive/My Drive${ColorOff}"
done

# Set up Itermocil
echo "${Green}Linking ${HOME}/.itermocil${ColorOff}"
ln -sf ~/Google\ Drive/My\ Drive/.itermocil ~/.itermocil

# Import GPG key
echo "${Green}Importing GPG key${ColorOff}"
pushd ~/Google\ Drive/My\ Drive/Dev
gpg --import gpg.key
popd
echo "pinentry-program /usr/local/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf

# Install fonts
echo "${Green}Installing fonts${ColorOff}"
find ~/Google\ Drive/My\ Drive/Dev/Fonts -type f -exec cp {} ~/Library/Fonts \;
