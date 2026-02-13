{ config, pkgs, ... }:

let
  pywalRepo = pkgs.fetchFromGitHub {
    owner = "dylanaraps";
    repo  = "pywal";
    rev   = "236aa48e741ff8d65c4c3826db2813bf2ee6f352";
    hash  = "sha256-La6ErjbGcUbk0D2G1eriu02xei3Ki9bjNme44g4jAF0=";
  };

  pywalExtra = pkgs.fetchFromGitHub {
    owner = "eylles";
    repo  = "pywal-extra";
    rev   = "491a8b721247e912b38d3be1af193d48f35ce56a";
    hash  = "sha256-yOUgtChMIsnquQZdX+5kmg0PVLzhOoXHB0YuVXRKb60=";
  };

  walColorSchemes = pkgs.runCommand "wal-colorschemes" {} ''
    set -euo pipefail
    mkdir -p "$out"

    # copy contents of colorschemes (dark/, light/, etc.) into $out
    cp -a ${pywalRepo}/pywal/colorschemes/. "$out/"

    mkdir -p "$out/dark"
    cat > "$out/dark/bbOS.json" <<'EOF'
    {
      "wallpaper": "",
      "alpha": "100",

      "special": {
        "background": "#000000",
        "foreground": "#d7d7d7",
        "cursor": "#d7d7d7"
      },

      "colors": {
        "color0":  "#000000",
        "color1":  "#bc2020",
        "color2":  "#989719",
        "color3":  "#d79920",
        "color4":  "#458588",
        "color5":  "#b16286",
        "color6":  "#689d6a",
        "color7":  "#d7d7d7",
        "color8":  "#6b6b6b",
        "color9":  "#ed3d22",
        "color10": "#b9bb25",
        "color11": "#fabd2e",
        "color12": "#83a598",
        "color13": "#d3859b",
        "color14": "#8dc07c",
        "color15": "#ffffff"
      }
    }
EOF
  '';

in
{
  programs.pywal = {
    enable  = true;
    package = pkgs.pywal16;
  };

  # enables: wal --theme base16-...
  xdg.configFile."wal/colorschemes" = {
    source = walColorSchemes;
    force = true;
  };

  # enables template-driven outputs in ~/.cache/wal/ for apps
  xdg.configFile."wal/templates".source = "${pywalExtra}/templates";
}
