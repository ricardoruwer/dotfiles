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

# Installs Erlang through asdf with the build options kerl needs on macOS.
#
# Usage: `asdf-install-erlang 26.2.2`
asdf-install-erlang() {
  KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --disable-jit --without-javac --without-odbc --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --with-wx-config=$(which wx-config) --enable-darwin-64bit --with-ssl=$(brew --prefix openssl)" \
    asdf install erlang "$@"
}
