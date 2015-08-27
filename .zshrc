PROMPT=''
PROMPT=$PROMPT'%B%F{green}%~%(4~|
|)%f%b '
PROMPT=$PROMPT'%(?.%#.%F{red}%? %#%f) '

# Report any time longer than 10s
REPORTTIME=10

# bind C-x C-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

export AM=am004872
export PATH=$PATH:~/.bin
export EDITOR=vim

setopt AUTO_CD EXTENDED_HISTORY IGNORE_EOF

if which colormake &>/dev/null
then alias make="colormake -j$(nproc)"
else alias make="make -j$(nproc)"
fi

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
    GITROOT=$(git rev-parse --show-toplevel)

    if [ -d "$1" ]
    then cd "$1"
    elif [ ! -e "$1" ] && [ -n "$GITROOT" ] && [ -e "$GITROOT/$1" ]
    then "$EDITOR" "$GITROOT/$1"
    else "$EDITOR" "$@"
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
    D="$(git rev-parse --show-toplevel)" && pushd "$D"
}

function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%75>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\e]2;$a $2\a" # plain xterm title
    print -Pn "\ek$a\e\\"      # screen title (in ^A")
    print -Pn "\e_$2   \e\\"   # screen location
    ;;
  xterm*|rxvt*)
    print -Pn "\e]2;$a $2\a" # plain xterm title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "(%75<...<%~)"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "(%75<...<%~)"
}

