{ pkgs, ... }:

{
environment.systemPackages = [
  (pkgs.stdenv.mkDerivation {
    name = "LaTeD";
    src = ./TeX/styles;
    installPhase = ''
      mkdir -p $out/tex/latex/styles
      cp LaTeD.sty $out/tex/latex/styles/
    '';
  })
];   
}
