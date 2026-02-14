{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete;
      }
    ];

    shellAliases = {
      nixupdate = ''
        sudo nixos-rebuild switch --flake ~/.dotfiles
        home-manager switch --flake ~/.dotfiles
      '';
    };

    initContent = ''
      if [[ -o interactive ]]; then
        fastfetch
      fi
    '';
  };
}
