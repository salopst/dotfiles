# 2021-04-28
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
export ZDOTDIR="$HOME"
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
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PAGER="less"

export EDITOR="/usr/local/bin/emacs"    # should play with vim at some point?
export VISUAL=$EDITOR

export VIMINIT='source ~/.config/vim/vimrc'

# fzf -- DOES NOT WORK??
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden *'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS=" --preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS=" --preview 'tree -C {} | head -50'"

# Rust
source "$HOME/.cargo/env"

# export JAVA_HOME="$(/usr/libexec/java_home)"

# $TERM_PROGRAM set by app calling shell
if [ "$TERM_PROGRAM" = "vscode" ]
then
  echo "internal vscodium terminal"
else
  echo "+ sanity resumed"
fi
