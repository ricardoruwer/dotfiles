source ~/.dotfiles/shell/colors.sh

# Link Bin folder
#################
echo "${Blue}=> Linking bin files into home directory${ColorOff}"

echo "${Green}Linking ~/.bin${ColorOff}"
ln -sf ${HOME}/.dotfiles/bin ${HOME}/.bin

# Link Private Bin folder
#########################
while [ ! -d ~/Google\ Drive ]; do
  confirm "Please open and log in to Backup and Sync from Google before continuing"
done

echo "${Green}Linking ~/.bin-private${ColorOff}"
ln -sf ${HOME}/Google\ Drive/bin ${HOME}/.dotfiles/bin-private
ln -sf ${HOME}/.dotfiles/bin-private ${HOME}/.bin-private
