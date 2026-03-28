{ themesLib }:
{ config, lib, ... }:
let
  cfg = config.themes.vivid;
in
{
  options.themes.vivid = themesLib.mkThemeOption { name = "vivid"; };

  config = lib.mkIf cfg.enable {
    programs.vivid.activeTheme = "catppuccin-${cfg.flavor}"; # TODO: flavor → variant; verify palette supports this variant
  };
}
