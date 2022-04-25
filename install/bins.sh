source ~/.dotfiles/shell/colors.sh

echo "${Green}Linking ~/.bin${ColorOff}"
ln -sfn ~/.dotfiles/bin ~/.bin

echo "${Green}Linking ~/.bin-private${ColorOff}"
while [ ! -d ~/Google\ Drive/My\ Drive ]; do
  confirm "${Yellow}Please open and log in to Google Drive before continuing${ColorOff}"
done
ln -sfn ~/Google\ Drive/My\ Drive/bin ~/.dotfiles/bin-private
ln -sfn ~/.dotfiles/bin-private ~/.bin-private
