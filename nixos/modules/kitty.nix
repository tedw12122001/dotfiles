{ ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      cursor_trail 10
      map ctrl+backspace send_text all \x17
    '';
    keybindings = {
      "ctrl+shift+left" = "no_op";
      "ctrl+shift+right" = "no_op";
    };
  };
}
