# 2021-03-15
# yearluk
# $HOME/.zshenv
#
# There are five startup files that zsh will read commands from:
# $ZDOTDIR/.zshenv
# $ZDOTDIR/.zprofile
# $ZDOTDIR/.zshrc
# $ZDOTDIR/.zlogin
# $ZDOTDIR/.zlogout
# If ZDOTDIR is not set, then the value of HOME is used; this is the usual case

export HOME="/home/yearluk"
#export ZDOTDIR="$HOME/.config/zsh"

export ARCHFLAGS="-arch x86_64"
export DOT="$HOME/.dotfiles"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export MYOS=`uname`
# PATH is in $HOME/.zshrc
export SSH_KEYS="$HOME/.ssh"
export UPDATE_ZSH_DAYS=14
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="$HOME/.local/share/applications:/usr/local/bin:$XDG_DATA_DIRS"
export ANTIGEN_HOME="$XDG_CONFIG_HOME/antigen"
export ANTIGEN_LOG="$ANTIGEN_HOME/antigen.log"
export GIT_CONFIG="$XDG_CONFIG_HOME/git/config"

# Rust
source "$HOME/.cargo/env"

# export JAVA_HOME="$(/usr/libexec/java_home)"
