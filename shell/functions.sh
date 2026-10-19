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
  wait $pid
  local status=$?

  if [ $status -eq 0 ]; then
    printf "${Green}\b\b✓${ColorOff}"
  else
    printf "${Red}\b\b✗${ColorOff}"
  fi
  echo

  return $status
}

# Asks the user to enter "yes" or "no".
#
# Usage: `ask "Do you wanna proceed?"`
ask() {
  if has_gum; then
    gum confirm --default=false "$(printf '%b' "$1")"
    return
  fi

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

# Check if gum can be used: it is installed and we are talking to a terminal.
# The install scripts run before gum exists, so every caller needs a fallback.
#
# Usage: `if has_gum; then...`
has_gum() {
  command_exists gum && [ -t 0 ] && [ -t 2 ]
}

# Runs a command quietly behind a spinner, then prints the label with a ✓ or ✗.
# Returns the exit status of the command.
#
# Usage: `run_with_spinner "Installing gems" bundle install`
run_with_spinner() {
  local label=$1 status
  shift

  if has_gum; then
    gum spin --title "$label" -- "$@" > /dev/null 2>&1
    status=$?
    printf "${Yellow}%s${ColorOff} " "$label"
    if [ $status -eq 0 ]; then
      printf "${Green}✓${ColorOff}\n"
    else
      printf "${Red}✗${ColorOff}\n"
    fi
  else
    printf "${Yellow}%s${ColorOff} " "$label"
    "$@" > /dev/null 2>&1 & spinner
    status=$?
  fi

  return $status
}

# Prints a section title.
#
# Usage: `heading "Upgrading things..."`
heading() {
  if has_gum; then
    gum style --bold --foreground 3 "▸ $1"
  else
    printf "${Yellow}%s${ColorOff}\n" "$1"
  fi
}
