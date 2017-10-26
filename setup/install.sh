#!/bin/bash

#chmod +x ~/dotfiles/dot

# brewコマンドのインストール
if [ "$(uname)" == 'Darwin' ]; then
    #Mac
    echo "Install brew command."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
fi

if [ "$(uname)" == 'Darwin' ]; then
    #Mac
    brew update
    brew upgrade
    brew install reattach-to-user-namespace
    brew install zsh
    brew install tmux
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    if type apt > /dev/null 2>&1; then
        sudo add-apt-repository ppa:git-core/ppa
        sudo apt -y update
        sudo apt -y upgrade
        sudo apt -y install language-pack-ja
        sudo apt -y install zsh
        sudo apt -y install tmux
        sudo apt -y install xsel
        sudo apt -y install build-essential
    elif type yum > /dev/null 2>&1; then
        sudo yum update
        sudo yum upgrade
        # git
        sudo yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker
        cd /usr/local/src/
        sudo git clone git://git.kernel.org/pub/scm/git/git.git
        sudo yum remove -y git
        cd git
        sudo make prefix=/usr/local all
        sudo make prefix=/usr/local install
        
        # tmux
        cd /usr/local/src/
        sudo yum -y install gcc libevent-devel ncurses-devel
        sudo curl -kLO https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz
        sudo tar -zxvf tmux-2.3.tar.gz
        cd tmux-2.3
        sudo ./configure
        sudo make
        sudo make install
        sudo yum -y install xsel
    elif type pacman > /dev/null 2>&1; then
        sudo pacman -Sy zsh
        sudo pacman -Sy tmux
        sudo pacman -Sy zsel
        sudo pacman -Sy git
    fi
fi

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

# gitでクローンしてインストールするもの
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#zsh
zsh
source ~/.dotfiles/.zshrc
# ログインシェル変更
# echo "Change login shell."
# chsh -s $BREWHOME/zsh
