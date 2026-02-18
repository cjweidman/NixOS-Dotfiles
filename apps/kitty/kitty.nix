{ config, pkgs, ... }:

{
    programs.kitty = {
        enable = true;

        font = {
            name = "JetBrainsMono Nerd Font";
            size = 12;
        };

        settings = {
            # Padding
            window_padding_width = 12;

            # Cursor trail
            cursor_trail = 3;
            cursor_trail_start_threshold = 0;
            cursor_trail_decay = 0.1;
        };
    };

}
