source ~/.dotfiles/shell/colors.sh

# A spinner. To say that a command is still loading...
#
# Usage: `slow_command & spinner`
spinner() {
  local pid=$!
  local i=0
  local spin="/-\|"
  local n=${#spin}

  printf "  "
  while kill -0 $pid 2>/dev/null; do
    printf "\b\b%s " "${spin:i++%n:1}"
    sleep 0.1
  done
  printf "${Green}\b\b✓${ColorOff}"
  echo
}

# Asks the user to enter "yes" or "no".
#
# Usage: `ask "Do you wanna proceed?"`
ask() {
  printf "$1 [y/n] "
  read -n 1 choice
  echo

  case $choice in
    y*|Y*) true ;;
    n*|N*) false ;;
    *) ask "$1" ;;
  esac
}

# Asks the user to do something, and they have to press RETURN to continue.
#
# Usage: `confirm "Do something before continuing"`
confirm() {
  printf "$1 [press RETURN to continue] "
  read -s -n 1 key
  echo

  if [ "$key" != "" ]; then
    confirm "$1"
  fi
}

# Check if the given command exists.
#
# Usage: `if command_exists git; then...`
command_exists() {
  command -v "$@" >/dev/null 2>&1
}
