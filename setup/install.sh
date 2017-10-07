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
    echo "brew update."
    brew update
    echo "brew upgrade."
    brew upgrade
    echo "Install reattach-to-user-namespace."
    brew install reattach-to-user-namespace
    echo "Install zsh."
    brew install zsh
    echo "Install tmux"
    brew install tmux
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    if type apt > /dev/null 2>&1; then
        sudo add-apt-repository ppa:git-core/ppa
        sudo apt update
        sudo apt upgrade
        sudo apt -y install zsh
        sudo apt -y install tmux
        sudo apt -y install xsel
    elif type yum > /dev/null 2>&1; then
        sudo yum update
        sudo yum upgrade
        # git
        sudo yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
        cd /usr/local/src/
        git clone git://git.kernel.org/pub/scm/git/git.git
        yum remove -y git
        cd git
        make prefix=/usr/local all
        make prefix=/usr/local install
        
        # tmux
        cd /usr/local/src/
        sudo yum -y install gcc libevent-devel ncurses-devel
        curl -kLO https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz
        tar -zxvf tmux-2.3.tar.gz
        cd tmux-2.3
        ./configure
        make
        sudo make install
        sudo yum -y install xsel
    elif type pacman > /dev/null 2>&1; then
        sudo pacman -Sy zsh
        sudo pacman -Sy tmux
        sudo pacman -Sy zsel
        sudo pacman -Sy git
    fi
fi

# gitでクローンしてインストールするもの
git clone https://github.com/zplug/zplug ~/.zplug
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#zsh
zsh
source ~/.dotfiles/.zshrc
# ログインシェル変更
# echo "Change login shell."
# chsh -s $BREWHOME/zsh
