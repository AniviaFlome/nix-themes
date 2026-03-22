{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.kvantum;
  enable = cfg.enable && config.qt.enable;

  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}-${cfg.accent}";

  kvantumPkg = pkgs.callPackage ../../pkgs/kvantum/package.nix {
    inherit (config.themes) theme variant;
    inherit (cfg) accent;
    palette = config.themes.palette;
  };
in

{
  options.themes.kvantum =
    themesLib.mkThemeOption {
      name = "kvantum";
      accentSupport = true;
    }
    // {
      apply = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Applies the theme by overwriting `$XDG_CONFIG_HOME/Kvantum/kvantum.kvconfig`.
          If this is disabled, you must manually set the theme (e.g. by using `kvantummanager`).
        '';
      };

      assertStyle = lib.mkOption {
        type = lib.types.bool;
        default = true;
        example = false;
        description = ''
          Whether to assert that {option}`qt.style.name` is set to `"kvantum"` when Kvantum themes are enabled.
        '';
      };
    };

  config = lib.mkIf enable {
    assertions = lib.optional cfg.assertStyle {
      assertion = lib.elem config.qt.style.name [
        "kvantum"
        "Kvantum"
      ];
      message = "`qt.style.name` must be `\"kvantum\"` to use `themes.kvantum`";
    };

    xdg.configFile = {
      "Kvantum/${themeName}".source = "${kvantumPkg}/share/Kvantum/${themeName}";
      "Kvantum/kvantum.kvconfig" = lib.mkIf cfg.apply {
        text = ''
          [General]
          theme=${themeName}
        '';
      };
    };
  };
}
