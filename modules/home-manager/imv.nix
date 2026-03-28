{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.imv;
  theme = config.themes.theme;
  p = config.themes.palette;
in

{
  options.themes.imv = themesLib.mkThemeOption { name = "imv"; };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.imv.settings.options = {
          background = themesLib.stripHash p.base;
          overlay_background_color = lib.mkDefault (themesLib.stripHash p.surface0);
          overlay_text_color = themesLib.stripHash p.text;
        };
      }

      # catppuccin/imv uses crust for overlay background (vs surface0)
      (lib.mkIf (theme == "catppuccin") {
        programs.imv.settings.options.overlay_background_color = themesLib.stripHash p.crust;
      })
    ]
  );
}
