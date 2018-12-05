# Dotfiles vars
export DOTFILES="${HOME}/.dotfiles"
export DOTFILES_INSTALLER="${DOTFILES}/installers"
export DOTFILES_FILES="${DOTFILES}/files"
export DOTFILES_FILES_CONFIGS="${DOTFILES}/files/configs"
export DOTFILES_THEMES_DIR="${DOTFILES}/files/themes"

source ${DOTFILES_INSTALLER}/utils
source ${DOTFILES_INSTALLER}/variables
clear

ask_for_sudo

print_in_purple '\nOS X Config Dotfiles\n'

# Run installers
${DOTFILES_INSTALLER}/osx_update
${DOTFILES_INSTALLER}/osx_customization

${DOTFILES_INSTALLER}/brew
${DOTFILES_INSTALLER}/npm
${DOTFILES_INSTALLER}/git
${DOTFILES_INSTALLER}/shell
${DOTFILES_INSTALLER}/ruby

# Install default theme.
ln -sf ${DOTFILES_THEMES_DIR}/materialshell.zsh-theme ~/.oh-my-zsh/themes/materialshell.zsh-theme

exit 0
