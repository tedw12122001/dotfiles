{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      wrap = true;
      linebreak = true;
      breakindent = true;
      clipboard = "unnamedplus";
      spell = true;
      spelllang = ["en_gb"];
    };

    plugins = {
      vimtex = {
        enable = true;
        package = pkgs.vimPlugins.vimtex;
	texlivePackage = pkgs.texliveFull;
        settings = {
          view_method = "zathura_simple";
          compiler = "latexmk";
          complete_enabled = 1;
          complete_close_braces = 1;
          quickfix_open_on_warning = 0;
          quickfix_ignore_filters = [
            "Underfull"
            "Overfull"
          ];
        };
      };

      treesitter = {
        enable = true;
        settings.indent.enable = true;
      };

      lsp = {
        enable = true;
        servers.nixd.enable = true;
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = ["alejandra"];
            tex = ["tex-fmt"];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "j";
        action = "gj";
        options = {
          desc = "Move down by visual line";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "k";
        action = "gk";
        options = {
          desc = "Move up by visual line";
          silent = true;
        };
      }
    ];
  };
}
