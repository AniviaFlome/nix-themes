{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.tofi;
  theme = config.themes.theme;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.tofi = themesLib.mkThemeOption {
    name = "tofi";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.tofi.settings = {
          background-color = p.base.hex;
          outline-color = p.base.hex;
          border-color = accentColor;
          text-color = p.text.hex;
          prompt-color = lib.mkDefault accentColor;
          selection-color = lib.mkDefault accentColor;
          selection-background = p.surface1.hex;
          selection-background-padding = "0, 4";
        };
      }
      (lib.mkIf (theme == "catppuccin") {
        programs.tofi.settings = {
          prompt-color = p.red.hex;
          selection-color = p.yellow.hex;
        };
      })
    ]
  );
}
