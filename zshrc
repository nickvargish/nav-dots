#!/bin/zsh
#######################
##                   ##
##   Nick's .zshrc   ##
##                   ##
#######################

# version 3.0
#
# last major revision: 2013-06-21

# interactive zsh shells source this
#   o commands that define the interactive environment go here
#   o PATH settings, aliases, et al belong in .zshenv


# some basic zsh options. there are many more in zsh(1).
setopt automenu autolist nobeep listtypes extendedglob
setopt histignoredups rmstarsilent promptsubst
#setopt allexport

[[ -z "$NAV_ZSHENV" ]] && source $HOME/.zshenv

# if this is a terminal worth setting the title in
case "$TERM" in
  xterm*|Eterm|screen)
    add-zsh-hook chpwd chpwd-set-title
    ;;
esac

# This sets the prompt to <user>@<host>$, unless root, in which
# case the $ is replaced by #.
export PROMPT='%B%n%b@%B%m%b%(#.#.$) '

# display the current working directory on the right of the screen, at prompt
export RPROMPT='  %38<…<%~'

# set up git prompt
if [[ (-e ~/.gitprompt) && \
      (-e ~/.zsh/git-prompt/gitprompt.zsh) && \
      (-n "$(whence git)") ]]; then
  source ~/.zsh/git-prompt/gitprompt.zsh
  export ZSH_THEME_GIT_PROMPT_NOCACHE=1
  gitrprompt() {
    __gp="$(git_super_status)"
    print -n "  %38<…<%~${__gp:+ $__gp}"
  }
  export RPROMPT='$(gitrprompt)'
fi

# normally ignore the files with extensions listed here
#export fignore=( \~ \# .bak )

# set editor preference. 
# extra complexity is for chaining fallthrough preferences, say xemacs then
# regular emacs, then emacs -nw.
if [[ -n "$(whence emacs)" ]]; then
  TE="emacs" ; TV="emacs"
fi
export EDITOR=$TE
export VISUAL=$TV
unset TE TV

# set pager preference
if [[ -n "$(whence less)" ]]; then
  export PAGER=less
  # options to control the default behavior of less
  export LESS="-Mia -j3"
else
  export PAGER=more
fi

# load aliases
[[ -f $HOME/.zshalii ]] && source $HOME/.zshalii

# load completion customization
[[ -f $HOME/.zshcomplete ]] && source $HOME/.zshcomplete

cd $PWD
