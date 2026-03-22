{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.zathura;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.zathura = themesLib.mkThemeOption {
    name = "zathura";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.zathura.options = {
      default-fg = p.text.hex;
      default-bg = p.base.hex;
      completion-fg = p.text.hex;
      completion-bg = p.surface0.hex;
      completion-highlight-fg = p.text.hex;
      completion-highlight-bg = p.surface2.hex;
      inputbar-fg = p.text.hex;
      inputbar-bg = p.surface0.hex;
      notification-bg = p.surface0.hex;
      notification-fg = p.text.hex;
      notification-error-bg = p.red.hex;
      notification-error-fg = p.base.hex;
      notification-warning-bg = p.yellow.hex;
      notification-warning-fg = p.base.hex;
      statusbar-fg = p.text.hex;
      statusbar-bg = p.surface0.hex;
      index-fg = p.text.hex;
      index-bg = p.base.hex;
      index-active-fg = accentColor;
      index-active-bg = p.surface1.hex;
      render-loading-fg = p.text.hex;
      render-loading-bg = p.base.hex;
      highlight-color = p.yellow.hex;
      highlight-fg = p.peach.hex;
      highlight-active-color = accentColor;
      recolor = p.meta.dark;
      recolor-lightcolor = p.base.hex;
      recolor-darkcolor = p.text.hex;
    };
  };
}
