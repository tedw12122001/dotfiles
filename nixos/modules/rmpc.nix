{ ... }:

{
  programs.rmpc = {
    enable = true;
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
