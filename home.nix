{ config, pkgs, ... }:

let
  c0 = "000000"; # background
  c1 = "d7d7d7"; # foreground
  c2 = "6b6b6b"; # muted
  c3 = "ed3d22"; # accent

  pal = [
    c0 c1 c2 c3
    c0 c1 c2 c3
    c0 c1 c2 c3
    c0 c1 c2 c3
  ];
in
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

  home.packages = with pkgs; [

    # Hyprland Ecosystem
    pywal16
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

  ];

  imports = [
    ./apps/waybar/waybar.nix
    ./apps/starship/starship.nix
    ./apps/fzf/fzf.nix
    ./apps/zsh/zsh.nix
    ./apps/btop/btop.nix
    ./apps/foot/foot.nix
    ./apps/hyprland/hyprland.nix
  ];

  home.file = {
    
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}