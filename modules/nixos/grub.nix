{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.grub;
  palette = config.themes.palette;

  theme = pkgs.callPackage ../../pkgs/grub/package.nix {
    inherit palette;
    inherit (config.themes) theme variant;
  };

  themePath = "${theme}/share/grub/themes/nix-themes-${config.themes.theme}-${config.themes.variant}";
in

{
  options.themes.grub = themesLib.mkThemeOption { name = "grub"; };

  config = lib.mkIf cfg.enable {

    boot.loader.grub = {
      font = "${themePath}/font.pf2";
      splashImage = "${themePath}/background.png";
      theme = themePath;
    };
  };
}
