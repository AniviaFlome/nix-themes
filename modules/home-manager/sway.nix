{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.sway;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.sway = themesLib.mkThemeOption {
    name = "sway";
    accentSupport = true;
  };

  config = lib.mkIf (cfg.enable && config.wayland.windowManager.sway.enable) {

    wayland.windowManager.sway.config.colors = {
      focused = {
        border = accentColor;
        background = p.base.hex;
        text = p.text.hex;
        indicator = accentColor;
        childBorder = accentColor;
      };
      focusedInactive = {
        border = p.surface1.hex;
        background = p.base.hex;
        text = p.subtext0.hex;
        indicator = p.surface1.hex;
        childBorder = p.surface1.hex;
      };
      unfocused = {
        border = p.surface0.hex;
        background = p.base.hex;
        text = p.subtext0.hex;
        indicator = p.surface0.hex;
        childBorder = p.surface0.hex;
      };
      urgent = {
        border = p.red.hex;
        background = p.base.hex;
        text = p.text.hex;
        indicator = p.red.hex;
        childBorder = p.red.hex;
      };
      placeholder = {
        border = p.overlay0.hex;
        background = p.base.hex;
        text = p.text.hex;
        indicator = p.overlay0.hex;
        childBorder = p.overlay0.hex;
      };
    };
  };
}
