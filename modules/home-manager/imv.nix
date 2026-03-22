{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.imv;
  p = config.themes.palette;
in

{
  options.themes.imv = themesLib.mkThemeOption { name = "imv"; };

  config = lib.mkIf cfg.enable {

    programs.imv.settings = {
      options = {
        background = themesLib.stripHash p.base;
        overlay_background_color = themesLib.stripHash p.surface0;
        overlay_text_color = themesLib.stripHash p.text;
      };
    };
  };
}
