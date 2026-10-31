{pkgs, config, ...}: 

{
programs.nixvim = {
    enable = true;
    opts = {
	number = true;
	relativenumber = true;
	shiftwidth = 4;
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
		"You have requested"
		];
	    };
	};
	treesitter = {
	    enable = true;
	    highlight.enable = true;
	    indent.enable = true;
	    grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
		nix
	    ];
	};
	lsp = {
	    enable = true;
	    servers.nixd.enable = true;
	};
	lexima = {
	    enable = true;
	    settings = {
		enable_basic_rules = 1;
	    };
	};
	airline = {
	    enable = true;
	};
    };
    extraConfigVim = ''
	call lexima#add_rule({
	\ 'char': '{',
	\ 'input': '{};<Left><Left>',
	\ 'filetype': 'nix'
	\ })
    '';
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
