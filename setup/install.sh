#!/bin/bash

# chmod +x ~/dotfiles/dot

if [ "$(uname)" == 'Darwin' ]; then
    # Mac
    echo "Chaek Homebrew..."
    if type brew > /dev/null 2>&1; then
        echo "$(tput setaf 2)Already installed Homebrew ✔︎$(tput sgr0)"
    else
        echo "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo "$(tput setaf 2)Install success Homebrew ✔︎$(tput sgr0)"
    fi
    brew doctor
    brew update && brew upgrade
    brew doctor
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
        sudo apt -y install xsel language-pack-ja build-essential
        sudo apt -y install linuxbrew-wrapper
        brew install zsh tmux p7zip-full git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev python3-tk tk-dev python-tk libfreetype6-dev
    elif type yum > /dev/null 2>&1; then
        sudo yum update
        sudo yum upgrade
        sudo yum -y install xsel
        sudo yum -y groupinstall 'Development Tools' && sudo yum -y install xsel curl git m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel openssl-devel
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
        brew install zsh tmux p7zip-full git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev python3-tk tk-dev python-tk libfreetype6-dev
    fi
fi

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

# gitでクローンしてインストールするもの
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/yyuu/pyenv.git ~/.pyenv

#zsh
zsh
source ~/.dotfiles/.zshrc
# ログインシェル変更
# echo "Change login shell."
# chsh -s $BREWHOME/zsh
