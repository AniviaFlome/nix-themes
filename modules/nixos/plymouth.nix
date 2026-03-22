{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.plymouth;
in

{
  options.themes.plymouth = themesLib.mkThemeOption { name = "plymouth"; };

  config = lib.mkIf cfg.enable {

    boot.plymouth = {
      theme = "nix-themes-${config.themes.theme}-${config.themes.variant}";
      themePackages = [
        (pkgs.callPackage ../../pkgs/plymouth/package.nix {
          inherit (config.themes) theme variant;
          palette = config.themes.palette;
        })
      ];
    };
  };
}
