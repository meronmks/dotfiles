cdpath=(~)

#alias
case ${OSTYPE} in
    darwin*)
        #ここにMac向けの設定
        alias ls='ls -G'
        export PATH=$HOME/.nodebrew/current/bin:$PATH
        export BREWHOME=/usr/local/bin
        ;;
    linux*)
        #ここにLinux向けの設定
        alias ls='ls --color=auto'
        export BREWHOME=/home/linuxbrew/.linuxbrew/bin
        alias open='xdg-open 2>/dev/null'
        ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# 環境変数
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export EDITOR=vim
export PERCOL=fzf
#LinuxBrew
export HOMEBREW_NO_ANALYTICS=1
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

#fzfの存在確認となければインストールする
if [ -e $HOME/.fzf ]; then
    # 存在している場合（一応確認）
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    # 存在しない場合
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install
fi

# pyenvの環境変数等設定
if [[ -e $HOME/.pyenv ]]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
fi

# rbenvの設定
eval "$(rbenv init -)"
# 重複パスを登録しない
typeset -U path cdpath fpath manpath

# プロンプトの設定
autoload -Uz promptinit
promptinit
PROMPT="%~
%# "

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# 補完
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# 補完で大文字小文字区別しない
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#ビープ音を鳴らさない
setopt no_beep

#antigen
source ~/.antigen/antigen.zsh

#追加したいプラグインをここへ
antigen bundle ssh0/dot
antigen bundle zsh-users/zsh-completions
# 256色表示にする
antigen bundle chrissicool/zsh-256color
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
antigen bundle zsh-users/zsh-syntax-highlighting
# コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
antigen bundle zsh-users/zsh-history-substring-search
# 過去に入力したコマンドの履歴が灰色のサジェストで出る
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

#dotfiles
compdef dotall=dot_main
export DOT_REPO="https://github.com/meronmks/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"

# git設定

# git-foresta
export PATH="$HOME/.git-foresta:$PATH"

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"
