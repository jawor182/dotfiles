#            _              
#   _______| |__  _ __ ___ 
#  |_  / __| '_ \| '__/ __|
#   / /\__ \ | | | | | (__ 
#  /___|___/_| |_|_|  \___|
#  
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

export MANPAGER="$EDITOR +Man!"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"
setopt share_history
setopt inc_append_history
export FUNCNEST=1000000

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump
_comp_options+=(globdots)
autoload -U zsh-autosuggestions
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

yazii() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

fdf(){
    find $HOME/dotfiles/ -path "*/.git/*" -prune -o -type f -print | \
    fzf -e --bind "enter:become(nvim {})"
}

snc(){
    shortcuts ; source $XDG_CONFIG_HOME/zsh/.zshrc ; xset r rate 300 60 ; [ "$XDG_SESSION_TYPE" = "x11" ] && xrdb -m $XRESOURCES 
}

mansplain(){
    man -k . | fzf -e | cut -d' '  -f1 | xargs -r man
}

autoload -Uz add-zsh-hook

function set-title-preexec {
    if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
        if [[ $(xdotool getwindowfocus getwindowname 2>/dev/null) != "spterm" ]]; then
            print -Pn "\e]0;${(q)1}\e\\"
        fi
    else
          print -Pn "\e]2;${(q)1}\a"
    fi
}

function set-title-precmd {
     if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
         if [[ $(xdotool getwindowfocus getwindowname 2>/dev/null) != "spterm" ]]; then
             print -Pn "\e]0;%(1j,%j job%(2j|s|); ,)%~\e\\"
         fi
     else
           print -Pn "\e]2;%(1j,%j job%(2j|s|); ,)%~\a"
     fi
}

add-zsh-hook preexec set-title-preexec
add-zsh-hook precmd set-title-precmd

function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

source $XDG_CONFIG_HOME/shell/shortcutsrc
source $XDG_CONFIG_HOME/shell/aliasrc

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
