{ pkgs, ... }:
{
  gtk = {
    enable = true;

    theme = {
      name = "Yaru-dark";
      package = pkgs.yaru-theme;
    };

    iconTheme = {
      name = "Yaru";
      package = pkgs.yaru-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.enable = true;
  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "Yaru-dark";
    icon-theme = "Yaru";
    color-scheme = "prefer-dark";
  };
}
