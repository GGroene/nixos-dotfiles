set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'
fish_vi_key_bindings

set -gx QT_QPA_PLATFORMTHEME qt6ct
source /usr/share/cachyos-fish-config/cachyos-config.fish

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

starship init fish | source
zoxide init fish | source

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
