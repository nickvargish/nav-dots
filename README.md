
# Nick's Unix Environment #

## Description ##

This is a collection of files and scripts that comprise Nick Vargish's
Unix environment. 


## Manifest ##

### Emacs files ###

  - `emacs`  
    The basic `.emacs` file. Manipulates load path, adds some
    automatic file type recognition stuff.
  - `gnus`  
    Configuration for the Gnus Usenet news reader; I don't use it any
    more, but can't bring myself to throw it out.

### Tmux files ###

  - `tmux.conf`  
    Configuration file for tmux.

### Zsh ###

  - `zshenv`, `zshrc`, `zshalii`  
    Configuration files for zsh
  - `zsh`  
    Directory containing function files.

### Scripts ###

  - `noarch`
    Copied to `$HOME/bin/noarch`, these are architecture independent
    scripts.

### Utilities ###

  - `copydots`  
    Run this to copy the dot files and directories into the
    appropriate locations in `$HOME`.
  - `noarch/mkgittgz`  
    Creates an archive in the parent directory of the current git
    project.
