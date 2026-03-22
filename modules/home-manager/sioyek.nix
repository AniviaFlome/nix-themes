{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.sioyek;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.sioyek.enable;
in

{
  options.themes.sioyek = themesLib.mkThemeOption { name = "sioyek"; };

  config = lib.mkIf enable {

    programs.sioyek.config = {
      background_color = p.base.hex;
      custom_background_color = p.base.hex;
      custom_text_color = p.text.hex;
      ui_text_color = p.text.hex;
      ui_background_color = p.surface0.hex;
      ui_selected_text_color = p.text.hex;
      ui_selected_background_color = p.surface2.hex;
      status_bar_color = p.surface0.hex;
      status_bar_text_color = p.text.hex;
      text_highlight_color = p.yellow.hex;
      visual_mark_color = p.overlay1.hex;
      search_highlight_color = p.yellow.hex;
      link_highlight_color = p.blue.hex;
      synctex_highlight_color = p.green.hex;
      highlight_color_a = p.yellow.hex;
      highlight_color_b = p.green.hex;
      highlight_color_c = p.teal.hex;
      highlight_color_d = p.maroon.hex;
      highlight_color_e = p.mauve.hex;
      highlight_color_f = p.red.hex;
      highlight_color_g = p.peach.hex;
    };
  };
}
