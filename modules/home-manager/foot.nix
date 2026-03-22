{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.foot;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  ansi = p.ansi;
in

{
  options.themes.foot = themesLib.mkThemeOption { name = "foot"; };

  config = lib.mkIf cfg.enable {

    programs.foot.settings = {
      colors = {
        background = sh p.base;
        foreground = sh p.text;
        selection-background = sh p.surface2;
        selection-foreground = sh p.text;
        # ANSI 0-7 (normal)
        regular0 = sh ansi.black.normal;
        regular1 = sh ansi.red.normal;
        regular2 = sh ansi.green.normal;
        regular3 = sh ansi.yellow.normal;
        regular4 = sh ansi.blue.normal;
        regular5 = sh ansi.magenta.normal;
        regular6 = sh ansi.cyan.normal;
        regular7 = sh ansi.white.normal;
        # ANSI 8-15 (bright)
        bright0 = sh ansi.black.bright;
        bright1 = sh ansi.red.bright;
        bright2 = sh ansi.green.bright;
        bright3 = sh ansi.yellow.bright;
        bright4 = sh ansi.blue.bright;
        bright5 = sh ansi.magenta.bright;
        bright6 = sh ansi.cyan.bright;
        bright7 = sh ansi.white.bright;
      };
    };
  };
}
