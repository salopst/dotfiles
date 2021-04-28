# f:	~/.zshrc
# a:	sjy2
# o:	2008-04-09
# m: 	2019-12-12
# n:	
# td:	expand aliases, bunndles and prompts cross distros

source ~/.shell_aliases

# 2020-04-02 after catalina update
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

setopt nohup
setopt nobeep
setopt nohistbeep
setopt nolistbeep

COMPLETION_WAITING_DOTS="true"
DISABLE_LS_COLORS="false"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
DISABLE_UNTRACKED_FILES_DIRTY="true"


# History settings
HISTFILE=~/.history_zsh
HISTSIZE=10000
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

# Tab completion
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
typeset -U path                 # keep duplicates out of the path
path+=(.)                       # append current directory to path (controversial)





## Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='kate' # mate for MacOS?, geany for Gnomes like Pop etc.
# fi
export EDITOR="/usr/bin/vim"
export MYOS=`uname`
export LANG="en_US.UTF-8"
export ARCHFLAGS="-arch x86_64"
export SSH_KEYS="~/.ssh/"


# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:/usr/local/bin:/sbin:/usr/local/opt/mysql-client/bin:$PATH


### oh-my-zsh ###
export ZSH="$HOME/.oh-my-zsh"
# is export otiose in the below?
# my modified /usr/local/lib/node_modules/pure-prompt/pure.zsh
export ZSH_THEME="zeta-pure" 
export UPDATE_ZSH_DAYS=3
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# CASE_INSENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

plugins=(
    git
    ruby
)

source $ZSH/oh-my-zsh.sh
## END oh-my-zsh


### ANTIGEN ###
#
# Periodically run the curl, and `source` anitgen
# cd ~/ && curl -L git.io/antigen > antigen.zsh
source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle pip
antigen bundle command-not-found

antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting

#antigen bundle robbyrussell/oh-my-zsh plugins/ruby

antigen bundle history

# pure prompt
antigen bundle mafredri/zsh-async
# line below controls pure prompt as installed using npm

antigen bundle sindresorhus/pure

# antigen theme candy

antigen apply

### END ANTIGEN





