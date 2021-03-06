#!/bin/zsh
########################
##                    ##
##   Nick's .zshenv   ##
##                    ##
########################

# version 3.0
#
# last major revision: 2013-06-21

# note: all zsh shells source this (unless explicitly instructed not to)

export NAV_ZSHENV="3.0"

## ========= ##
## Functions ##
## ========= ##

# set up autoload for functions
if [[ -d ~/.zsh/misc ]] ; then
  fpath=($fpath ~/.zsh/misc)
  autoload $(cd ~/.zsh/misc ; echo *[^\~])
fi


## ======= ##
## OPTIONS ##
## ======= ##

# don't automatically nice background processes
unsetopt BGNICE

# automatically export variables, where possible
#setopt allexport

# Disable global compinit (always seems broken)
skip_global_compinit=1


## ==== ##
## PATH ##
## ==== ##

# determine binary type
BINTYPE=`uname -sr | sed -e "s/ /-/g"`
case $BINTYPE in
  SunOS-5*) BINTYPE="Solaris-2.x" ;;
  SunOS-4*) BINTYPE="SunOS-4.x"   ;;
  Linux-*)  BINTYPE="Linux"       ;;
esac  

HOMEBIN=$HOME/bin
# a list of possible binary locations. directories that you want at the
# front of your PATH should come first in this list.
_bindirs=( $HOMEBIN/$BINTYPE
     $HOMEBIN/links
	   $HOMEBIN/scripts
     $HOMEBIN/noarch
     $HOME/sw/bin
 	   /usr/remote/bin
   	 /usr/local/bin
	   /usr/games
	   /usr/games/bin
	   /usr/bin
	   /usr/sbin
	   /sbin
	   /bin )

path=($^_bindirs(N))

# add . to path only if not root.
[[ "$USERNAME" != "root" ]] && path+=.

rehash
export path


## ============= ##
## VARIABLE SOUP ##
## ============= ##

# your name here
NAME='Nick Vargish'

# SHOST is used in title bar settings and icon names
_hostname=`hostname`
export SHOST=${_hostname%%\.*}
export DOMAIN=${_hostname#*\.}

# Scheme-specific
#export SCHEME_LIBRARY_PATH=/usr/local/lib/slib/:/usr/local/share/guile/1.1a/
#export STK_LIBRARY=/usr/local/lib/stk/3.0b2/
#export ENVDRAW_LIBRARY_PATH=/usr/local/lib/stk/EnvDraw/

# CVS environment
# Sourcefire CVS:
export CVSROOT=":ext:nvargish@scm.sfeng.sourcefire.com:/usr/cvsroot"
export CVS_RSH=ssh

# nethack!
export HACKOPTIONS='name:Bander,pickup_types:$,DECgraphics,color,dogname:Misha,catname:Molly,fruit:durian,!rest_on_space,showscore,showexp,time,!cmdassist,autodig,suppress_alert:3.4.3'
export NETHACKOPTIONS="$HACKOPTIONS"
