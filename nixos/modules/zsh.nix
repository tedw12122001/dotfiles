{ ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      de = "trans de:";
      nixrb = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos";
      onbattery = "hyprctl eval 'hl.monitor({ output = \"eDP-1\", mode = \"3072x1920@60\", position = \"0x0\", scale = 2 })'";
      oncharge = "hyprctl eval 'hl.monitor({ output = \"eDP-1\", mode = \"3072x1920@165\", position = \"0x0\", scale = 2 })'";
    };
    siteFunctions = {
      latex = ''
        vim "$1.tex" | zathura "$1.pdf"
      '';
    };
  };
}
