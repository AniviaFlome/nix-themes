{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.xfce4-terminal;
  p = config.themes.palette;
  ansi = p.ansi;
in

{
  options.themes.xfce4-terminal = themesLib.mkThemeOption { name = "xfce4-terminal"; };

  config = lib.mkIf cfg.enable {

    xfconf.settings.xfce4-terminal = {
      color-background = p.base.hex;
      color-foreground = p.text.hex;
      color-cursor = p.rosewater.hex;
      color-selection-background = p.surface2.hex;
      color-selection-foreground = p.text.hex;
      color-bold = p.text.hex;
      # 16 ANSI colors: 8 normal + 8 bright, semicolon separated
      color-palette = lib.concatStringsSep ";" [
        ansi.black.normal.hex
        ansi.red.normal.hex
        ansi.green.normal.hex
        ansi.yellow.normal.hex
        ansi.blue.normal.hex
        ansi.magenta.normal.hex
        ansi.cyan.normal.hex
        ansi.white.normal.hex
        ansi.black.bright.hex
        ansi.red.bright.hex
        ansi.green.bright.hex
        ansi.yellow.bright.hex
        ansi.blue.bright.hex
        ansi.magenta.bright.hex
        ansi.cyan.bright.hex
        ansi.white.bright.hex
      ];
    };
  };
}
