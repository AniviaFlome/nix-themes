{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.bottom;
  theme = config.themes.theme;
  p = config.themes.palette;
in

{
  options.themes.bottom = themesLib.mkThemeOption { name = "bottom"; };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.bottom.settings.colors = {
          table_header_color = p.blue.hex;
          all_cpu_color = lib.mkDefault p.green.hex;
          avg_cpu_color = lib.mkDefault p.red.hex;
          cpu_core_colors = lib.mkDefault [
            p.mauve.hex
            p.blue.hex
            p.teal.hex
            p.green.hex
            p.yellow.hex
            p.peach.hex
            p.pink.hex
            p.flamingo.hex
          ];
          ram_color = lib.mkDefault p.mauve.hex;
          swap_color = p.peach.hex;
          arc_color = p.sky.hex;
          gpu_core_colors = lib.mkDefault [
            p.mauve.hex
            p.blue.hex
            p.teal.hex
            p.green.hex
            p.yellow.hex
            p.peach.hex
          ];
          rx_color = p.green.hex;
          tx_color = p.red.hex;
          widget_title_color = lib.mkDefault p.lavender.hex;
          border_color = lib.mkDefault p.overlay0.hex;
          highlighted_border_color = lib.mkDefault p.blue.hex;
          text_color = p.text.hex;
          graph_color = p.subtext0.hex;
          cursor_color = p.rosewater.hex;
          selected_text_color = lib.mkDefault p.base.hex;
          selected_bg_color = lib.mkDefault p.blue.hex;
          high_battery_color = p.green.hex;
          medium_battery_color = p.yellow.hex;
          low_battery_color = p.red.hex;
          disabled_text_color = lib.mkDefault p.surface2.hex;
        };
      }

      # catppuccin/bottom uses different color roles from generic
      (lib.mkIf (theme == "catppuccin") {
        programs.bottom.settings.colors = {
          all_cpu_color = p.rosewater.hex;
          avg_cpu_color = p.maroon.hex;
          cpu_core_colors = [
            p.red.hex
            p.peach.hex
            p.yellow.hex
            p.green.hex
            p.sapphire.hex
            p.mauve.hex
          ];
          ram_color = p.green.hex;
          gpu_core_colors = [
            p.sapphire.hex
            p.mauve.hex
            p.red.hex
            p.peach.hex
            p.yellow.hex
            p.green.hex
          ];
          widget_title_color = p.flamingo.hex;
          border_color = p.surface2.hex;
          highlighted_border_color = p.pink.hex;
          selected_text_color = p.crust.hex;
          selected_bg_color = p.mauve.hex;
          disabled_text_color = p.base.hex;
        };
      })
    ]
  );
}
