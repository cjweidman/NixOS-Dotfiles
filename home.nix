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
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cjweidman";
  home.homeDirectory = "/home/cjweidman";

  xdg.enable = true;
  # Put your real files next to home.nix, e.g. ./waybar/config.jsonc and ./waybar/style.css
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source   = ./waybar/style.css;

  xdg.configFile."btop/themes/my4.theme".text = ''
  theme[main_bg]="#000000"
  theme[main_fg]="#d7d7d7"

  theme[title]="#d7d7d7"
  theme[hi_fg]="#ed3d22"
  theme[selected_bg]="#6b6b6b"
  theme[selected_fg]="#d7d7d7"

  theme[inactive_fg]="#6b6b6b"

  theme[proc_misc]="#ed3d22"
  theme[cpu_box]="#6b6b6b"
  theme[mem_box]="#6b6b6b"
  theme[net_box]="#6b6b6b"

  theme[graph_text]="#d7d7d7"
  theme[graph_line]="#ed3d22"
  theme[temp_start]="#6b6b6b"
  theme[temp_mid]="#ed3d22"
  theme[temp_end]="#ed3d22"
  '';


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 28;
  };

  home.packages = with pkgs; [

    # Hyprland ecosystem
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cjweidman/etc/profile.d/hm-session-vars.sh
  #

  # starship
  programs.starship.enable = true;

  # fzf
  programs.fzf.enable = true;

  # zsh
  programs.zsh = {
    enable = true;
    shellAliases = {
      "nixupdate" = ''
        sudo nixos-rebuild switch --flake .
        home-manager switch --flake .
      '';
      ".." = "cd ..";
    };
    initContent = ''
      if [[ -o interactive ]]; then
        fastfetch
      fi
    '';
  };

# btop
programs.btop = {
  enable = true;
  settings = {
    color_theme = "my4";
  };
};

# foot
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

  #hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {

      # MONITOR (repeatable => list of strings)
      monitor = [
        ",3456x2234@120,auto,auto"
      ];

      # ENV (repeatable => list of strings)
      env = [
        "XCURSOR_THEME,capitaine-cursors"
        "XCURSOR_SIZE,28"
      ];

      # PROGRAM VARIABLES
      "$terminal" = "foot";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";

      # AUTOSTART
      exec-once = [
        "waybar"
        "mako"
        "sh -lc 'pgrep -x swww-daemon >/dev/null || swww-daemon'"
        "sh -lc 'swww img ${config.home.homeDirectory}/Pictures/Wallpapers/blkOS_WP1.png --transition-type none'"
      ];

      # LOOK & FEEL (sections => attrsets)
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
          "col.active_border" = "rgba(d7d7d7ff)";
          "col.inactive_border" = "rgba(6b6b6bff)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        active_opacity = 0.95;
        inactive_opacity = 0.8;

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          vibrancy = 0.1696;
        };
      };

      # ANIMATIONS (repeatable => list of strings)
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global,1,10,default"
          "border,1,5.39,easeOutQuint"
          "windows,1,4.79,easeOutQuint"
          "windowsIn,1,4.1,easeOutQuint,popin 87%"
          "windowsOut,1,1.49,linear,popin 87%"
          "fadeIn,1,1.73,almostLinear"
          "fadeOut,1,1.46,almostLinear"
          "fade,1,3.03,quick"
          "layers,1,3.81,easeOutQuint"
          "layersIn,1,4,easeOutQuint,fade"
          "layersOut,1,1.5,linear,fade"
          "fadeLayersIn,1,1.79,almostLinear"
          "fadeLayersOut,1,1.39,almostLinear"
          "workspaces,1,1.94,almostLinear,fade"
          "workspacesIn,1,1.21,almostLinear,fade"
          "workspacesOut,1,1.94,almostLinear,fade"
          "zoomFactor,1,7,quick"
        ];
      };

      # WINDOW MODES (sections => attrsets)
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;
        sensitivity = 0.0;

        touchpad = {
          natural_scroll = false;
        };
      };

      # BINDS (repeatable => list of strings)
      "$mainMod" = "ALT";

      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        # "bind = $mainMod, S, togglespecialworkspace, magic"
        # "bind = $mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        # "bind = $mainMod, mouse_down, workspace, e+1"
        # "bind = $mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        # Requires playerctl
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
      ];

      windowrulev2 = [
        # Fix some dragging issues with XWayland
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"

        # hyprland-run placement
        "float, class:^(hyprland-run)$"
        "move 20 100%-120, class:^(hyprland-run)$"
      ];
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "capitaine-cursors";
    XCURSOR_SIZE = "24";
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
