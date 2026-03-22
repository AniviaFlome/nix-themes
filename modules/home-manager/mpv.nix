{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.mpv;
  p = config.themes.palette;
  accent = cfg.accent;
in

{
  options.themes.mpv = themesLib.mkThemeOption {
    name = "mpv";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.mpv.config = {
      # OSD colors — mpv uses #RRGGBB or #AARRGGBB (alpha first)
      osd-color = p.text.hex;
      osd-border-color = p.crust.hex;
      osd-shadow-color = p.crust.hex;
      # Subtitle colors
      sub-color = p.text.hex;
      sub-border-color = p.crust.hex;
      sub-shadow-color = p.crust.hex;
      sub-back-color = "#CC${builtins.substring 1 6 p.base.hex}";
    };
  };
}
