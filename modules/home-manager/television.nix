{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.television;
  p = config.themes.palette;
  accent = cfg.accent;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}-${accent}";
  enable = cfg.enable && config.programs.television.enable;
in

{
  options.themes.television = themesLib.mkThemeOption {
    name = "television";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    programs.television.settings.ui.theme = themeName;

    xdg.configFile."television/themes/${themeName}.toml".text = ''
      # nix-themes: ${config.themes.theme}/${config.themes.variant}
      # general
      background = '${p.base.hex}'
      border_fg = '${p.surface1.hex}'
      text_fg = '${p.text.hex}'
      dimmed_text_fg = '${p.overlay0.hex}'
      # input
      input_text_fg = '${p.${accent}.hex}'
      result_count_fg = '${p.${accent}.hex}'
      # results
      result_name_fg = '${p.${accent}.hex}'
      result_line_number_fg = '${p.yellow.hex}'
      result_value_fg = '${p.lavender.hex}'
      selection_fg = '${p.green.hex}'
      selection_bg = '${p.surface0.hex}'
      match_fg = '${p.green.hex}'
      # preview
      preview_title_fg = '${p.${accent}.hex}'
      # modes
      channel_mode_fg = '${p.base.hex}'
      channel_mode_bg = '${p.${accent}.hex}'
      remote_control_mode_fg = '${p.base.hex}'
      remote_control_mode_bg = '${p.green.hex}'
    '';
  };
}
