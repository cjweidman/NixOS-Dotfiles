{ config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    shellAliases = {
      "nixupdate" = ''
        sudo nixos-rebuild switch --flake .
        home-manager switch --flake .
      '';
    };
    initContent = ''
      if [[ -o interactive ]]; then
        fastfetch
      fi
    '';
  };

}