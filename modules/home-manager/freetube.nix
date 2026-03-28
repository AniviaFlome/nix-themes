{ themesLib }:
{ config, lib, ... }:

let
  inherit (lib) toSentenceCase;
  cfg = config.themes.freetube;
in

{
  options.themes.freetube =
    themesLib.mkThemeOption {
      name = "freetube";
      accentSupport = true;
    }
    // {
      # FreeTube supports two accent colors
      secondaryAccent = lib.mkOption {
        type = themesLib.types.accent;
        # Have the secondary accent default to FreeTube's main accent rather than the global Catppuccin accent
        # This assumes most users would prefer both accent colors to be the same when only overriding the main one
        default = cfg.accent;
        description = "Secondary accent for freetube";
      };
    };

  config = lib.mkIf cfg.enable {
    programs.freetube.settings = {
      # NOTE: For some reason, baseTheme does not capitalize first letter, but the other settings do
      baseTheme = "catppuccin${toSentenceCase cfg.flavor}"; # TODO: flavor → variant; verify palette supports this variant
      mainColor = "Catppuccin${toSentenceCase cfg.flavor}${toSentenceCase cfg.accent}"; # TODO: flavor → variant; verify palette supports this variant
      secColor = "Catppuccin${toSentenceCase cfg.flavor}${toSentenceCase cfg.secondaryAccent}"; # TODO: flavor → variant; verify palette supports this variant
    };
  };
}
