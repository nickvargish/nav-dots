# .zshrc
#	Nick Vargish 12/07/93

# interactive zsh shells source this
#       o commands that define the interactive environment go here
#    	o PATH settings, aliases, et al belong in .zshenv

# This is a complex set-up script. Many of the more esoteric aspects
# of zsh configuration can be commented out, so it will actually give
# users a basic setup.

if [ -z "$NAV_ZSHENV" ]; then
  . $HOME/.zshenv
fi

if [ ! -d "$HOME/bin/noarch" ]; then
  mkdir $HOME/bin/noarch
  export PATH=$PATH:$HOME/bin/noarch
fi
loadavgs="$HOME/bin/noarch/loadavgs"
if [ ! -f "$loadavgs" ]; then
  cat >"$loadavgs" <<EOF
#!/bin/sh
uptime | awk '{ print \$(NF-2), \$(NF-1), \$(NF) }'
EOF
  chmod +x "$loadavgs"
fi

# some basic zsh options. there are many more in zsh(1).
setopt automenu autolist nobeep listtypes extendedglob
setopt histignoredups rmstarsilent promptsubst
#setopt allexport

# This sets the prompt to <user>@<host>$, unless root, in which
# case the $ is replaced by #.
export PROMPT="%B%n%b@%B%m%b%(#.#.$) "

# display the current working directory on the right of the screen, at prompt
export RPROMPT="[ %~ ]"

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
if [[ -f $HOME/.zcomplete ]]; then
  . $HOME/.zcomplete
fi

# using xfaces, so we don't need bif
if [[ "$TERM" = "xterm" ]]; then
  export MAILCHECK=0
fi

# invoke chpwd so that it's (1) autoloaded and (2) invoked once to set titlebar
# Ask Nick how to set your titlebar in an xterm.
if which chpwd >/dev/null 2>&1 ; then
  chpwd 
fi
