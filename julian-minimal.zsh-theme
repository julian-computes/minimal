# vim:et sts=2 sw=2 ft=zsh
#
# Modified minimal theme for zsh based on zimfw's minimal which is based on subnixr's minimal
# https://github.com/subnixr/minimal
# https://github.com/zimfw/minimal
#
# Changes:
# - Working directory appears on the left of the prompt
# - Git information appears before the lambda prompt
# - Enhanced git information (ahead/behind, stash, file status)
#
# Requires the `prompt-pwd` and `git-info` zmodules to be included in the .zimrc file.

# Global settings
if (( ! ${+MNML_OK_COLOR} )) typeset -g MNML_OK_COLOR=green
if (( ! ${+MNML_ERR_COLOR} )) typeset -g MNML_ERR_COLOR=red
if (( ! ${+MNML_BGJOB_MODE} )) typeset -g MNML_BGJOB_MODE=4
if (( ! ${+MNML_USER_CHAR} )) typeset -g MNML_USER_CHAR=λ
if (( ! ${+MNML_INSERT_CHAR} )) typeset -g MNML_INSERT_CHAR=›
if (( ! ${+MNML_NORMAL_CHAR} )) typeset -g MNML_NORMAL_CHAR=·
# New settings for git info customization
if (( ! ${+MNML_GIT_COLOR} )) typeset -g MNML_GIT_COLOR=244
if (( ! ${+MNML_PWD_COLOR} )) typeset -g MNML_PWD_COLOR=244

# Components
_prompt_mnml_keymap() {
  case ${KEYMAP} in
    vicmd) print -n -- ${MNML_NORMAL_CHAR} ;;
    *) print -n -- ${MNML_INSERT_CHAR} ;;
  esac
}

zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select

# Setup
typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1

setopt nopromptbang prompt{cr,percent,sp,subst}

zstyle ':zim:prompt-pwd:tail' length 2
zstyle ':zim:prompt-pwd:separator' format '%f/%F{244}'

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  # Enhanced git-info configuration with more details
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'
  zstyle ':zim:git-info:action' format ' [%s]'
  zstyle ':zim:git-info:ahead' format ' ↑%A'
  zstyle ':zim:git-info:behind' format ' ↓%B'
  zstyle ':zim:git-info:diverged' format ' ⇕'
  zstyle ':zim:git-info:stashed' format ' *%S'
  zstyle ':zim:git-info:untracked' format ' ?%u'
  zstyle ':zim:git-info:indexed' format ' +%i'
  zstyle ':zim:git-info:unindexed' format ' !%I'
  zstyle ':zim:git-info:clean' format '%F{${MNML_OK_COLOR}}'
  zstyle ':zim:git-info:dirty' format '%F{${MNML_ERR_COLOR}}'
  
  # Compose the git info string with all components
  zstyle ':zim:git-info:keys' format \
      'prompt' '%F{${MNML_GIT_COLOR}} %C%D%b%c%s%V%A%B%S%u%i%I%f'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

# Modified prompts: working directory and git info on left, nothing on right
PS1=$'%F{${MNML_PWD_COLOR}}$(prompt-pwd)%f${(e)git_info[prompt]} ${SSH_TTY:+"%m "}${VIRTUAL_ENV:+"${VIRTUAL_ENV:t} "}%(1j.%{\E[${MNML_BGJOB_MODE}m%}.)%F{%(?.${MNML_OK_COLOR}.${MNML_ERR_COLOR})}%(!.#.${MNML_USER_CHAR})%f%{\E[0m%} $(_prompt_mnml_keymap) '
RPS1=''
