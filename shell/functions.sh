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

# Get the current branch
function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Get the ruby version name using rbenv
function rb-version {
  rbenv version-name 2>/dev/null
}
