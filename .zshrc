alias nixrb="sudo nixos-rebuild switch --flake ~/dotfiles/nixos"

alias hmrb="home-manager switch --flake ~/dotfiles/nixos"

alias nixconf="code ~/dotfiles/nixos/configuration.nix" 

alias hmconf="code ~/dotfiles/nixos/home.nix"

alias hyprconf="code ~/dotfiles/hypr/hyprland.lua"

alias onbattery='hyprctl eval '\''hl.monitor({
    output = "eDP-1",
    mode = "3072x1920@60",
    position = "0x0",
    scale = 2
})'\'' && powerprofilesctl set power-saver'

alias oncharge='hyprctl eval '\''hl.monitor({
    output = "eDP-1",
    mode = "3072x1920@165",
    position = "0x0",
    scale = 2
})'\'' && powerprofilesctl set balanced'