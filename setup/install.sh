#!/bin/bash
cd `dirname $0`

source ../.bashrc

if type sudo > /dev/null 2>&1; then
    SUDO='sudo'
else
    SUDO=''
fi
if [ ${EUID:-${UID}} = 0 ]; then
    SUDO=''
fi

if [ "$(uname)" == 'Darwin' ]; then
    # Mac
    export BREWHOME="/usr/local/bin"
    echo "Chaek Homebrew..."
    if type brew > /dev/null 2>&1; then
        echo "$(tput setaf 2)Already installed Homebrew ✔︎$(tput sgr0)"
    else
        echo "Installing xcode-select"
        xcode-select --install
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && echo "$(tput setaf 2)Success install Homebrew ✔︎$(tput sgr0)"
    fi
    brew doctor
    brew update && brew upgrade
    brew install reattach-to-user-namespace
    brew install git
    brew install zsh
    brew install pyenv
    brew install rbenv
    brew install goenv
    brew install direnv
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    export BREWHOME="/home/linuxbrew/.linuxbrew/bin"
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
    if type apt > /dev/null 2>&1; then
        $SUDO apt -y update
        $SUDO apt -y upgrade
        $SUDO apt -y install xsel
        $SUDO apt -y install language-pack-ja
        $SUDO apt -y install build-essential
        $SUDO apt -y install curl
    elif type dnf > /dev/null 2>&1; then
        sudo dnf -y update
        sudo dnf -y upgrade
        sudo dnf -y groupinstall "Development Tools" && dnf yum -y install xsel curl m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel openssl-devel glibc-langpack-ja util-linux-user vim
    elif type yum > /dev/null 2>&1; then
        sudo yum update
        sudo yum upgrade
        sudo yum -y install xsel
        sudo yum -y groupinstall "Development Tools" && sudo yum -y install xsel curl m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel openssl-devel
    fi
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
    brew doctor
    brew update && brew upgrade
    brew install git git-lfs openssl
    brew install zsh
    brew install p7zip
    brew install pyenv
    brew install rbenv
    brew install goenv
    brew install direnv
    #dev
    if type apt > /dev/null 2>&1; then
        $SUDO apt -y remove git
    elif type dnf > /dev/null 2>&1; then
        sudo dnf -y remove git
    elif type yum > /dev/null 2>&1; then
        sudo yum -y remove git
    fi
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

# gitでクローンしてインストールするもの
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/takaaki-kasai/git-foresta.git ~/.git-foresta && chmod +x ~/.git-foresta
mkdir ~/.antigen/
curl -L git.io/antigen > ~/.antigen/antigen.zsh
# gitの認証情報を保存するように設定
git config --global credential.helper cache

# ログインシェル変更
echo "Change LoginShell..."
if grep $BREWHOME/zsh /etc/shells > /dev/null; then
    echo "$(tput setaf 2)Added /etc/shells to $BREWHOME/zsh ✔︎$(tput sgr0)"
        else
    sudo sh -c "echo "$BREWHOME/zsh"  >> /etc/shells"
    echo "$(tput setaf 2)Success add /etc/shells to $BREWHOME/zsh ✔︎$(tput sgr0)"
fi
chsh -s $BREWHOME/zsh && echo "$(tput setaf 2)Success change shell zsh ✔︎$(tput sgr0)"

touch ~/.zshrc
zsh -c "source ~/.dotfiles/.zshrc"
