{ themesLib }:
{ config, lib, ... }:

let
  # TODO: sources removed – generate theme content inline from config.themes.palette

  cfg = config.themes.obs;
  enable = cfg.enable && config.programs.obs-studio.enable;

  themeName = "Catppuccin_${lib.toSentenceCase cfg.flavor}.ovt"; # TODO: flavor → variant; verify palette supports this variant
in

{
  options.themes.obs = themesLib.mkThemeOption { name = "obs-studio"; };

  config = lib.mkIf enable {
    # xdg.configFile = {
    #   "obs-studio/themes/Catppuccin.obt".source = "${sources.obs}/Catppuccin.obt"; # TODO: replace with inline palette-based generation
    #   "obs-studio/themes/${themeName}".source = "${sources.obs}/${themeName}"; # TODO: replace with inline palette-based generation
    # };
  };
}
