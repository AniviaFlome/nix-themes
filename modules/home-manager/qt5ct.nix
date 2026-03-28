{ themesLib }:
{
  config,
  lib,
  ...
}:

let
  cfg = config.themes.qt5ct;
  enable = cfg.enable && config.qt.enable;
in

{
  imports = [
    # TODO: remove or adapt – this renames legacy catppuccin options that do not exist in themes
    (lib.mkRenamedOptionModule
      [
        "catppuccin"
        "qt5ct"
        "assertStyle"
      ]
      [
        "catppuccin"
        "qt5ct"
        "assertPlatformTheme"
      ]
    )
  ];
  options.themes.qt5ct =
    themesLib.mkThemeOption {
      name = "qt5ct";
      accentSupport = true;

      # NOTE: don't default enable since it will conflict with kvantum themes
      useGlobalEnable = false;
    }
    // {
      assertPlatformTheme = lib.mkOption {
        type = lib.types.bool;
        default = true;
        example = false;
        description = ''
          Whether to assert that {option}`qt.platformTheme.name` is set to `"qtct"` when qtct themes are enabled.
        '';
      };
    };

  config = lib.mkIf enable {
    assertions = lib.mkIf cfg.assertPlatformTheme [
      {
        assertion = config.qt.platformTheme.name == "qtct";
        message = ''{option}`qt.platformTheme.name` must be `"qtct"` to use {option}`catppuccin.qt5ct`'';
      }
    ];

    qt = lib.genAttrs [ "qt5ctSettings" "qt6ctSettings" ] (_: {
      Appearance = {
        custom_palette = true;
        color_scheme_path = "${config.catppuccin.sources.qt5ct}/catppuccin-${cfg.flavor}-${cfg.accent}.conf"; # TODO: replace with inline palette-based generation # TODO: flavor → variant; verify palette supports this variant
      };
    });
  };
}
