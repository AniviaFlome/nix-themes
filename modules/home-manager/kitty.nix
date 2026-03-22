{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.kitty;
  palette = config.themes.palette;
  ansi = palette.ansi;
in

{
  options.themes.kitty = themesLib.mkThemeOption { name = "kitty"; };

  config = lib.mkIf cfg.enable {

    programs.kitty.settings = {
      background = palette.base.hex;
      foreground = palette.text.hex;
      selection_background = palette.surface2.hex;
      selection_foreground = palette.text.hex;
      url_color = palette.blue.hex;
      cursor = palette.rosewater.hex;
      cursor_text_color = palette.base.hex;
      active_tab_background = palette.mauve.hex;
      active_tab_foreground = palette.base.hex;
      inactive_tab_background = palette.surface1.hex;
      inactive_tab_foreground = palette.subtext0.hex;
      active_border_color = palette.mauve.hex;
      inactive_border_color = palette.surface1.hex;
      # ANSI colors
      color0 = ansi.black.normal.hex;
      color8 = ansi.black.bright.hex;
      color1 = ansi.red.normal.hex;
      color9 = ansi.red.bright.hex;
      color2 = ansi.green.normal.hex;
      color10 = ansi.green.bright.hex;
      color3 = ansi.yellow.normal.hex;
      color11 = ansi.yellow.bright.hex;
      color4 = ansi.blue.normal.hex;
      color12 = ansi.blue.bright.hex;
      color5 = ansi.magenta.normal.hex;
      color13 = ansi.magenta.bright.hex;
      color6 = ansi.cyan.normal.hex;
      color14 = ansi.cyan.bright.hex;
      color7 = ansi.white.normal.hex;
      color15 = ansi.white.bright.hex;
    };
  };
}
