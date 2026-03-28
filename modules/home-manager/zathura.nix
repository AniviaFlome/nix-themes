{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.zathura;
  theme = config.themes.theme;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.zathura = themesLib.mkThemeOption {
    name = "zathura";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.zathura.options = {
          default-fg = p.text.hex;
          default-bg = p.base.hex;
          completion-fg = p.text.hex;
          completion-bg = p.surface0.hex;
          completion-highlight-fg = lib.mkDefault p.text.hex;
          completion-highlight-bg = lib.mkDefault p.surface2.hex;
          inputbar-fg = p.text.hex;
          inputbar-bg = p.surface0.hex;
          notification-bg = p.surface0.hex;
          notification-fg = p.text.hex;
          notification-error-bg = p.red.hex;
          notification-error-fg = lib.mkDefault p.base.hex;
          notification-warning-bg = p.yellow.hex;
          notification-warning-fg = lib.mkDefault p.base.hex;
          statusbar-fg = p.text.hex;
          statusbar-bg = lib.mkDefault p.surface0.hex;
          index-fg = p.text.hex;
          index-bg = p.base.hex;
          index-active-fg = lib.mkDefault accentColor;
          index-active-bg = lib.mkDefault p.surface1.hex;
          render-loading-fg = p.text.hex;
          render-loading-bg = p.base.hex;
          highlight-color = lib.mkDefault p.yellow.hex;
          highlight-fg = lib.mkDefault p.peach.hex;
          highlight-active-color = lib.mkDefault accentColor;
          recolor = p.meta.dark;
          recolor-lightcolor = p.base.hex;
          recolor-darkcolor = p.text.hex;
        };
      }

      # catppuccin/zathura uses different colors for several settings
      (lib.mkIf (theme == "catppuccin") {
        programs.zathura.options = {
          completion-highlight-bg = p.mauve.hex;
          completion-highlight-fg = p.base.hex;
          statusbar-bg = p.crust.hex;
          notification-error-fg = p.red.hex;
          notification-warning-fg = p.yellow.hex;
          index-active-fg = p.text.hex;
          index-active-bg = p.surface0.hex;
          highlight-color = p.overlay2.hex;
          highlight-fg = p.text.hex;
          highlight-active-color = p.mauve.hex;
        };
      })
    ]
  );
}
