source ~/.dotfiles/shell/colors.sh

echo "${Green}Linking ~/.bin${ColorOff}"
ln -sfn ~/.dotfiles/bin ~/.bin

echo "${Green}Linking ~/.bin-private${ColorOff}"
mkdir -p ~/.dotfiles/bin-private
confirm "${Yellow}Add your private bins into the ${Blue}~/.dotfiles/bin-private ${Yellow}folder${ColorOff}"
ln -sfn ~/.dotfiles/bin-private ~/.bin-private
