{ ... }:

{
  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
          config.bind('j', 'scroll-px 0 150')
          config.bind('k', 'scroll-px 0 -150')
          config.bind('<M>', 'hint links spawn --detach mpv {hint-url}')
      '';
    settings = {
      content.blocking.method = "adblock";
      content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt"
        "https://easylist.to/easylist/easyprivacy.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt"
      ];
    };
    
  };
}
