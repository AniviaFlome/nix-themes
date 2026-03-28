{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.kitty;
  theme = config.themes.theme;
  p = config.themes.palette;
  ansi = p.ansi;
in

{
  options.themes.kitty = themesLib.mkThemeOption { name = "kitty"; };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.kitty.settings = {
          background = p.base.hex;
          foreground = p.text.hex;
          selection_background = lib.mkDefault p.surface2.hex;
          selection_foreground = lib.mkDefault p.text.hex;
          url_color = lib.mkDefault p.blue.hex;
          cursor = p.rosewater.hex;
          cursor_text_color = p.base.hex;
          active_tab_background = lib.mkDefault p.mauve.hex;
          active_tab_foreground = lib.mkDefault p.base.hex;
          inactive_tab_background = lib.mkDefault p.surface1.hex;
          inactive_tab_foreground = lib.mkDefault p.subtext0.hex;
          active_border_color = lib.mkDefault p.mauve.hex;
          inactive_border_color = lib.mkDefault p.surface1.hex;
          # ANSI colors
          color0 = ansi.black.normal.hex;
          color8 = ansi.black.bright.hex;
          color1 = ansi.red.normal.hex;
          color9 = ansi.red.bright.hex;
          color2 = ansi.green.normal.hex;
          color10 = ansi.green.bright.hex;
          color3 = ansi.yellow.normal.hex;
          color11 = ansi.yellow.bright.hex;
          color4 = ansi.blue.normal.hex;
          color12 = ansi.blue.bright.hex;
          color5 = ansi.magenta.normal.hex;
          color13 = ansi.magenta.bright.hex;
          color6 = ansi.cyan.normal.hex;
          color14 = ansi.cyan.bright.hex;
          color7 = ansi.white.normal.hex;
          color15 = ansi.white.bright.hex;
        };
      }

      # catppuccin/kitty uses different colors for several settings
      (lib.mkIf (theme == "catppuccin") {
        programs.kitty.settings = {
          selection_background = p.rosewater.hex;
          selection_foreground = p.base.hex;
          url_color = p.rosewater.hex;
          active_tab_background = p.mauve.hex;
          active_tab_foreground = p.crust.hex;
          inactive_tab_background = p.mantle.hex;
          inactive_tab_foreground = p.text.hex;
          tab_bar_background = p.crust.hex;
          active_border_color = p.lavender.hex;
          inactive_border_color = p.overlay1.hex;
          bell_border_color = p.yellow.hex;
        };
      })
    ]
  );
}
