{ themesLib }:
{
  config,
  lib,
  ...
}:

let
  # TODO: sources removed – generate theme content inline from config.themes.palette
  cfg = config.themes.fcitx5;
in

{
  options.themes.fcitx5 =
    themesLib.mkThemeOption {
      name = "Fcitx5";
      accentSupport = true;
    }
    // {
      enableRounded = lib.mkEnableOption "rounded corners for the Fcitx5 theme";
    };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod.fcitx5 = {
      addons = [
        (sources.fcitx5.override { inherit (cfg) enableRounded; }) # TODO: replace with inline palette-based generation
      ];
      settings.addons.classicui.globalSection.Theme = "catppuccin-${cfg.flavor}-${cfg.accent}"; # TODO: flavor → variant; verify palette supports this variant
    };
  };
}
