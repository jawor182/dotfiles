if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    alias v="vim"
    alias n="nvim"
    alias b="btop"
    alias z="zellij"
    alias y="yazi"
    alias t="tmux"
    alias dev="npm run dev"
    alias update="sudo pacman -Syu && yay -Syu && flatpak update"
    alias cat="bat"
    starship init fish | source
    # fzf
    set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
end
