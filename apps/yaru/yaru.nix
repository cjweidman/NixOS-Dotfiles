{ pkgs, ... }:
{
  gtk = {
    enable = true;

    theme = {
      name = "Yaru";
      package = pkgs.yaru-theme;
    };

    iconTheme = {
      name = "Yaru";
      package = pkgs.yaru-theme;
    };
  };
}
