{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.tty;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  enable = cfg.enable && config.console.enable;
in

{
  options.themes.tty = themesLib.mkThemeOption { name = "tty"; };

  config = lib.mkIf enable {

    # console.colors expects 16 hex strings without '#'
    # Order: 8 normal colors (black, red, green, yellow, blue, magenta, cyan, white)
    # then 8 bright variants
    console.colors = map sh [
      p.ansi.black.normal
      p.ansi.red.normal
      p.ansi.green.normal
      p.ansi.yellow.normal
      p.ansi.blue.normal
      p.ansi.magenta.normal
      p.ansi.cyan.normal
      p.ansi.white.normal
      p.ansi.black.bright
      p.ansi.red.bright
      p.ansi.green.bright
      p.ansi.yellow.bright
      p.ansi.blue.bright
      p.ansi.magenta.bright
      p.ansi.cyan.bright
      p.ansi.white.bright
    ];
  };
}
