{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.zellij;
  theme = config.themes.theme;
  themeName = "${config.themes.theme}-${config.themes.variant}";
in

{
  options.themes.zellij = themesLib.mkThemeOption { name = "zellij"; };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.zellij = {
          settings = {
            theme = themeName;
          };
        };
      }

      # catppuccin/zellij — add catppuccin-specific overrides here if needed
      (lib.mkIf (theme == "catppuccin") {
      })
    ]
  );
}
