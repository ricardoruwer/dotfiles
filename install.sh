# Dotfiles vars
export DOTFILES_DIR="${HOME}/.dotfiles"
export DOTFILES_INSTALLER="${DOTFILES_DIR}/installers"
export DOTFILES_FILES_CONFIGS="${DOTFILES_DIR}/configs"
export DOTFILES_THEMES_DIR="${DOTFILES_DIR}/themes"

source ${DOTFILES_INSTALLER}/utils
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

exit 0
