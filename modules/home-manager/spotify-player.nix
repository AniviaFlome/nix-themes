{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.spotify-player;
  p = config.themes.palette;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";
in

{
  options.themes.spotify-player = themesLib.mkThemeOption { name = "spotify-player"; };

  config = lib.mkIf cfg.enable {

    programs.spotify-player = {
      settings.theme = themeName;

      themes = [
        {
          name = themeName;
          palette = {
            background = p.base.hex;
            foreground = p.text.hex;
            black = p.base.hex;
            blue = p.blue.hex;
            cyan = p.sky.hex;
            green = p.green.hex;
            magenta = p.mauve.hex;
            red = p.red.hex;
            white = p.text.hex;
            yellow = p.yellow.hex;
            bright_black = p.base.hex;
            bright_blue = p.blue.hex;
            bright_cyan = p.sky.hex;
            bright_green = p.green.hex;
            bright_magenta = p.mauve.hex;
            bright_red = p.red.hex;
            bright_white = p.text.hex;
            bright_yellow = p.yellow.hex;
          };
          component_style = {
            selection = {
              bg = p.surface0.hex;
              modifiers = [ "Bold" ];
            };
            block_title = {
              fg = "Magenta";
            };
            playback_track = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            playback_album = {
              fg = "Yellow";
            };
            playback_metadata = {
              fg = "Blue";
            };
            playback_progress_bar = {
              bg = p.surface0.hex;
              fg = "Green";
            };
            current_playing = {
              fg = "Green";
              modifiers = [ "Bold" ];
            };
            page_desc = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            table_header = {
              fg = "Blue";
            };
            border = { };
            playback_status = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            playback_artists = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            playlist_desc = {
              fg = p.subtext0.hex;
            };
          };
        }
      ];
    };
  };
}
