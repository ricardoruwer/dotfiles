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

function question() {
  printf "%b%s [y/n] %b" "$2" "$1" "$ColorOff"
  read -n 1 choice
  echo

  case $choice in
    y*|Y*) true ;;
    n*|N*) false ;;
    *) question "$1" "$2" ;;
  esac
}

function confirm() {
  printf "%b%s [press RETURN to continue] %b" "$2" "$1" "$ColorOff"
  read -s -n 1 key
  echo

  if [ "$key" != "" ]; then
    confirm "$1" "$2"
  fi
}

function command_exists() {
  command -v "$@" >/dev/null 2>&1
}
