{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.atuin;
  theme = config.themes.theme;
  p = config.themes.palette;
  accent = cfg.accent;
  themeName = "nix-themes-${theme}-${config.themes.variant}-${accent}";
  enable = cfg.enable && config.programs.atuin.enable;
in

{
  options.themes.atuin = themesLib.mkThemeOption {
    name = "atuin";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    programs.atuin.settings.theme.name = themeName;

    xdg.configFile."atuin/themes/${themeName}.toml".text = ''
      [theme]
      name = "${themeName}"

      [colors]
      AlertInfo = "${p.green.hex}"
      AlertWarn = "${p.peach.hex}"
      AlertError = "${p.red.hex}"
      Annotation = "${p.${accent}.hex}"
      Base = "${p.text.hex}"
      Guidance = "${if theme == "catppuccin" then p.overlay2.hex else p.overlay1.hex}"
      Important = "${p.red.hex}"
      Title = "${p.${accent}.hex}"
    '';
  };
}
