{ config, pkgs, ... }:

{
  home.username = "cjweidman";
  home.homeDirectory = "/home/cjweidman";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  home.stateVersion = "25.11"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  #######################################

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 28;
  };

    home.sessionVariables = {
    XCURSOR_THEME = "capitaine-cursors";
    XCURSOR_SIZE = "24";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  home.packages = with pkgs; [

    # Hyprland Ecosystem
    pywal16
    pywalfox-native
    foot
    xfce.thunar
    rofi
    waybar
    mako
    swww
    hypridle
    hyprlock
    hyprpicker
    hyprshot
    capitaine-cursors
    glib
    gsettings-desktop-schemas
    yaru-theme
    qt6.qtwayland
    qt6.qtsvg
    qt6.qtimageformats
    qt6.qtmultimedia
    qt6.qt5compat

    # Apps
    bitwarden-desktop
    vesktop
    obsidian
    firefox
    vscode

    # Audio/visual/monitoring
    cava
    pavucontrol
    cliphist
    btop

    # Shell/tools
    zsh-autocomplete
    zsh-autosuggestions
    nano
    fzf
    starship
    yazi
    libnotify
    networkmanagerapplet
    adwaita-icon-theme
    hicolor-icon-theme
    p7zip

  ];

  imports = [
    ./apps/waybar/waybar.nix
    ./apps/starship/starship.nix
    ./apps/fzf/fzf.nix
    ./apps/zsh/zsh.nix
    ./apps/btop/btop.nix
    ./apps/foot/foot.nix
    ./apps/hyprland/hyprland.nix
    ./apps/pywal/pywal.nix
    ./apps/rofi/rofi.nix
    ./apps/vesktop/vesktop.nix
    ./apps/mako/mako.nix
    ./apps/yaru/yaru.nix
    ./apps/quickshell/quickshell.nix
  ];

  home.file = {
    
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}