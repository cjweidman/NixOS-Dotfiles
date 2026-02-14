{ config, pkgs, ... }:

{
  xdg.desktopEntries.vesktop = {
    name = "Vesktop";
    exec = "vesktop --use-gl=egl-angle --use-angle=swiftshader %U";
    icon = "vesktop";
    type = "Application";
    categories = [ "Network" "InstantMessaging" "Chat" ];
  };

}
