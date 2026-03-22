{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.fuzzel;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  accent = cfg.accent;
  accentColor = sh p.${accent};
in

{
  options.themes.fuzzel = themesLib.mkThemeOption {
    name = "fuzzel";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    # fuzzel expects colors as RRGGBBaa (hex, no '#', with 2-char alpha suffix)
    programs.fuzzel.settings.colors = {
      background = "${sh p.base}ff";
      text = "${sh p.text}ff";
      match = "${accentColor}ff";
      selection = "${sh p.surface1}ff";
      selection-text = "${sh p.text}ff";
      selection-match = "${accentColor}ff";
      border = "${accentColor}ff";
    };
  };
}
