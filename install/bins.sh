source ~/.dotfiles/shell/colors.sh
source ~/.dotfiles/shell/functions.sh

echo "${Green}Linking ~/.bin${ColorOff}"
ln -sfn ~/.dotfiles/bin ~/.bin

echo "${Green}Linking ~/.privy${ColorOff}"
mkdir -p ~/.dotfiles/privy
confirm "${Yellow}Add your private bins into the ${Blue}~/.dotfiles/privy ${Yellow}folder${ColorOff}"
ln -sfn ~/.dotfiles/privy ~/.privy
