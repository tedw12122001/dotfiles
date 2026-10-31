{ ... }:

{
programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = {
	de        = "trans de:";
	nixrb     = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos";
	wn        = "tmux new-session -d -s whitenoise 'whitenoise --volume 10'";
	refreshusb = "find Documents/TeX/Lessons -iname '*.pdf' -exec cp -n {} /run/media/ted/0067-EDB6/ \\;";
	plat = "nvim ~/Documents/TeX/Platitudes/Platitudes.tex";
    };
    siteFunctions = {
	newbeamer = ''
	    mkdir "$1" && cp ~/Documents/TeX/Defaults/Beamer.tex ./"$1"/"$1".tex && nvim ./"$1"/"$1".tex
	'';
	newdoc = ''
	    mkdir "$1" && 
	    cp ~/Documents/TeX/Defaults/Doc.tex ./"$1"/"$1".tex && 
	    nvim ./"$1"/"$1".tex
	'';
    };

};
}
