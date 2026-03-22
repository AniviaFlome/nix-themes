{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.polybar;
  p = config.themes.palette;
in

{
  options.themes.polybar = themesLib.mkThemeOption { name = "polybar"; };

  config = lib.mkIf cfg.enable {

    services.polybar.extraConfig = ''
      [colors]
      rosewater = ${p.rosewater.hex}
      flamingo = ${p.flamingo.hex}
      pink = ${p.pink.hex}
      mauve = ${p.mauve.hex}
      red = ${p.red.hex}
      maroon = ${p.maroon.hex}
      peach = ${p.peach.hex}
      yellow = ${p.yellow.hex}
      green = ${p.green.hex}
      teal = ${p.teal.hex}
      sky = ${p.sky.hex}
      sapphire = ${p.sapphire.hex}
      blue = ${p.blue.hex}
      lavender = ${p.lavender.hex}
      text = ${p.text.hex}
      subtext1 = ${p.subtext1.hex}
      subtext0 = ${p.subtext0.hex}
      overlay2 = ${p.overlay2.hex}
      overlay1 = ${p.overlay1.hex}
      overlay0 = ${p.overlay0.hex}
      surface2 = ${p.surface2.hex}
      surface1 = ${p.surface1.hex}
      surface0 = ${p.surface0.hex}
      base = ${p.base.hex}
      mantle = ${p.mantle.hex}
      crust = ${p.crust.hex}
      transparent = #00000000
    '';
  };
}
