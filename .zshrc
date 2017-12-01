cdpath=(~)

# 環境変数
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export EDITOR=vim
export PERCOL=fzf
export GETAROOT=$HOME/Desktop/GETA
#LinuxBrew
export HOMEBREW_NO_ANALYTICS=1
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export XDG_DATA_DIRS="/home/linuxbrew/.linuxbrew/share:$XDG_DATA_DIRS"
PATH=$PATH:$HOME/.dotfiles/tmux

# pyenvの環境変数等設定
if [[ -e $HOME/.pyenv ]]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
fi

#fzfの存在確認となければインストールする
if [ -e $HOME/.fzf ]; then
    # 存在している場合（一応確認）
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    # 存在しない場合
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install
fi

# tmux関連（ http://qiita.com/ssh0/items/a9956a74bff8254a606a の丸パクリ）
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

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
        export BREWHOME=$HOME/.linuxbrew/bin
        alias open='xdg-open 2>/dev/null'
        ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#npm
npm completion

#zplug
unsetopt BG_NICE
source ~/.zplug/init.zsh

#追加したいプラグインをここへ
zplug "ssh0/dot", use:"*.sh"
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

#dotfiles
compdef dotall=dot_main
export DOT_REPO="https://github.com/meronmks/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"

# git設定
RPROMPT="%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
