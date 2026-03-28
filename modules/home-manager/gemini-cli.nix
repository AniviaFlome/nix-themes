{ themesLib }:
{ config, lib, ... }:

let
  # TODO: sources removed – generate theme content inline from config.themes.palette

  cfg = config.themes.gemini-cli;
  theme = lib.importJSON "${sources.gemini-cli}/catppuccin-${cfg.flavor}.json"; # TODO: replace with inline palette-based generation # TODO: flavor → variant; verify palette supports this variant
in

{
  options.themes.gemini-cli = themesLib.mkThemeOption { name = "gemini-cli"; };

  config = lib.mkIf cfg.enable {
    programs.gemini-cli = {
      settings.ui = {
        theme = theme.name;
        customThemes.${theme.name} = theme;
      };
    };
  };
}
