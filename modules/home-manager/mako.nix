{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.mako;
  theme = config.themes.theme;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.mako = themesLib.mkThemeOption {
    name = "mako";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        services.mako.settings = {
          background-color = p.base.hex;
          text-color = p.text.hex;
          border-color = accentColor;
          progress-color = "over ${p.surface0.hex}";
        };
      }

      # catppuccin/mako uses peach for high-urgency notifications
      (lib.mkIf (theme == "catppuccin") {
        services.mako.settings."urgency=high" = {
          border-color = p.peach.hex;
        };
      })
    ]
  );
}
