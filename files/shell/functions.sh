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

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
  else
    local arg=-sh;
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@";
  else
    du $arg .[^.]* *;
  fi;
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

# A function to extract correctly any archive based on extension
# USE: extract imazip.zip
#      extract imatar.tar
# from:
# https://github.com/flatiron-school/dotfiles/blob/3fc97f6a48580dd1fde71dde6634029156af2810/bash_profile#L115-L136
function extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1      ;;
      *.tar.gz)   tar xzf $1      ;;
      *.bz2)      bunzip2 $1      ;;
      *.rar)      rar x $1        ;;
      *.gz)       gunzip $1       ;;
      *.tar)      tar xf $1       ;;
      *.tbz2)     tar xjf $1      ;;
      *.tgz)      tar xzf $1      ;;
      *.zip)      unzip $1        ;;
      *.Z)        uncompress $1   ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Convert RAW images to 2560px max-dimension JPEG @ 80 quality to ./output
# check for presence of convert command first:
if [ -x "$(which convert)" ]; then
  function convert-raw-to-jpg() {
    local quality=${1:-80};
    local max_dim=${2:-2650};
    local source_files=${3:-*.NEF};
    echo "Usage: convert-raw-to-jpg [quality=80] [max-dimension-px=2560] [source=*.NEF]";
    echo "Converting all ${source_files} to JPEG (${quality} quality, ${max_dim}px max) to output/...";
    mkdir -p output 2> /dev/null;
    find . -type f -iname "${source_files}" -print0 |       xargs -0 -n 1 -P 8 -I {} convert -verbose -units PixelsPerInch {}       -colorspace sRGB -resize ${max_dim}x${max_dim} -set filename:new '%t-%wx%h'       -density 72 -format JPG -quality ${quality} 'output/%[filename:new].jpg';
    echo 'Done.';
  }
fi;

# Remove merged branches.
function rmb () {
  # This has to be run from master
  git checkout master

  # Update our list of remotes
  git fetch
  git remote prune origin

  # Remove local fully merged branches
  git branch --merged master | grep -v 'master$' | xargs git branch -d

  # Show remote fully merged branches
  echo "The following remote branches are fully merged and will be removed:"
  git branch -r --merged master | sed 's/ *origin\///' | grep -v 'master$'

  # read -p "Continue (y/n)? " <-- for bash
  read "reply?Continue (y/n)?"
  if [[ "$reply" =~ ^[Yy]$ ]]
  then
     # Remove remote fully merged branches
     git branch -r --merged master | sed 's/ *origin\///' | grep -v 'master$' | xargs -I% git push origin :%
     echo "Done!"
  fi
}
