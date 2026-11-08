# Environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less
set -gx MANPAGER less
set -gx BROWSER librewolf

# XDG and misc
set -gx XCURSOR_PATH $HOME/.local/share/icons
set -gx GNUPGHOME $HOME/.local/share/gnupg
set -gx ODIN_ROOT "$HOME/.local/bin/Odin/"

fish_add_path -g $HOME/.local/bin/

if status is-interactive
    # Disable greeting
    set fish_greeting

    # Zoxide (replaces cd)
    zoxide init fish --cmd cd | source
end
