# Interactive helpers built on fzf. Only loaded by zsh (see configs/zshrc).

# Checks out a branch picked with fzf. A remote branch becomes a local one
# tracking it, instead of a detached HEAD.
#
# Usage: `fbranch`
fbranch() {
  local branch remote
  branch=$(git branch -a --format='%(refname:short)' | sed '/\/HEAD$/d' |
    fzf +m --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%h %ad %s" {} | head -n 20') || return
  for remote in $(git remote); do
    case $branch in
      "$remote"/*) branch=${branch#"$remote"/}; break ;;
    esac
  done
  git checkout "$branch"
}

# Kills the processes picked with fzf (Tab selects several). Sends SIGTERM by
# default; pass a signal number to change it.
#
# Usage: `fkill` or `fkill 9`
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "$pid" | xargs kill -"${1:-15}"
  fi
}

# Search for files in the current directory and open them in the editor.
#
# Usage: `fe`
fe() {
  local file
  file=$(fd --type f --hidden --exclude .git | fzf --preview 'bat --style=numbers --color=always --line-range :50 {}')
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Copy the hash of the selected commit to the clipboard.
#
# Usage: `fhash`
fhash() {
  local commit
  commit=$(git log --color=always --oneline --graph --date=short | fzf --ansi --no-sort --reverse --preview 'git show --color=always {2}' | awk '{print $2}')
  if [ -n "$commit" ]; then
    echo -n "$commit" | pbcopy
    echo "Hash $commit copiado para o clipboard!"
  fi
}

# Change the directory to the selected one using zoxide.
#
# Usage: `fj`
fj() {
  local dir
  dir=$(zoxide query -l | fzf --height 40% --layout=reverse)
  [ -n "$dir" ] && cd "$dir"
}

# Execute a command in the selected container using docker.
#
# Usage: `fdocker`
fdocker() {
  local cid
  cid=$(docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}" | sed 1d | fzf | awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" /bin/sh
}
