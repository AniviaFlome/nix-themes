{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.vicinae;
  theme = config.themes.theme;
in

{
  options.themes.vicinae = themesLib.mkThemeOption {
    name = "vicinae";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        # TODO: add generic/universal theme settings for other palettes
      }

      # catppuccin/vicinae
      (lib.mkIf (theme == "catppuccin") {
        programs.vicinae = {
          settings = {
            theme =
              let
                themeConfiguration = {
                  name = "catppuccin-${config.themes.variant}";
                  iconTheme = "Catppuccin ${lib.toSentenceCase config.themes.variant} ${lib.toSentenceCase cfg.accent}";
                };
              in
              {
                light = themeConfiguration;
                dark = themeConfiguration;
              };
          };
        };
      })
    ]
  );
}
