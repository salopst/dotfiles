# 2021-04-28
# yearluk
# $HOME/.zshrc
# 
# http://zsh.sourceforge.net/Intro/intro_3.html
# There are five startup files that zsh will read commands from:
# $ZDOTDIR/.zshenv
# $ZDOTDIR/.zprofile
# $ZDOTDIR/.zshrc
# $ZDOTDIR/.zlogin
# $ZDOTDIR/.zlogout
# If ZDOTDIR is not set, then the value of HOME is used; this is the usual case

setopt nohup
setopt nobeep
setopt nohistbeep
setopt nolistbeep


COMPLETION_WAITING_DOTS="true"
DISABLE_LS_COLORS="false"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
DISABLE_UNTRACKED_FILES_DIRTY="true"
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS=true
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# pull in global aliases
if [ -f "$XDG_CONFIG_HOME/.shell_aliases.sh" ] ; then
  echo "+ aliases exist"
  source "$XDG_CONFIG_HOME/.shell_aliases.sh"
fi

# grab the antigens
source $XDG_CONFIG_HOME/antigen/antigen.zsh

# https://github.com/ajeetdsouza/zoxide#step-3-add-zoxide-to-your-shell
eval "$(zoxide init zsh)"

# Do OS dependant stuff
case `uname` in
  Darwin) 
  	# Commands for OS X go here
    antigen bundle osx
	# super update: Apple, homebrew, gem, node, stack is for Haskell
	alias supdate="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; \
		 brew upgrade spotify-tui gem update; gem cleanup; npm update; stack upgrade"
	# Speed-up Terminal load time by clearing system logs
	alias speedup="sudo rm -rf /private/var/log/asl/*"
	# Empty the Trash on all mounted volumes and the main HDD
	# Also, clear Apple’s System Logs to improve shell startup speed
	alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; speedup"
	# for Haskell on MacOS:
	source $HOME/.ghcup/env
	# for Groovy on MacOS:
	export GROOVY_HOME=/usr/local/opt/groovy/libexec
  ;;
  Linux)
    # Commands for Linux go here
  ;;
esac


# this kind of flummery should either be deleted or moved elsewhere.
if [[ $DESKTOP_SESSION == "pop" ]]
		then
			echo -e '
			 _ __   ___  _ __  
			| ._ \ / _ \| ._ \ 
			| |_) | (_) | |_) |
			| .__/ \___/| .__/ 
			|_|         |_| 

			'
			echo "\n`date`\n"
			echo "`fortune`\n"
			alias supdate="sudo apt update \
			&& sudo apt upgrade -y \
			&& sudo apt autoremove \
			&& sudo apt clean \
			&& sudo gem update \
			&& flatpak update \
			&& antigen update \
			&& rustup update \
			&& sudo npm install -g npm"

fi


# HISTORY SETTINGS
HISTFILE=~/.zsh_history
HISTSIZE=10000
setopt    EXTENDED_HISTORY
setopt    HIST_IGNORE_ALL_DUPS
setopt    HIST_IGNORE_DUPS
setopt    HIST_IGNORE_SPACE
setopt    HIST_NO_STORE
setopt    HIST_REDUCE_BLANKS
setopt    HIST_VERIFY
SAVEHIST=10000
setopt append_history           # allow multiple sessions to append to one history
setopt bang_hist                # treat ! special during command expansion
setopt extended_history         # Write history in :start:elasped;command format
setopt hist_expire_dups_first   # expire duplicates first when trimming history
setopt hist_find_no_dups        # When searching history, don't repeat
setopt hist_ignore_dups         # ignore duplicate entries of previous events
setopt hist_ignore_space        # prefix command with a space to skip it's recording
setopt hist_reduce_blanks       # Remove extra blanks from each command added to history
setopt hist_verify              # Don't execute immediately upon history expansion
setopt inc_append_history       # Write to history file immediately, not when shell quits
setopt share_history            # Share history among all sessions

# TAB COMELETIONS
autoload -Uz compinit && compinit
setopt complete_in_word         # cd /ho/sco/tm<TAB> expands to /home/scott/tmp
setopt auto_menu                # show completion menu on succesive tab presses
setopt autocd                   # cd to a folder just by typing it's name
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&' # These "eat" the auto prior space after a tab complete

# MISC
setopt interactive_comments     # allow # comments in shell; good for copy/paste
unsetopt correct_all            # I don't care for 'suggestions' from ZSH
export BLOCK_SIZE="'1"          # Add commas to file sizes

# PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
typeset -U path                 # keep duplicates out of the path
path+=(.)                       # append current directory to path (controversial)


##### ANTIGEN #####
#
# periodically run `antigen update` ... or add to $XDG_CONFIG_HOME/.shell_aliases.sh
#

if [[ ! -a $ANTIGEN_HOME/antigen.zsh ]]; then
	mkdir -p  $ANTIGEN_HOME && cd $ANTIGEN_HOME &&
	curl -L git.io/antigen > antigen.zsh
fi
source $ANTIGEN_HOME/antigen.zsh
#antigen use oh-my-zsh
antigen bundles <<EOF_BUNDLES
	command-not-found
	fzf
	# git	# DOES NOT WORK : Antigen: Failed to load plugin. compdef: unknown command or service: git-log
	z		# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-completions src
	zsh-users/zsh-history-substring-search
	zsh-users/zsh-autosuggestions
EOF_BUNDLES
antigen apply


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


##### STARSHIP PROMPT #####
#
# https://starship.rs/
# export STARSHIP_CONFIG=~/.config/starship.toml #DEFAULT
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml # for GNU stow purposes
eval "$(starship init zsh)"
