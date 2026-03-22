{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.cava;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.cava.enable;

  # cava gradient: colors go from index 1 (quiet) to 8 (loud)
  # We use a progression from teal to mauve to red
  gradient = [
    p.teal.hex
    p.sky.hex
    p.blue.hex
    p.sapphire.hex
    p.mauve.hex
    p.pink.hex
    p.peach.hex
    p.red.hex
  ];
in

{
  options.themes.cava = themesLib.mkThemeOption { name = "cava"; };

  config = lib.mkIf enable {

    programs.cava.settings.color = {
      background = p.base.hex;
      foreground = p.text.hex;
      gradient = 1;
      gradient_color_1 = builtins.elemAt gradient 0;
      gradient_color_2 = builtins.elemAt gradient 1;
      gradient_color_3 = builtins.elemAt gradient 2;
      gradient_color_4 = builtins.elemAt gradient 3;
      gradient_color_5 = builtins.elemAt gradient 4;
      gradient_color_6 = builtins.elemAt gradient 5;
      gradient_color_7 = builtins.elemAt gradient 6;
      gradient_color_8 = builtins.elemAt gradient 7;
    };
  };
}
