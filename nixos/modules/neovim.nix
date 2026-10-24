{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    initLua = ''
      vim.keymap.set("n", "j", "gj", { silent = true })
      vim.keymap.set("n", "k", "gk", { silent = true }) 

      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.shiftwidth = 4
      vim.opt.wrap = true
      vim.opt.linebreak = true
      vim.opt.breakindent = true
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
