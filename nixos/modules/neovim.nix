{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    initLua = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.shiftwidth = 4
      vim.opt.clipboard:append("unnamedplus")
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_complete_close_braces = 1
      vim.g.vimtex_quickfix_ignore_filters = {
        'Underfull',
        'Overfull',
      }
    '';
    plugins = with pkgs.vimPlugins; [ 
      vimtex
      vim-nix
      blink-cmp
      blink-cmp-latex
    ];
  };
}
