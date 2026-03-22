{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.starship;
  p = config.themes.palette;
  paletteName = "nix_themes_${config.themes.theme}_${
    builtins.replaceStrings [ "-" ] [ "_" ] config.themes.variant
  }";
in

{
  options.themes.starship = themesLib.mkThemeOption { name = "starship"; };

  config = lib.mkIf cfg.enable {

    programs.starship.settings = {
      palette = paletteName;
      palettes.${paletteName} = {
        # Background scale
        crust = p.crust.hex;
        mantle = p.mantle.hex;
        base = p.base.hex;
        surface0 = p.surface0.hex;
        surface1 = p.surface1.hex;
        surface2 = p.surface2.hex;
        overlay0 = p.overlay0.hex;
        overlay1 = p.overlay1.hex;
        overlay2 = p.overlay2.hex;
        # Foreground scale
        subtext0 = p.subtext0.hex;
        subtext1 = p.subtext1.hex;
        text = p.text.hex;
        # Accents
        rosewater = p.rosewater.hex;
        flamingo = p.flamingo.hex;
        pink = p.pink.hex;
        mauve = p.mauve.hex;
        red = p.red.hex;
        maroon = p.maroon.hex;
        peach = p.peach.hex;
        yellow = p.yellow.hex;
        green = p.green.hex;
        teal = p.teal.hex;
        sky = p.sky.hex;
        sapphire = p.sapphire.hex;
        blue = p.blue.hex;
        lavender = p.lavender.hex;
      };
    };
  };
}
