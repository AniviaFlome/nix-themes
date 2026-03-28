{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.cava;
  theme = config.themes.theme;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.cava.enable;
in

{
  options.themes.cava = themesLib.mkThemeOption { name = "cava"; };

  config = lib.mkIf enable (
    lib.mkMerge [
      {
        # cava gradient: colors go from index 1 (quiet) to 8 (loud)
        programs.cava.settings.color = {
          background = p.base.hex;
          foreground = p.text.hex;
          gradient = 1;
          gradient_color_1 = p.teal.hex;
          gradient_color_2 = p.sky.hex;
          gradient_color_3 = lib.mkDefault p.blue.hex;
          gradient_color_4 = lib.mkDefault p.sapphire.hex;
          gradient_color_5 = p.mauve.hex;
          gradient_color_6 = p.pink.hex;
          gradient_color_7 = lib.mkDefault p.peach.hex;
          gradient_color_8 = p.red.hex;
        };
      }

      # catppuccin/cava swaps sapphire/blue (pos 3/4) and uses maroon at pos 7
      (lib.mkIf (theme == "catppuccin") {
        programs.cava.settings.color = {
          gradient_color_3 = p.sapphire.hex;
          gradient_color_4 = p.blue.hex;
          gradient_color_7 = p.maroon.hex;
        };
      })
    ]
  );
}
