{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.fcitx5;

  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";

  fcitx5Pkg = pkgs.callPackage ../../pkgs/fcitx5/package.nix {
    inherit (config.themes) theme variant;
    palette = config.themes.palette;
  };
in

{
  options.themes.fcitx5 = themesLib.mkThemeOption { name = "fcitx5"; };

  config = lib.mkIf cfg.enable {

    home.file.".local/share/fcitx5/themes/${themeName}".source =
      "${fcitx5Pkg}/share/fcitx5/themes/${themeName}";

    xdg.configFile."fcitx5/conf/classicui.conf".text = ''
      Theme=${themeName}
    '';
  };
}
