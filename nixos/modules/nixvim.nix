{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    
#    extraPackages = with pkgs; [
#      zathura
#      texliveFull
#    ];

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      wrap = true;
      linebreak = true;
      breakindent = true;
      clipboard = "unnamedplus";
      spell = true;
      spelllang = [ "en_gb" ];
    };

    plugins = {
      vimtex = {
        enable = true;
        settings = {
          view_method = "zathura";
          compiler = "lualatex";
          complete_enabled = 1;
          complete_close_braces = 1;
          quickfix_open_on_warning = 0;
          quickfix_ignore_filters = [
            "Underfull"
            "Overfull"
          ];
        };
      };

     #lsp = {
     #  enable = true;
     #  servers = {
     #    nil_ls.enable = true; 
     #  };
     #};

      #blink-cmp.enable = true;
    };
  };
}
