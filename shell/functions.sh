# Open a project in my own GitHub
function ghopen() {
  open "https://github.com/ricardoruwer/${1}";
}

# Get the process on a given port
function port() {
  lsof -i ":${1:-80}"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  python -m SimpleHTTPServer "$port"
}

# Create a directory and cd to it
function mkcd {
  mkdir -p "$1" && cd "$1"
}
