{ ... }: 

{
  programs.rmpc = {
    enable = true;
  };

    programs.mpv = {
	enable = true;
	config = {
	    profile = "fast";
	    force-window = "immediate";
	    volume = 75;
	};
    };
    
  services.mpd = {
    enable = true;
    musicDirectory = "/home/ted/Music";
    extraConfig = ''
        audio_output {
            type          "pipewire"  
            name          "My Output"
            mixer_type    "software"  
        }
    '';
  };
}

