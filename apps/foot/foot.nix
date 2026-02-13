{ config, pkgs, ... }:

{

  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=9";
        pad = "30x30";
        };
      colors = {
        background = c0;
        foreground = c1;
        alpha = 1.0;

        # regular (0–7)
        regular0 = c0;
        regular1 = c0;
        regular2 = c0;
        regular3 = c0;

        regular4 = c2;
        regular5 = c2;
        regular6 = c2;
        regular7 = c2;

        # bright (8–15)
        bright0 = c3;
        bright1 = c3;
        bright2 = c3;
        bright3 = c3;

        bright4 = c1;
        bright5 = c1;
        bright6 = c1;
        bright7 = c1;
      };
    };
  };

}