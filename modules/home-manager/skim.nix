{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.skim;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.skim = themesLib.mkThemeOption {
    name = "skim";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.skim.defaultOptions = [
      "--color=fg:${p.text.hex},bg:${p.base.hex},matched:${p.surface0.hex},matched_bg:${p.flamingo.hex},current:${p.text.hex},current_bg:${p.surface1.hex},current_match:${p.base.hex},current_match_bg:${p.rosewater.hex},spinner:${p.green.hex},info:${p.mauve.hex},prompt:${accentColor},cursor:${p.red.hex},selected:${p.maroon.hex},header:${p.teal.hex},border:${p.overlay0.hex}"
    ];
  };
}
