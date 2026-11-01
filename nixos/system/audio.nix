{ pkgs, ... }:

{
security.rtkit.enable = true;
services.pipewire = { 
    enable             = true;
    alsa.enable        = true;
    alsa.support32Bit  = true; 
    pulse.enable       = true;
    jack.enable        = true;
    wireplumber.enable = true;
    extraConfig.jack."92-force-quantum" = {
        "jack.properties" = {
            "node.lock-quantum"  = true;
            "node.force-quantum" = 64;
        };
    };
};

security.pam.loginLimits = [{ domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }];
environment.variables = let   # Allow DAW plugins
    makePluginPath = format:
        (pkgs.lib.makeSearchPath format [
            "$HOME/.nix-profile/lib"
            "/run/current-system/sw/lib"
            "/etc/profiles/per-user/$USER/lib"
      ]) + ":$HOME/.${format}";
    in {
        LV2_PATH  = makePluginPath "lv2";
        VST3_PATH = makePluginPath "vst3";
        CLAP_PATH = makePluginPath "clap";
    };
}
