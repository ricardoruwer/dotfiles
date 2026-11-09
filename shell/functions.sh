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

# Shows a status in the subtitle of the iTerm tab: working, waiting, done or
# failed (anything else clears it). It sets the session variable `user.status`,
# which `configs/iterm2/sync_tab_title.py` shows as the subtitle.
#
# Usage: `iterm_status working`
iterm_status() {
  [ "$TERM_PROGRAM" = "iTerm.app" ] || return 0

  local text
  case "$1" in
    working) text="🟠 working" ;;
    waiting) text="🔵 waiting" ;;
    done)    text="🟢 done" ;;
    failed)  text="🔴 failed" ;;
    *)       text="" ;;
  esac

  { printf '\033]1337;SetUserVar=status=%s\a' "$(printf '%s' "$text" | base64 | tr -d '\n')" > /dev/tty; } 2>/dev/null
  return 0
}

# Clears the status. Kept free of subprocesses because it runs before every
# command typed in the shell.
#
# Usage: `iterm_status_clear`
iterm_status_clear() {
  [ "$TERM_PROGRAM" = "iTerm.app" ] || return 0
  { printf '\033]1337;SetUserVar=status=\a' > /dev/tty; } 2>/dev/null
  return 0
}

# Shows done or failed from an exit status.
#
# Usage: `iterm_status_finish $?`
iterm_status_finish() {
  if [ "$1" -eq 0 ]; then
    iterm_status done
  else
    iterm_status failed
  fi
}

# Shows the status of a script in the iTerm subtitle: working while it runs,
# then done or failed when it exits, including on Ctrl+C. Call it once at the
# top of the script. Scripts started by a tracked script leave the status alone.
# The optional argument is a cleanup command that also runs on exit; pass it
# here because this function owns the script's EXIT trap.
#
# Usage: `status_while_running ['rm -f "$TMP"']`
status_while_running() {
  local cleanup=$1

  if [ -n "$ITERM_STATUS_TRACKED" ]; then
    [ -n "$cleanup" ] && trap "$cleanup" EXIT
    return 0
  fi

  export ITERM_STATUS_TRACKED=1
  iterm_status working
  trap "code=\$?; ${cleanup:-:}; iterm_status_finish \$code" EXIT
  trap 'exit 130' INT TERM HUP
}

# Marks the tracked script as waiting for the user. Use it right before a
# prompt, and `status_resume` right after. Does nothing outside a tracked script.
status_waiting() {
  [ -n "$ITERM_STATUS_TRACKED" ] && iterm_status waiting
  return 0
}

status_resume() {
  [ -n "$ITERM_STATUS_TRACKED" ] && iterm_status working
  return 0
}

# Asks the user to enter "yes" or "no".
#
# Usage: `ask "Do you wanna proceed?"`
ask() {
  local result
  if has_gum; then
    status_waiting
    gum confirm --default=false "$(printf '%b' "$1")"
    result=$?
    status_resume
    return $result
  fi

  status_waiting
  printf "$1 [y/n] "
  read -n 1 choice
  status_resume
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
  status_waiting
  printf "$1 [press RETURN to continue] "
  read -s -n 1 key
  status_resume
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

# Opens Chrome with remote debugging on a separate profile. The iTerm tab is
# titled "chrome" and turns blue while it runs.
#
# Usage: `chrome_debug [URL]`
chrome_debug() {
  iterm_tab_color "#3b82f6"
  printf '\033]1;chrome\a\033]2;chrome\a'
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --remote-debugging-port=9222 --user-data-dir="$HOME/chrome-cdp-profile" "$@"
  iterm_tab_color
  printf '\033]1;\a\033]2;\a'
}
