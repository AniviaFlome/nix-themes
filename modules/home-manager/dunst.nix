{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.dunst;
  p = config.themes.palette;
  enable = cfg.enable && config.services.dunst.enable;

  # Generate a dunst drop-in file with urgency color settings
  # Written as a drop-in so users can override with higher-precedence files
  dropIn = ''
    [urgency_low]
    background = "${p.base.hex}"
    foreground = "${p.subtext1.hex}"
    frame_color = "${p.surface1.hex}"

    [urgency_normal]
    background = "${p.base.hex}"
    foreground = "${p.text.hex}"
    frame_color = "${p.blue.hex}"

    [urgency_critical]
    background = "${p.base.hex}"
    foreground = "${p.text.hex}"
    frame_color = "${p.red.hex}"
  '';
in

{
  options.themes.dunst = themesLib.mkThemeOption { name = "dunst"; } // {
    prefix = lib.mkOption {
      type = lib.types.str;
      default = "00";
      description = "Prefix for the dunst drop-in file (controls load order)";
    };
  };

  config = lib.mkIf enable {

    xdg.configFile."dunst/dunstrc.d/${cfg.prefix}-nix-themes.conf".text = dropIn;
  };
}
