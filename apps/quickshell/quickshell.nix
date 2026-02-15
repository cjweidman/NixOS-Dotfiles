{ config, pkgs, ... }:

{
  xdg.configFile."quickshell/overview".source =
    pkgs.fetchFromGitHub {
      owner = "Shanu-Kumawat";
      repo  = "quickshell-overview";
      rev   = "main";
      hash  = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
}
