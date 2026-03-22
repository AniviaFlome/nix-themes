{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.sddm;
in

{
  options.themes.sddm = themesLib.mkThemeOption { name = "sddm"; };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        # TODO: remove once themes/pkgs/sddm/package.nix is implemented
        assertion = false;
        message = "themes.sddm is not yet implemented. See themes/pkgs/sddm/package.nix.";
      }
    ];

    services.displayManager.sddm.theme = "nix-themes-${config.themes.theme}-${config.themes.variant}";

    environment.systemPackages = [
      (pkgs.callPackage ../../pkgs/sddm/package.nix {
        inherit (config.themes) theme variant;
        palette = config.themes.palette;
      })
    ];
  };
}
