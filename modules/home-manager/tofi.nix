{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.tofi;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.tofi = themesLib.mkThemeOption {
    name = "tofi";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.tofi.settings = {
      background-color = p.base.hex;
      outline-color = p.base.hex;
      border-color = accentColor;
      text-color = p.text.hex;
      prompt-color = accentColor;
      selection-color = accentColor;
      selection-background = p.surface1.hex;
      selection-background-padding = "0, 4";
    };
  };
}
