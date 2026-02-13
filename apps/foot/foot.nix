{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=9";
        pad = "30x30";
      };
    };

    extraConfig = ''
      include=~/.cache/wal/colors-foot.ini
    '';
  };
}