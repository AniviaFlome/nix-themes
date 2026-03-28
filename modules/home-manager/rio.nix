{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.rio;
  theme = config.themes.theme;
  p = config.themes.palette;
  ansi = p.ansi;

  # Rio expects colors as arrays [r, g, b] (0-255 integers)
  rgb = color: [
    color.rgb.r
    color.rgb.g
    color.rgb.b
  ];
in

{
  options.themes.rio = themesLib.mkThemeOption { name = "rio"; };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.rio.settings.colors = {
          background = rgb p.base;
          foreground = rgb p.text;
          cursor = rgb p.rosewater;
          # Named colors
          black = lib.mkDefault (rgb ansi.black.normal);
          red = rgb ansi.red.normal;
          green = rgb ansi.green.normal;
          yellow = rgb ansi.yellow.normal;
          blue = rgb ansi.blue.normal;
          magenta = rgb ansi.magenta.normal;
          cyan = rgb ansi.cyan.normal;
          white = rgb ansi.white.normal;
          light-black = lib.mkDefault (rgb ansi.black.bright);
          light-red = rgb ansi.red.bright;
          light-green = rgb ansi.green.bright;
          light-yellow = rgb ansi.yellow.bright;
          light-blue = rgb ansi.blue.bright;
          light-magenta = rgb ansi.magenta.bright;
          light-cyan = rgb ansi.cyan.bright;
          light-white = lib.mkDefault (rgb ansi.white.bright);
        };
      }

      # catppuccin/rio uses surface1/surface2 for black/light-black (not ANSI base/surface1)
      # and adds tab bar + selection colors
      (lib.mkIf (theme == "catppuccin") {
        programs.rio.settings.colors = {
          black = rgb p.surface1;
          light-black = rgb p.surface2;
          light-white = rgb p.subtext0;
          tabs = rgb p.base;
          tabs-foreground = rgb p.text;
          tabs-active = rgb p.lavender;
          tabs-active-highlight = rgb p.lavender;
          tabs-active-foreground = rgb p.crust;
          selection-foreground = rgb p.base;
          selection-background = rgb p.rosewater;
        };
      })
    ]
  );
}
