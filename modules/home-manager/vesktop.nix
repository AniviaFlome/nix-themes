{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.vesktop;
  themeName = "catppuccin-${cfg.flavor}-${cfg.accent}.theme"; # TODO: flavor → variant; verify palette supports this variant
in

{
  options.themes.vesktop = themesLib.mkThemeOption {
    name = "vesktop";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.vesktop.vencord = {
      settings.enabledThemes = [ "${themeName}.css" ];
      themes."${themeName}" = ''
              /**
        # TODO: mkFlavorName not in themesLib – adapt for config.themes.variant instead
               * @name Catppuccin ${themesLib.mkFlavorName cfg.flavor} (${lib.toSentenceCase cfg.accent}) # TODO: flavor → variant; verify palette supports this variant
               * @author Catppuccin
               * @description 🎮 Soothing pastel theme for Discord
               * @website https://github.com/catppuccin/discord
              **/
              @import url("https://catppuccin.github.io/discord/dist/${themeName}.css");
      '';
    };
  };
}
