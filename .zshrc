# vim: et ts=2 sw=2:

#------------------------------------------------------------
# Language / Character set
#
export LC_ALL=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_TIME=C
export LANG=ja_JP.UTF-8

#------------------------------------------------------------
# Path for executables / libraries
#
export PATH=$HOME/local/bin:$HOME/.local/bin:$PATH
#PATH=$PATH:/bin:/usr/bin:/usr/local/bin
#PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin
#export LD_LIBRARY_PATH=/usr/local/lib

#------------------------------------------------------------
# Other environments
#
export MANPATH=$HOME/local/man:$HOME/.local/man:$MANPATH
export EDITOR=vim
unset SSH_ASKPASS

#------------------------------------------------------------
# Machine-dependent environments
#
setopt nonomatch
function loadprofiled {
  if ls $1/*.zsh > /dev/null 2>&1; then
    for sh in $1/*.zsh
    do
      . $sh
    done
    unset sh
  fi
}
loadprofiled /etc/profile.d
loadprofiled $HOME/.local/profile.d

#------------------------------------------------------------
# Custom completion
#
zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
source ~/.git-completion/git-prompt.sh
source ~/.git-flow-completion/git-flow-completion.zsh

#------------------------------------------------------------
# Key binds
#
bindkey -e
bindkey ""    backward-delete-char
bindkey ""    backward-delete-char
bindkey "[3~" delete-char
bindkey "[1~" beginning-of-line
bindkey "[4~" end-of-line
bindkey "OH"  beginning-of-line
bindkey "OF"  end-of-line
bindkey ""    history-beginning-search-backward
bindkey ""    history-beginning-search-forward
bindkey "OD"  backward-word
bindkey "OC"  forward-word
bindkey "[1;5D"   backward-word
bindkey "[1;5C"   forward-word
bindkey "[1;3D"   backward-char
bindkey "[1;3C"   forward-char
bindkey "[1;2D"   backward-char
bindkey "[1;2C"   forward-char

bindkey -s ""  "q %$EDITOR"
bindkey -s "l" "|less"
bindkey -s "n" ">/dev/null"
bindkey -s "v" "|vim +'set nomodified' -"

#------------------------------------------------------------
# Prompt (left and right)

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]%u:'
precmd() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  psvar[1]=$vcs_info_msg_0_
}
if [[ -n "$TMUX" ]]; then
  let ESHLVL="$SHLVL - 1"
else
  let ESHLVL="$SHLVL"
fi
export ESHLVL
if [[ $ESHLVL -le 1 ]]; then
  shlvlstr=""
else
  shlvlstr="[$ESHLVL]"
fi
if [[ $UID = "0" ]]; then
  PROMPT="%{[1;31m%}%n@%m$shlvlstr# %{[0m%}"
  RPROMPT="%{[0;31m%}[%{[0;33m%}%1v%{[0;31m%}%48<...<%~]%{[0m%}"
else
  PROMPT="%{[1;32m%}%n@%m$shlvlstr$ %{[0m%}"
  RPROMPT="%{[0;32m%}[%{[0;33m%}%1v%{[0;32m%}%48<...<%~]%{[0m%}"
fi

#------------------------------------------------------------
# Shell options
#
setopt extended_history   # 履歴にタイムスタンプを含める
setopt prompt_subst       # プロンプトで変数展開する
setopt auto_pushd         # cd で自動的に pushd する
setopt append_history     # 履歴ファイルは追記にする
setopt auto_list          # 自動的に候補一覧を表示
setopt list_packed        # 補完はできるだけ詰める
setopt auto_menu          # Tabキーで次々補完候補を出す
setopt auto_param_keys    # 変数名を補完する
setopt auto_param_slash   # ディレクトリ名補完後/を付ける
setopt no_beep            # Beep音抑制
setopt hist_ignore_dups   # 連続する同一コマンドを履歴登録しない
setopt hist_no_store      # historyコマンド自体を履歴登録しない
setopt hist_ignore_space  # スペースで始まるコマンドを履歴登録しない
setopt hist_reduce_blanks # 履歴登録時に空白を切り詰める
setopt hist_verify        # 履歴呼び出し後編集モードにする
setopt magic_equal_subst  # =の後のパス補完を有効にする
setopt mark_dirs          # ファイル名補完がディレクトリにマッチしたら/を付ける
setopt print_eight_bit    # 日本語サポート用。8-bit文字を印字する。
setopt share_history      # zshプロセス間で履歴を共有する
setopt no_flow_control    # C-s/C-qを無効化する
setopt pushd_minus        # pushd補完の+/-の意味を入れ替える
setopt nomatch            # ワイルドカード展開失敗をエラー扱いにする

#------------------------------------------------------------
# Shell history
#
HISTFILE=~/.zhistory
HISTSIZE=16384
SAVEHIST=16384
LISTMAX=0

#------------------------------------------------------------
# Zsh plugins
#
autoload -Uz compinit; compinit

#------------------------------------------------------------
# Aliases
#

# ls
if [[ "$(uname)" != "Darwin" ]]; then
  alias ls='ls -F --color=auto'
  alias  l='ls -glF --color=auto'
  alias la='ls -alhF --color=auto'
  alias l1='ls -1F --color=auto'
  alias sl=ls
fi

# exit
if [[ $ESHLVL -gt 1 ]]; then
  alias :q='exit'
elif [[ -n "$TMUX" ]]; then
  alias :q='echo "Type '"'"'exit'"'"' to close terminal"'
else
  alias :q='echo "Type '"'"'exit'"'"' to exit"'
fi
alias :q!='exit'

# ps
alias ph='echo "USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"'
alias pm='ph; ps aux | grep $USER'
alias pt='ph; ps aux | grep " ${tty} "'

# cd
alias  cd-='cd -'
alias cd..='cd ..'
alias  cd1='cd ..'
alias  cd2='cd ../..'
alias  cd3='cd ../../..'
alias  cd4='cd ../../../..'
alias  cd5='cd ../../../../..'
alias  cd6='cd ../../../../../..'
alias  cd7='cd ../../../../../../..'
alias  cd8='cd ../../../../../../../..'
alias  cd9='cd ../../../../../../../../..'
mkcd() { mkdir -p $*; cd $* }

# vim
alias vp='vim -p'

# grep
alias grep='grep --color'
alias rgrep='grep -R --exclude="*.svn*" --exclude="*.git*"'

# tmux
alias tmux='tmux -2'
alias tm='tmux'
alias tma='tmux attach'

# npm
alias npm-preview='tar -tf $(npm pack | tail -1)'

# man
alias eman='LC_ALL=C man'

#------------------------------------------------------------
# Window title for some terminals
#
function changetitle {
  title=${HOST%%.*}:`pwd | sed s:^$HOME:~:`
  case "$TERM" in
  xterm*|kterm*|rxvt*)
    echo -ne "\033]0;$title\007"
  ;;
  screen*)
    #echo -ne "\033P\033]0;$title\007\033\\"
  ;;
  esac
}
changetitle
function chpwd() { changetitle }

