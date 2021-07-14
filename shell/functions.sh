source ~/.dotfiles/shell/colors.sh

# Some default functions
function onload_function() {
  title "%c"

  if [ -d .git ]; then
    branch=$(git symbolic-ref --short HEAD)
  else
    unset branch
  fi;
}

# A spinner. Usage: `slow_command & spinner`
function spinner() {
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

function ask() {
  printf "$1 [y/n] "
  read -n 1 choice
  echo

  case $choice in
    y*|Y*) true ;;
    n*|N*) false ;;
    *) ask "$1" ;;
  esac
}

function confirm() {
  printf "$1 [press RETURN to continue] "
  read -s -n 1 key
  echo

  if [ "$key" != "" ]; then
    confirm "$1"
  fi
}

function command_exists() {
  command -v "$@" >/dev/null 2>&1
}

function function_exists() {
  declare -f "$1" > /dev/null
}
