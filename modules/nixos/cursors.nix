{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.cursors;
in

{
  options.themes.cursors = themesLib.mkThemeOption {
    name = "cursors";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        # TODO: remove once themes/pkgs/cursors/package.nix is implemented
        assertion = false;
        message = "themes.cursors is not yet implemented. See themes/pkgs/cursors/package.nix.";
      }
    ];

    home.pointerCursor = {
      name = "nix-themes-${config.themes.theme}-${config.themes.variant}-${cfg.accent}";
      package = pkgs.callPackage ../../pkgs/cursors/package.nix {
        inherit (config.themes) theme variant;
        inherit (cfg) accent;
        palette = config.themes.palette;
      };
    };
  };
}
