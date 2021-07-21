_dotfiles() {
  completions() {
    case "$1" in
      dotfiles) sh ~/.dotfiles/dotfiles _cmds ;;
      apps) sh ~/.dotfiles/install/apps.sh _args ;;
    esac
  }

  previous_word="${COMP_WORDS[COMP_CWORD-1]}"
  completions=`completions $previous_word`

  COMPREPLY=($(compgen -W "${completions}"))

  return 0
}

complete -F _dotfiles dotfiles
