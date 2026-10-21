{ ... }:

{
  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
          config.bind('j', 'scroll-px 0 150')
          config.bind('k', 'scroll-px 0 -150')
          config.bind('<M>', 'hint links spawn --detach mpv {hint-url}')
      '';
  };
}
