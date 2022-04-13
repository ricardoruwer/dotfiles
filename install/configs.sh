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
while [ ! -d /Volumes/GoogleDrive/My\ Drive ]; do
  confirm "${Yellow}Please open and log in to Google Drive before continuing${ColorOff}"
done

# Set up Itermocil
echo "${Green}Linking ${HOME}/.itermocil${ColorOff}"
ln -sf /Volumes/GoogleDrive/My\ Drive/.itermocil ~/.itermocil

# Import GPG key
echo "${Green}Importing GPG key${ColorOff}"
pushd /Volumes/GoogleDrive/My\ Drive/Dev
gpg --import gpg.key
popd
