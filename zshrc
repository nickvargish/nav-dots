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
#       o commands that define the interactive environment go here
#    	o PATH settings, aliases, et al belong in .zshenv


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
if [[ (-e ~/.zsh/git-prompt/gitprompt.zsh) && (-n "$(whence git)") ]]; then
  source ~/.zsh/git-prompt/gitprompt.zsh
  export ZSH_THEME_GIT_PROMPT_NOCACHE=1
  gitrprompt() {
    __gp="$(git_super_status)"
    print -n "  %38<…<%~${__gp:+ $__gp}"
    #if [[ -n "$__gp" ]]; then
    #  print -n "  %38<…<%~ $__gp"
    #else
    #  print -n "  %38<…<%~"
    #fi
  }
  export RPROMPT='$(gitrprompt)'
fi

# normally ignore the files with extensions listed here
#export fignore=( \~ \# .bak )

# set editor preference. 
# extra complexity is for chaining fallthrough preferences, say xemacs then
# regular emacs, then emacs -nw.
if which emacs >/dev/null 2>&1 ; then
  TE="emacs" ; TV="emacs"
fi
export EDITOR=$TE
export VISUAL=$TV
unset TE TV

# set pager preference
if which less >/dev/null 2>&1 ; then
  export PAGER=less
  # options to control the default behavior of less
  export LESS="-Mia -j3"
else
  export PAGER=more
fi

# load aliases
if [[ -f $HOME/.zshalii ]]; then
  . $HOME/.zshalii
fi

# load completion customization
if [[ -f $HOME/.zshcomplete ]]; then
  . $HOME/.zshcomplete
fi

cd `pwd`
