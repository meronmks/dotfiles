#!/bin/bash

chmod -R +x $HOME/.dotfiles/tmux/*
#chmod +x ~/dotfiles/dot

# brewコマンドのインストール
echo "Install brew command."
if [ "$(uname)" == 'Darwin' ]; then
    #Mac
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    #Linux
    sudo apt-get update
    sudo apt-get install -y build-essential curl file git python-setuptools ruby bc
    git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew
else
    #その他
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

brew doctor

# gitでクローンしてインストールするもの
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# brewでのインストール

echo "Install zsh."
brew install zsh
# ログインシェル変更
echo "Change login shell."
chsh -s $BREWHOME/zsh
echo "Install tmux"
brew install tmux
