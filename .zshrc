#PROMPT='%K{blue}%n@%M%k '
PROMPT=''
PROMPT=$PROMPT'%B%F{green}%~%(4~|
|)%f%b '
PROMPT=$PROMPT'%(?.%#.%F{red}%? %#%f) '

export AM=am004872
export PATH=$PATH:~/.bin
export EDITOR=vim
export SWEEPLOOP_SRC_DIR=/home/wes/sweep_loop/sweeploop_cpu1/src
export DESKTOP_QMAKE=/opt/Qt5.2.0/5.2.0/gcc_64/bin/qmake
export ZYNQ_QMAKE=/opt/Qt/qt-zynq-5.2.0/bin/qmake
export SWEEPLOOP_BUILD=/home/wes/sweep_loop/sweeploop_cpu1/Debug

setopt AUTO_CD EXTENDED_HISTORY IGNORE_EOF

alias ls='ls --color=auto -F -h'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

alias ducks='du -ck -sh ./* | sort -hr | head -n10'

alias mv='mv -i'

alias gs='git status'
alias gd='git diff -p --stat'
alias gdc='gd --cached'
alias gr='git rev-parse --show-toplevel'
alias gl='git lg'
alias gg='git grep -i'

alias miniterm='miniterm.py --lf -q -b 115200'

e() {
    if [ -d "$1" ]
    then cd "$1"
    else vim "$@"
    fi
}

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias killall='killall -I -v -w'

#alias open='xdg-open'
open () {
    xdg-open "$@" &
}

alias tree='tree -hF'

alias info='info --vi-keys'

alias top=htop

export LESS='-iR'

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;34m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[01;36m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[01;32m' \
    man "$@"
}

c() {
    if [[ -d "$1" ]]; then
        cd "$1"
    else
        cd $(dirname "$1")
    fi
}

precmd() { echo -en "\033]0;zsh (${PWD/#$HOME/~})\007" }
preexec() {}
#preexec() { echo -en "\033]0;" ${(q)$1} "(${PWD/#$HOME/~})\007" }

# Set up the prompt
# autoload -Uz promptinit
# promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -z compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

function gitroot() {
    D="$(git rev-parse --show-toplevel)" && cd "$D"
}

