{ pkgs, ... }: 

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

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

    globals = {
      vimtex_view_method = "zathura";
      vimtex_compiler = "latexmk";
      vimtex_complete_enabled = 1;
      vimtex_complete_close_braces = 1;
      vimtex_quickfix_open_on_warning = 0;
      vimtex_quickfix_ignore_filters = [
        "Underfull"
        "Overfull"
      ];
    };

    plugins = {
      vimtex.enable = true;

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; 
        };
      };
    };

}
