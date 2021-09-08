source ~/.dotfiles/shell/colors.sh
source ~/.dotfiles/shell/functions.sh

for file in ~/.dotfiles/configs/*; do
  if [ -r "$file" ] && [ -f "$file" ]; then
    target="${HOME}/.${file##*/}"

    echo "${Green}Linking ${target}${ColorOff}"
    ln -sf $file $target
  fi
done

# Itermocil is not on /configs because it has some private things
echo "${Blue}=> Configuring itermocil${ColorOff}"
while [ ! -d /Volumes/GoogleDrive/My\ Drive ]; do
  confirm "${Yellow}Please open and log in to Google Drive before continuing${ColorOff}"
done
echo "${Green}Linking ${HOME}/.itermocil${ColorOff}"
ln -sf /Volumes/GoogleDrive/My\ Drive/.itermocil ~/.itermocil
