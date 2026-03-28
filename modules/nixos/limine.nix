{ themesLib }:
{
  config,
  lib,
  ...
}:

let
  # TODO: sources removed – generate theme content inline from config.themes.palette

  cfg = config.themes.limine;

  theme = sources.limine + "/catppuccin-${cfg.flavor}.conf"; # TODO: replace with inline palette-based generation # TODO: flavor → variant; verify palette supports this variant
in

{
  options.themes.limine = themesLib.mkThemeOption { name = "limine"; };

  config = lib.mkIf cfg.enable {
    boot.loader.limine = {
      extraConfig = lib.fileContents theme;
      style.wallpapers = [ ];
    };
  };
}