if [[ $MYOS == "Linux" ]]
then
	export DISTRO=" `lsb_release -is` "
	alias about="inxi -F"
	alias aboutscreen="inxi -G"
	
	if [[ `lsb_release -is` == "EndeavourOS" ]]
		then
			echo -e '
		    _____           _                                   ___  ____  
		   | ____|_ __   __| | ___  __ ___   _____  _   _ _ __ / _ \/ ___| 
		   |  _| | | _ \ / _` |/ _ \/ _  \ \ / / _ \| | | | __| | | \___ \ 
		   | |___| | | | (_| |  __/ (_| |\ V / (_) | |_| | |  | |_| |___) |
		   |_____|_| |_|\__,_|\___|\__,_| \_/ \___/ \__._|_|   \___/|____/ 
                                                             
			'
			echo `fortune`
			alias supdate="sudo pacman -Syu"
			alias edz="mousepad ~/.zshrc &"
	fi	
	
	if [[ `lsb_release -is` == "neon" ]]
		then
			echo -e '
		    _  ______  _____   _   _                  
		   | |/ /  _ \| ____| | \ | | ___  ___  _ __  
		   | . /| | | |  _|   |  \| |/ _ \/ _ \|  _ \ 
		   | . \| |_| | |___  | |\  |  __/ (_) | | | |
		   |_|\_\____/|_____| |_| \_|\___|\___/|_| |_|                      

			'
			echo `fortune`
			alias supdate="sudo pkcon refresh && sudo pkcon update -y && \
				sudo apt clean && sudo apt update && sudo apt upgrade -y && sudo apt autoremove"
			alias edz="kate ~/.zshrc"
	fi
	
	if [[ $DESKTOP_SESSION == "pop" ]]
		then
			echo -e '
			 _ __   ___  _ __  
			| ._ \ / _ \| ._ \ 
			| |_) | (_) | |_) |
			| .__/ \___/| .__/ 
			|_|         |_| 

			'
			echo `fortune`
			alias supdate="sudo apt update && sudo apt upgrade -y && sudo apt autoremove && sudo apt clean"
	fi
	
	
else # obvs MacOS
	echo -e '
	 __  __             ___  ____
	|  \/  | __ _  ___ / _ \/ ___|
	| |\/| |/ _` |/ __| | | \___ \
	| |  | | (_| | (__| |_| |___) |
	|_|  |_|\__,_|\___|\___/|____/

	'
	echo `fortune`
	export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
	alias sl="sl;ls"
	alias about="system_profiler -detailLevel mini"
	alias aboutscreen="system_profiler SPDisplaysDataType"
	alias code="cd ~/code"
	alias edz="mate ~/.zshrc &"
	# edit dofiles
	alias eddot="mate .zshrc; mate .bashrc"
	alias imgconv="for i in *.jpeg; do sips -s format png $i --out converted/$i.png; done"
	alias pman "man -t \!:* | open -f -a Preview"
	alias kate='open -a /Applications/kate.app'
	alias mate='open -a TextMate.app'
	alias sublime='open -a "Sublime Text.app"'
	alias vscode='open -a /Applications/Visual\ Studio\ Code.app'
	alias killds='find . -name .DS_Store -type f -delete'
	# super update: Apple, homebrew, gem, node, stack is for Haskell
	alias supdate="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; \
		 brew upgrade spotify-tui gem update; gem cleanup; npm update; stack upgrade"
	# Speed-up Terminal load time by clearing system logs
	alias speedup="sudo rm -rf /private/var/log/asl/*"
	# Empty the Trash on all mounted volumes and the main HDD
	# Also, clear Apple’s System Logs to improve shell startup speed
	alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; speedup"
	
	# for Haskell on MacOS:
	source /Users/yearluk/.ghcup/env

	# for Groovy on MacOS:
	export GROOVY_HOME=/usr/local/opt/groovy/libexec
fi


### KEYBINDING ###
#
# $ zle -al used for list all registered zle commands
# 
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-whole-line




### ALIASES -- X-PLATFORM ###
#
# For a full list of active aliases, run `alias`.
#
# alias bak () { cp -r $1 $1.$(date +%Y%m%d-%H%M%S) }

# git config location
alias whichgit="git config --list --show-origin"



alias root='sudo -i'
alias su='sudo -i'
alias wget='wget -c'
alias du='du -ch'



alias cls="clear"
alias e="printf'\e[8;50;100 t';emacs-nw"
# alias h="history"
# alias hg="history -1000 | grep -i"
alias h="history | grep -i "
alias ls="ls -hlAGi"
alias lstree="find . -type d | sed -e 1d -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|-/'"
alias openports="sudo lsof -i -P -n | grep -i 'listen'"
alias isodt='strftime %FT%T%z'

alias cpzout="cp -f ~/.zshrc ~/Nextcloud/lin-share/gitdotfiles/.zshrc && \ 
	cp -f ~/.zsh_aliases ~/Nextcloud/lin-share/gitdotfiles/.zsh_aliases && \
	echo '.zshrc AND .zsh_aliases COPIED to ~/Nextcloud/lin-share/gitdotfiles' "

alias cpzin="cp -f ~/.zshrc ~/.zshrc.bak; cp -f ~/Nextcloud/lin-share/gitdotfiles/.zshrc ~/.zshrc && \ 
	cp -f ~/Nextcloud/lin-share/gitdotfiles/ .zsh_aliasesc ~/.zsh_aliases && \ 
	echo '.zshrc AND .zsh_alliases REPLACED with "~/Nextcloud/lin-share/gitdotfiles" zfiles' "

# get file permissions in octal (i.e. 0755)
alias perms="stat -f '%A %a %N' *"
alias reload="exec ${SHELL}"
alias zup="cd ~/ && curl -L git.io/antigen > antigen.zsh; source ~/antigen.zsh; \ 
	 exec zsh"

function sshkill(){
	# When SSH host key changes run `sshkill 21` or whatever line number and it deletes it. Just running sshf clears known_hosts
    sed -i "$1d" ~/.ssh/known_hosts
}

function myip() {
  local ipv4 ipv6 ptr4 ptr6
  ipv4=$(curl --silent -4 https://icanhazip.com/)
  ptr4=$(curl --silent -4 https://icanhazptr.com/)
  ipv6=$(curl --silent -6 https://icanhazip.com/)
  ptr6=$(curl --silent -6 https://icanhazptr.com/)
  [[ -z $ipv4 && -z $ptr4 ]] && echo "No IPv4 internet connectivity" || echo "IPv4: $ipv4 ($ptr4)"
  [[ -z $ipv6 && -z $ptr6 ]] && echo "No IPv6 internet connectivity" || echo "IPv6: $ipv6 ($ptr6)"
}


function extract() {
	# Extract most know archives with one command
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2) tar xjf $1 ;;
			*.tar.gz) tar xzf $1 ;;
			*.bz2) bunzip2 $1 ;;
			*.rar) unrar e $1 ;;
			*.gz) gunzip $1 ;;
			*.tar) tar xf $1 ;;
			*.tbz2) tar xjf $1 ;;
			*.tgz) tar xzf $1 ;;
			*.zip) unzip $1 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*) echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}


function fs() {
	# Determine size of a file or total size of a directory
	if du -b /dev/null >/dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [[ -n $@ ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* ./*
	fi
}

export PATH="/usr/local/opt/texinfo/bin:$PATH"
