{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.swaylock;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  accent = cfg.accent;
  accentColor = sh p.${accent};
in

{
  options.themes.swaylock = themesLib.mkThemeOption {
    name = "swaylock";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.swaylock.settings = {
      # Colors — swaylock expects hex WITHOUT '#'
      color = sh p.base;
      inside-color = sh p.base;
      inside-clear-color = sh p.base;
      inside-caps-lock-color = sh p.base;
      inside-ver-color = sh p.base;
      inside-wrong-color = sh p.base;

      ring-color = sh p.overlay0;
      ring-clear-color = accentColor;
      ring-caps-lock-color = sh p.yellow;
      ring-ver-color = sh p.blue;
      ring-wrong-color = sh p.red;

      key-hl-color = accentColor;
      bs-hl-color = sh p.red;
      caps-lock-key-hl-color = sh p.yellow;
      caps-lock-bs-hl-color = sh p.red;

      line-uses-ring = true;
      separator-color = "00000000";

      text-color = sh p.text;
      text-clear-color = sh p.text;
      text-caps-lock-color = sh p.text;
      text-ver-color = sh p.text;
      text-wrong-color = sh p.text;
    };
  };
}
