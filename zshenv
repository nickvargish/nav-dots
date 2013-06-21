######################
#                    #
#   Nick's .zshenv   #
#                    #
######################

# version 2.0

# note: all zsh shells source this (unless explicitly instructed not to)

# =========
# FUNCTIONS
# =========

export NAV_ZSHENV="2.0"

# set up autoload for functions
if [[ -d ~/bin/zsh.fn ]] ; then
  fpath=(~/bin/zsh.fn)
  autoload $(cd ~/bin/zsh.fn ; echo *[^\~])
fi

# if this is a terminal worth setting the title in
case "$TERM" in
    xterm*|Eterm|screen)
        chpwd () {
            print -nP "\e]2;%m:%~\a"
            print -nP "\e]1;%m!%n\a"
        }
        chpwd
        ;;
esac

# don't automatically nice background processes
unsetopt BGNICE
# automatically export variables, where possible
#setopt allexport
# what is this doing here?
export PWD

PATH=$PATH:/bin:/usr/bin

# determine binary type
BINTYPE=`uname -sr | sed -e "s/ /-/g"`
case $BINTYPE in
  SunOS-5*) BINTYPE="Solaris-2.x" ;;
  SunOS-4*) BINTYPE="SunOS-4.x"   ;;
  Linux-*)  BINTYPE="Linux"       ;;
esac  

# ==============
# PATH FROM HELL
# ==============

HOMEBIN=$HOME/bin
# a list of possible binary locations. directories that you want at the
# front of your PATH should come first in this list.
BINDIRS=( $HOMEBIN/$BINTYPE            \
          $HOMEBIN/links                \
	  $HOMEBIN/scripts              \
          $HOMEBIN/noarch               \
          $HOME/sw/bin                  \
	  /usr/remote/bin		\
	  /usr/local/X11R6/bin 		\
	  /usr/local/lib/tex/bin 	\
	  /usr/local/lib/mh             \
	  /usr/local/etc                \
	  /usr/local/bin                \
	  /usr/ucb                      \
	  /usr/games			\
          /usr/games/bin                \
	  /usr/bin                      \
	  /usr/etc                      \
	  /usr/sbin                     \
	  /sbin                         \
	  /bin                          \
	  /etc                          \
	  /usr/sunos/bin                \
	  /usr/X11R6/bin                \
          /var/spool/news/bin           \
	  /usr/openwin/bin		\
	  /usr/ccs/bin			\
	  /usr/lib/news/bin             )

# start with a fresh path, please, since I do a lot of work on my path here...
unset PATH	    
foreach i in $BINDIRS ; do
  if [[ -d $i ]]; then
    if [[ -n "$PATH" ]] ; then
      PATH=$PATH:$i
    else
      PATH=$i
    fi
  fi
done
# add . (here) to path only if not root.
if [[ "$USERNAME" != "root" ]]; then
  PATH=$PATH:.
fi
rehash
export PATH

# ======================
# MANPATH FROM PURGATORY
# ======================

MANDIRS=( /usr/local/man       \
          /usr/local/share/man \
	  /usr/man             \
	  /usr/X11R6/man   \
	  $HOME/man            )

unset MANPATH
foreach i in $MANDIRS ; do
  if [[ -d $i ]] ; then
    if [[ -n "$MANPATH" ]] ; then
      MANPATH=$MANPATH:$i
    else
      MANPATH=$i
    fi
  fi
done
export MANPATH
unset MANPATH

# ===============
# LD_LIBRARY_PATH
# ===============

export LD_LIBRARY_PATH=$HOME/lib

# ick, this is ugly.
if [[ -d /usr/local/X11R6/lib ]] ; then
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/X11R6/lib"
fi
if [ -d /usr/dt/lib ] ; then
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/dt/lib"
fi
if [ -d /usr/remote/lib/simeon ] ; then
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/remote/lib/simeon"
fi

# =============
# VARIABLE SOUP
# =============

# Actually, this is gibberish. Will fix if necessary. 
#if [[ -n "$DISPLAY" ]] ; then
#  case $DISPLAY in
#    :*) export DISPLAY=`hostname`$DISPLAY ;;
#  esac
#fi

# your name here
# method 1: just set it to a string
NAME='Nick Vargish'
# method 2: extract it from the passwd file... Goddess I love Unix. :^)
#if grep "^${USERNAME}:" /etc/passwd >/dev/null 2>&1 ; then
#  export NAME="$( grep "^${USERNAME}:" /etc/passwd | 
#                  cut -d ":" -f 5 | cut -d "," -f 1 )"
#else
#  export NAME="$( ypcat passwd | grep "^${USERNAME}:" | 
#                  cut -d ":" -f 5 | cut -d"," -f 1 )"
#fi

# SHOST is used in title bar settings and icon names (see bin/zsh.fn/chpwd)
DOMAIN=$( cat /etc/resolv.conf | grep "domain" | cut -f 2 -d " " )
export SHOST=`basename $HOST $DOMAIN`

# the next three variables are used by trn
export SAVEDIR=$HOME/news
export KILLGLOBAL=%p/.kills/KILL
export KILLLOCAL=%p/.kills/%c/KILL

# PGP environment variables
export PGPPATH=$HOME/.pgp

# netscape stuff
#if [ -d /usr/local/lib/X11/nls ] ; then
#  export XNLSPATH=/usr/local/lib/X11/nls
#fi

# XKeysymDB
#if [ -f /usr/openwin/lib/XKeysymDB ] ; then
#  export XKEYSYMDB=/usr/openwin/lib/XKeysymDB
#else
#  export XKEYSYMDB=/usr/X11/lib/X11/XKeysymDB
#fi

# Disable global compinit (always seems broken)
skip_global_compinit=1

# system mailbox
# MAIL=$HOME/Mailbox

# default printer
#export PRINTER=hp855c

# Scheme-specific
#export SCHEME_LIBRARY_PATH=/usr/local/lib/slib/:/usr/local/share/guile/1.1a/
#export STK_LIBRARY=/usr/local/lib/stk/3.0b2/
#export ENVDRAW_LIBRARY_PATH=/usr/local/lib/stk/EnvDraw/

# news server
export NNTPSERVER=wdc.news.speakeasy.net

# CVS environment
#export CVSROOT=":ext:nav@tanelorn:/opt/cvsroot"
#export CVSROOT=/opt/cvsroot

# mail stuff
#MAILHOST=bandersnatch.org

# nethack!
export HACKOPTIONS='name:Bander,pickup_types:$,DECgraphics,color,dogname:Misha,catname:Molly,fruit:durian,!rest_on_space,showscore,showexp,time,!cmdassist,autodig'
export NETHACKOPTIONS="$HACKOPTIONS"

# tmux
if [ -e /proc/loadavg ] ; then
    export TMUXLOADCMD='cut -d " " -f 1-3 /proc/loadavg'
else
    export TMUXLOADCMD='uptime | cut -d " " -f 10-12'
fi
