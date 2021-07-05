source ~/.dotfiles/shell/colors.sh
source ~/.dotfiles/shell/functions.sh

# Link Config files
###################
echo "${Blue}=> Linking config files into home directory${ColorOff}"

for file in ~/.dotfiles/configs/*; do
  if [ -r "$file" ] && [ -f "$file" ]; then
    target="${HOME}/.${file##*/}"

    echo "${Green}Linking ${target}${ColorOff}"
    ln -sf $file $target
  fi
done
unset file target;

# Link Itermocil
################
echo "${Blue}=> Configuring itermocil${ColorOff}"

while [ ! -d ~/Google\ Drive ]; do
  confirm "Please open and log in to Backup and Sync from Google before continuing"
done

ln -sf ${HOME}/Google\ Drive/.itermocil ${HOME}/.itermocil
