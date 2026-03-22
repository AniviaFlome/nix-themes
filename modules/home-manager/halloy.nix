{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.halloy;
  p = config.themes.palette;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";
  enable = cfg.enable && config.programs.halloy.enable;
in

{
  options.themes.halloy = themesLib.mkThemeOption { name = "halloy"; };

  config = lib.mkIf enable {

    programs.halloy.settings.theme = themeName;

    xdg.configFile."halloy/themes/${themeName}.toml".text = ''
      [general]
      background = "${p.crust.hex}"
      border = "${p.overlay0.hex}"
      horizontal_rule = "${p.surface0.hex}"
      unread_indicator = "${p.mauve.hex}"

      [text]
      primary = "${p.text.hex}"
      secondary = "${p.subtext0.hex}"
      tertiary = "${p.mauve.hex}"
      success = "${p.green.hex}"
      error = "${p.red.hex}"

      [buttons.primary]
      background = "${p.crust.hex}"
      background_hover = "${p.mantle.hex}"
      background_selected = "${p.base.hex}"
      background_selected_hover = "${p.mantle.hex}"

      [buttons.secondary]
      background = "${p.mantle.hex}"
      background_hover = "${p.surface1.hex}"
      background_selected = "${p.surface0.hex}"
      background_selected_hover = "${p.surface1.hex}"

      [buffer]
      action = "${p.peach.hex}"
      background = "${p.base.hex}"
      background_text_input = "${p.mantle.hex}"
      background_title_bar = "${p.mantle.hex}"
      border = "${p.crust.hex}"
      border_selected = "${p.lavender.hex}"
      code = "${p.lavender.hex}"
      highlight = "${p.surface1.hex}"
      nickname = "${p.sky.hex}"
      selection = "${p.surface0.hex}"
      timestamp = "${p.subtext1.hex}"
      topic = "${p.overlay1.hex}"
      url = "${p.blue.hex}"

      [buffer.server_messages]
      default = "${p.yellow.hex}"
    '';
  };
}
