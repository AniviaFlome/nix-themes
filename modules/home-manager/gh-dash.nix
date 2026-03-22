{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.gh-dash;
  p = config.themes.palette;
  accent = cfg.accent;
in

{
  options.themes.gh-dash = themesLib.mkThemeOption {
    name = "gh-dash";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.gh-dash.settings = {
      theme.colors = {
        text = {
          primary = p.text.hex;
          secondary = p.${accent}.hex;
          inverted = p.crust.hex;
          faint = p.subtext1.hex;
          warning = p.yellow.hex;
          success = p.green.hex;
          error = p.red.hex;
        };
        background.selected = p.surface0.hex;
        border = {
          primary = p.${accent}.hex;
          secondary = p.surface1.hex;
          faint = p.surface0.hex;
        };
      };
    };
  };
}
