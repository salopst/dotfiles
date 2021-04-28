#!/bin/bash

# 2021-02-21
# yearluk
# ~/ubuntu-post-install.sh


sudo apt update && sudo apt upgrade -y
sudo apt install alacritty bc cheese cmus dconf-editor digikam dnsutils \ 
    evolution ffmpeg file flameshot \ 
    flatpak fonts-powerline fonts-roboto \ 
    fzf git glances gnome-tweaks gnome-user-share htop inxi jq keychain \ 
    lshw most mpv neofetch nmap openssh-server \ 
    python3 python3-dev python3-pip \ 
    python3-testresources ruby-dev\ 
    python-virtualenv \ 
    samba spice-vdagent stow texinfo tmux \ 
    wireguard zfsutils-linux zsh -y

if [[ ! ${SHELL} =~ zsh ]]; then 
    echo NOT ZSH; 
    sudo chsh -s `which zsh` `whoami`;  
    else echo 'VERILY TIS ZSH';
    exit 0;
fi
# sudo chsh -s `which zsh` `whoami` # no effect until resart

# antigen. Avoid the deb to stay current
mkdir $XDG_CONFIG_HOME/antigen
curl -L git.io/antigen > $XDG_CONFIG_HOME/antigen/antigen.zsh

# dev
sudo apt install autoconf automake autotools-dev \ 
    build-essential clang curl exiftool file \ 
    git gnugnupg2pg2 gridsite-clients kbd \ 
    libclang-dev libexif-dev libimlib2-dev virt-manager -y  

# virtualisation -- some diplication here ... separate into sections
sudo apt install curl genisoimage libguestfs-tools \ 
    libosinfo-bin libvirt-dev linux-source \ 
    qemu-kvm virtinst virt-manager virt-viewer uuid-runtime -y

sudo apt install btrfs-progs fuse gnutls-devlibjpeg-dev libtiff-dev \ 
    libssl-dev openssl libacl1-dev libacl1 \ 
    libgif-dev libxpm-dev libdsk-utils libgtk-3-dev  \ 
    libfuse-dev libmediainfo-dev  pkg-config \ 
    libncurses5-dev libreadline-dev libxml2-dev libxt-dev -y

# for phone connectivity
sudo apt install ifuse libimobiledevice6 libimobiledevice-utils -y
sudo mkdir -p /media/{iphone, macos, external}

# sunflower file manager
# sudo add-apt-repository ppa:atareao/sunflower
# sudo apt-get update
# sudo apt istall sunflower
# cat /etc/apt/sources.list
# sudo add-apt-repository ppa:atareao/sunflower
# sudo apt-get update

# sxiv: CLI imageviewer
cd $HOME/src && \ 
git clone https://github.com/muennich/sxiv.git  && cd sxiv \ 
make && sudo make install

# ytfzf: CLI youtube viewer
cd $HOME/src && \ 
git clone https://github.com/pystardust/ytfzf  && cd ytfzf \ 
sudo make install
# sudo make uninstall

# Alfred-like launcher
sudo add-apt-repository ppa:agornostal/ulauncher
sudo apt install ulauncher -y

# MediaElch ... a simple movie/tv show scraper
sudo add-apt-repository ppa:mediaelch/mediaelch-stable
sudo apt update
sudo apt install mediaelch -y

##### 
# Rust
curl https://sh.rustup.rs -sSf | sh
#
# rust replacements & feel-goods... https://zaiste.net/posts/shell-commands-rust/ aliases in .shell-aliases
# bat, exa, fdfind      # installed via apt
# alias bat=batcat
# type exa >/dev/null 2>&1 && alias ls='exa -lahGi'
# alias fd=fdfind

 # Default Crate install location is $HOME/.cargo/bin
cargo install du-dust   # du alternative;   bin is `dust` ``
cargo install skim      # FZF alternative;  bin is `sk`
cargo install tealdeer  # tldr alternative; bin is `tldr`
cargo install git-delta # file diffing.
cargo install zellij    # a terminal workspace -- buggy as of 2021-04-28
cargo install grex      # provide pattern... it offers a possible regex
cargo install ytop      # purdy htop
cargo install bat       # purdy cat
cargo install zoxide    # fast `cd`ing around the filesystem
cargo install procs     # procs is a modern replacement for `ps`
cargo install hyperfine # performance monitor
cargo install sd        # more intuitive than `sed`
cargo install exa       # drop-in replacement for `ls`
cargo install fd-find   # a better `find` than `find`?
cargo install bandwhich # display current network utilization by process
cargo install ripgrep `rg` .. a better grep?
cargo install starship # lovely drop-in command prompt

#####
# Pip apps (python)
sudo pip install --user --upgrade youtube_dl
# a CLI front-end for borgbackup
sudo pip3 install --user emborg
# a set of rules for auto-managing files--- kinda like MacOS' Hazel or Maid
sudo pip3 install -U organize-tool  



# screen recorders:
# screenrec -- v simple
sudo wget -qO - https://screenrec.com/download/pub.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://screenrec.com/download/ubuntu stable main' -y
sudo apt update
sudo apt install screenrec -y 
# OBS -- the grandaddy
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt update
sudo apt install obs-studio -y


wget -qO- https://git.io/papirus-icon-theme-install | sh

# vorta -- based on borgbackup -- did not work, but also installs borg
# sudo add-apt-repository ppa:samuel-w1/vorta
# sudo apt-get update
# sudo apt-get install vorta
# sudo apt remove vorta
# sudo add-apt-repository --remove ppa:PPA_Name/ppa
# Use the following command to see all the PPAs added in your system:

# sudo ls /etc/apt/sources.list.d
# Look for your desire PPA here and then remove the PPA using the following command:

# sudo rm -i /etc/apt/sources.list.d/PPA_Name.list
# https://itsfoss.com/how-to-remove-or-delete-ppas-quick-tip/


# Flatpak
# to add to ulauncher etc, add aliases $XDG_CONFIG_HOME/.shell_aliases.sh...
# alias vscodium="flatpak run com.vscodium.codium"
if [ $(dpkg-query -W -f='${Status}' flatpak 2>/dev/null | grep -c "ok installed") -eq 0 ];
      then
	echo ""
	echo "Installing → flatpak"
	echo ""
    sudo apt-get install -qq -y flatpak;
fi

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak install -y --noninteractive --user \ 
    org.audacityteam.Audacity org.audacityteam.Audacity.Codecs \ 
    org.telegram com.bitwarden.desktop com.calibre_ebook.calibre \ 
    org.clementine_player.Clementine io.github.cmus.cmus io.github.Hexchat \ 
    org.gnome.Evince org.freefilesync.FreeFileSync im.pidgin.Pidgin \ 
    org.qownnotes.QOwnNotes org.signal.Signal com.skype.Client \ 
    com.spotify.Client org.texstudio.TeXstudio \ 
    com.transmissionbt.Transmission com.vscodium.codium -y


# NPM
npm install -g nativefier

Module for espanso .. https://espanso.org/install/linux/
# Make sure to have the $HOME/opt directory
mkdir -p $HOME/opt

# Download the latest Modulo AppImage in the $HOME/opt
wget https://github.com/federico-terzi/modulo/releases/latest/download/modulo-x86_64.AppImage -O $HOME/opt/modulo.AppImage

# Make it executable:
chmod u+x $HOME/opt/modulo.AppImage

# Create a link to make modulo available as "modulo"
sudo ln -s $HOME/opt/modulo.AppImage /usr/bin/modulo

#gnome sushi -- like MacOS "quicklook"