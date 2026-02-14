{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      # Layout
      padding = "14";
      margin = "10";
      border-size = 1;
      border-radius = 0;

      # Pywal16 colors (Wayland CSS-style @vars)
      background-color = "@background";
      text-color = "@foreground";
      border-color = "@foreground";

      # Optional sensible defaults
      default-timeout = 5000;
      max-icon-size = 48;
      font = "JetBrains Mono 11";
    };
  };
}
