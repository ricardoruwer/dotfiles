function _dotfiles() {
  local _current="${COMP_WORDS[COMP_CWORD]}"
  local _previous="${COMP_WORDS[COMP_CWORD-1]}"

  COMPREPLY=()

  if [[ "$_previous" = "dotfiles" ]]; then
    local _dotfiles_commands=`~/.dotfiles/dotfiles _cmds`
    COMPREPLY=($(compgen -W "${_dotfiles_commands}" -- ${_current}))
  else
    if [ "$_previous" == "apps" ]; then
      local _dotfiles_args="$(sh ~/.dotfiles/install/apps.sh _args)"
      COMPREPLY=($(compgen -W "${_dotfiles_args}" -- ${_current}))
    fi
  fi

  return 0
}

complete -F _dotfiles dotfiles
