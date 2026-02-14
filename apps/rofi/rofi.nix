{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
  };

  # pywal template to expose color0..color15
  xdg.configFile."wal/templates/colors-rofi-pywal.rasi".text = ''
    * {
      background: {background};
      foreground: {foreground};

      color0:  {color0};
      color1:  {color1};
      color2:  {color2};
      color3:  {color3};
      color4:  {color4};
      color5:  {color5};
      color6:  {color6};
      color7:  {color7};
      color8:  {color8};
      color9:  {color9};
      color10: {color10};
      color11: {color11};
      color12: {color12};
      color13: {color13};
      color14: {color14};
      color15: {color15};
    }
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modes: "window,run,ssh,drun";
      sorting-method: "normal";
      show-icons: true;
      matching: "regex";
      drun-match-fields: "name";
      display-run: "Menu:";
      display-ssh: "SSH:";
      display-drun: "Apps:";
      display-window: "Windows:";
    }

    @import "${config.home.homeDirectory}/.cache/wal/colors-rofi-pywal.rasi"

    * {
      font: "JetBrainsMono Nerd Font 12";
      background-color: transparent;
      text-color: @foreground;

      margin: 0px;
      padding: 0px;
      spacing: 0px;
    }

    window {
      location: center;
      width: 480;
      y-offset: -20;

      border-radius: 0px;
      border: 1px;
      border-color: @foreground;
      background-color: @background;
    }

    mainbox {
      padding: 12px;
      children: [ inputbar, listview ];
    }

    inputbar {
      border-radius: 0px;
      padding: 8px 16px;
      spacing: 8px;
      children: [ prompt, entry ];

      /* solid 1px divider under search */
      border: 0px 0px 0px 0px;
      border-color: @foreground;
    }

    entry {
      placeholder: "Search";
    }

    listview {
      margin: 12px 0 0;
      columns: 1;
      lines: 8;
      fixed-height: false;
      scrollbar: true;
      border: 0px;
    }

    /* remove zebra striping completely */
    element,
    element normal normal,
    element normal active,
    element normal urgent,
    element alternate normal,
    element alternate active,
    element alternate urgent {
      background-color: @background;
      padding: 8px 16px;
      spacing: 8px;
      border-radius: 0px;
    }

    /* selected row */
    element selected normal,
    element selected active,
    element selected urgent {
      background-color: @color9;
    }

    element-icon {
      size: 1em;
      vertical-align: 0.5;
    }

    element-text {
      text-color: inherit;
    }

    scrollbar {
      width: 2px;
      handle-width: 2px;
      border-radius: 0px;
      background-color: @color8;
      padding: 0;
      border: 0;
    }

    scrollbar handle {
      background-color: @foreground;
      border-radius: 0px;
    }

    message {
      enabled: false;
    }

    textbox {
      enabled: false;
    }

    


  '';
}
