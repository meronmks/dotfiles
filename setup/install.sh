#!/bin/bash

#chmod +x ~/dotfiles/dot

# brewコマンドのインストール
if [ "$(uname)" == 'Darwin' ]; then
    #Mac
    echo "Install brew command."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
fi

# gitでクローンしてインストールするもの
git clone https://github.com/ssh0/dot $HOME/.zsh/dot
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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
    if [type apt 2>/dev/null 1>/dev/null]; then
        echo "apt update."
        sudo add-apt-repository ppa:git-core/ppa
        echo "apt update."
        sudo apt update
        echo "apt upgrade."
        sudo apt upgrade
        echo "Install zsh."
        sudo apt -y install zsh
        echo "Install tmux."
        sudo apt -y install tmux
    elif [type yum 2>/dev/null 1>/dev/null]; then
        echo "yum update."
        sudo yum update
        echo "yum upgrade."
        sudo yum upgrade
        echo "Install zsh."
        sudo yum -y install zsh
        echo "Install tmux."
        sudo yum -y install tmux
    fi
fi
# ログインシェル変更
echo "Change login shell."
chsh -s $BREWHOME/zsh
