{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.alacritty;
  theme = config.themes.theme;
  palette = config.themes.palette;
  ansi = palette.ansi;
in

{
  options.themes.alacritty = themesLib.mkThemeOption { name = "alacritty"; };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.alacritty.settings.colors = {
          primary = {
            background = palette.base.hex;
            foreground = palette.text.hex;
            dim_foreground = lib.mkDefault palette.subtext0.hex;
          };

          cursor = {
            text = palette.base.hex;
            cursor = palette.rosewater.hex;
          };

          vi_mode_cursor = {
            text = palette.base.hex;
            cursor = palette.lavender.hex;
          };

          search = {
            matches = {
              foreground = palette.base.hex;
              background = palette.subtext0.hex;
            };
            focused_match = {
              foreground = palette.base.hex;
              background = palette.green.hex;
            };
          };

          hints = {
            start = {
              foreground = palette.base.hex;
              background = palette.yellow.hex;
            };
            end = {
              foreground = palette.base.hex;
              background = palette.subtext0.hex;
            };
          };

          selection = {
            text = palette.base.hex;
            background = palette.rosewater.hex;
          };

          normal = {
            black = ansi.black.normal.hex;
            red = ansi.red.normal.hex;
            green = ansi.green.normal.hex;
            yellow = ansi.yellow.normal.hex;
            blue = ansi.blue.normal.hex;
            magenta = ansi.magenta.normal.hex;
            cyan = ansi.cyan.normal.hex;
            white = ansi.white.normal.hex;
          };

          bright = {
            black = ansi.black.bright.hex;
            red = ansi.red.bright.hex;
            green = ansi.green.bright.hex;
            yellow = ansi.yellow.bright.hex;
            blue = ansi.blue.bright.hex;
            magenta = ansi.magenta.bright.hex;
            cyan = ansi.cyan.bright.hex;
            white = ansi.white.bright.hex;
          };
        };
      }

      # catppuccin/alacritty uses overlay1 for dim_foreground
      (lib.mkIf (theme == "catppuccin") {
        programs.alacritty.settings.colors.primary = {
          dim_foreground = palette.overlay1.hex;
        };
      })
    ]
  );
}
