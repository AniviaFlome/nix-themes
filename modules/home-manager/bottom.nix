{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.bottom;
  p = config.themes.palette;
in

{
  options.themes.bottom = themesLib.mkThemeOption { name = "bottom"; };

  config = lib.mkIf cfg.enable {

    programs.bottom.settings.colors = {
      table_header_color = p.blue.hex;
      all_cpu_color = p.green.hex;
      avg_cpu_color = p.red.hex;
      cpu_core_colors = [
        p.mauve.hex
        p.blue.hex
        p.teal.hex
        p.green.hex
        p.yellow.hex
        p.peach.hex
        p.pink.hex
        p.flamingo.hex
      ];
      ram_color = p.mauve.hex;
      swap_color = p.peach.hex;
      arc_color = p.sky.hex;
      gpu_core_colors = [
        p.mauve.hex
        p.blue.hex
        p.teal.hex
        p.green.hex
        p.yellow.hex
        p.peach.hex
      ];
      rx_color = p.green.hex;
      tx_color = p.red.hex;
      widget_title_color = p.lavender.hex;
      border_color = p.overlay0.hex;
      highlighted_border_color = p.blue.hex;
      text_color = p.text.hex;
      graph_color = p.subtext0.hex;
      cursor_color = p.rosewater.hex;
      selected_text_color = p.base.hex;
      selected_bg_color = p.blue.hex;
      high_battery_color = p.green.hex;
      medium_battery_color = p.yellow.hex;
      low_battery_color = p.red.hex;
      disabled_text_color = p.surface2.hex;
    };
  };
}
