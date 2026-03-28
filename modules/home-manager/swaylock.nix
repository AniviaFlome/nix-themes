{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.swaylock;
  theme = config.themes.theme;
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

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.swaylock.settings = {
          # Colors — swaylock expects hex WITHOUT '#'
          color = sh p.base;
          inside-color = sh p.base;
          inside-clear-color = sh p.base;
          inside-caps-lock-color = sh p.base;
          inside-ver-color = sh p.base;
          inside-wrong-color = sh p.base;

          ring-color = lib.mkDefault (sh p.overlay0);
          ring-clear-color = accentColor;
          ring-caps-lock-color = lib.mkDefault (sh p.yellow);
          ring-ver-color = sh p.blue;
          ring-wrong-color = lib.mkDefault (sh p.red);

          key-hl-color = lib.mkDefault accentColor;
          bs-hl-color = lib.mkDefault (sh p.red);
          caps-lock-key-hl-color = lib.mkDefault (sh p.yellow);
          caps-lock-bs-hl-color = lib.mkDefault (sh p.red);

          line-uses-ring = true;
          separator-color = "00000000";

          text-color = sh p.text;
          text-clear-color = lib.mkDefault (sh p.text);
          text-caps-lock-color = lib.mkDefault (sh p.text);
          text-ver-color = lib.mkDefault (sh p.text);
          text-wrong-color = lib.mkDefault (sh p.text);
        };
      }

      # catppuccin/swaylock uses different colors for several settings
      (lib.mkIf (theme == "catppuccin") {
        programs.swaylock.settings = {
          ring-color = sh p.surface0;
          ring-caps-lock-color = sh p.peach;
          ring-wrong-color = sh p.maroon;

          key-hl-color = sh p.green;
          bs-hl-color = sh p.rosewater;
          caps-lock-key-hl-color = sh p.green;
          caps-lock-bs-hl-color = sh p.rosewater;

          text-clear-color = sh p.rosewater;
          text-caps-lock-color = sh p.peach;
          text-ver-color = sh p.blue;
          text-wrong-color = sh p.maroon;
        };
      })
    ]
  );
}
