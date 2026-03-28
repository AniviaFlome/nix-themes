{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.fuzzel;
  theme = config.themes.theme;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  accent = cfg.accent;
  accentColor = sh p.${accent};
in

{
  options.themes.fuzzel = themesLib.mkThemeOption {
    name = "fuzzel";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        # fuzzel expects colors as RRGGBBaa (hex, no '#', with 2-char alpha suffix)
        programs.fuzzel.settings.colors = {
          background = "${sh p.base}ff";
          text = "${sh p.text}ff";
          match = "${accentColor}ff";
          selection = lib.mkDefault "${sh p.surface1}ff";
          selection-text = "${sh p.text}ff";
          selection-match = "${accentColor}ff";
          border = "${accentColor}ff";
        };
      }

      # catppuccin/fuzzel uses surface2 for selection and adds prompt/placeholder/input/counter
      (lib.mkIf (theme == "catppuccin") {
        programs.fuzzel.settings.colors = {
          selection = "${sh p.surface2}ff";
          prompt = "${sh p.subtext1}ff";
          placeholder = "${sh p.overlay1}ff";
          input = "${sh p.text}ff";
          counter = "${sh p.overlay1}ff";
        };
      })
    ]
  );
}
