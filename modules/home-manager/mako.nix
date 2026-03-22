{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.mako;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.mako = themesLib.mkThemeOption {
    name = "mako";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    services.mako.settings = {
      background-color = p.base.hex;
      text-color = p.text.hex;
      border-color = accentColor;
      progress-color = "over ${p.surface0.hex}";
    };
  };
}
