{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.element-desktop;
  p = config.themes.palette;
  accent = cfg.accent;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}-${accent}";

  customTheme = {
    name = themeName;
    is_dark = p.meta.dark;
    colors = {
      "accent-color" = p.${accent}.hex;
      "primary-color" = p.${accent}.hex;
      "warning-color" = p.red.hex;
      alert = p.yellow.hex;
      "sidebar-color" = p.crust.hex;
      "roomlist-background-color" = p.mantle.hex;
      "roomlist-text-color" = p.text.hex;
      "roomlist-text-secondary-color" = p.overlay2.hex;
      "roomlist-highlights-color" = p.surface1.hex;
      "roomlist-separator-color" = p.overlay1.hex;
      "timeline-background-color" = p.base.hex;
      "timeline-text-color" = p.text.hex;
      "secondary-content" = p.text.hex;
      "tertiary-content" = p.text.hex;
      "timeline-text-secondary-color" = p.subtext0.hex;
      "timeline-highlights-color" = p.mantle.hex;
      "reaction-row-button-selected-bg-color" = p.surface1.hex;
      "menu-selected-color" = p.surface1.hex;
      "focus-bg-color" = p.surface2.hex;
      "room-highlight-color" = p.sky.hex;
      "togglesw-off-color" = p.overlay2.hex;
      "other-user-pill-bg-color" = p.sky.hex;
      "username-colors" = [
        p.mauve.hex
        p.maroon.hex
        p.peach.hex
        p.green.hex
        p.teal.hex
        p.sky.hex
        p.sapphire.hex
        p.lavender.hex
      ];
      "avatar-background-colors" = [
        p.${accent}.hex
        p.mauve.hex
        p.green.hex
      ];
    };
  };
in

{
  options.themes.element-desktop = themesLib.mkThemeOption {
    name = "element-desktop";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.element-desktop.settings = {
      default_theme = themeName;
      setting_defaults.custom_themes = [ customTheme ];
    };
  };
}
