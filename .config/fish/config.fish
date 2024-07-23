if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    alias v="vim"
    alias n="nvim"
    alias b="btop"
    alias z="zellij"
    starship init fish | source
end
