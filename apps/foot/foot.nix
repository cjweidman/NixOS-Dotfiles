{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "~/.cache/wal/colors-foot.ini";
        font = "JetBrainsMono Nerd Font:size=9";
        pad = "30x30";
      };
    };
  };
}
