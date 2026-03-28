{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.btop;
  theme = config.themes.theme;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.btop.enable;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";
  themeFile = "${themeName}.theme";

  # btop theme format — key = "RRGGBB" (no #)
  sh = themesLib.stripHash;

  # Color slots that differ between catppuccin/btop upstream and the generic mapping.
  # All other slots (main_bg, main_fg, mem_box, temp_*, cpu_start, free_end, upload_start)
  # are the same between catppuccin and generic.
  c =
    if theme == "catppuccin" then
      {
        title = p.text;
        hi_fg = p.blue;
        selected_fg = p.blue;
        inactive_fg = p.overlay1;
        graph_text = p.rosewater;
        meter_bg = p.surface1;
        proc_misc = p.rosewater;
        cpu_box = p.mauve;
        net_box = p.maroon;
        proc_box = p.blue;
        div_line = p.overlay0;
        temp_start = p.green;
        cpu_mid = p.sapphire;
        cpu_end = p.lavender;
        free_start = p.mauve;
        free_mid = p.lavender;
        cached_start = p.sapphire;
        cached_mid = p.blue;
        cached_end = p.lavender;
        available_start = p.peach;
        available_mid = p.maroon;
        available_end = p.red;
        used_start = p.green;
        used_mid = p.teal;
        used_end = p.sky;
        download_start = p.peach;
        download_mid = p.maroon;
        download_end = p.red;
        upload_mid = p.teal;
        upload_end = p.sky;
        process_start = p.sapphire;
        process_mid = p.lavender;
        process_end = p.mauve;
      }
    else
      {
        title = p.blue;
        hi_fg = p.sky;
        selected_fg = p.text;
        inactive_fg = p.overlay0;
        graph_text = p.text;
        meter_bg = p.surface0;
        proc_misc = p.overlay1;
        cpu_box = p.blue;
        net_box = p.mauve;
        proc_box = p.yellow;
        div_line = p.surface0;
        temp_start = p.teal;
        cpu_mid = p.blue;
        cpu_end = p.mauve;
        free_start = p.teal;
        free_mid = p.green;
        cached_start = p.yellow;
        cached_mid = p.peach;
        cached_end = p.red;
        available_start = p.green;
        available_mid = p.teal;
        available_end = p.blue;
        used_start = p.mauve;
        used_mid = p.pink;
        used_end = p.red;
        download_start = p.teal;
        download_mid = p.blue;
        download_end = p.mauve;
        upload_mid = p.yellow;
        upload_end = p.red;
        process_start = p.teal;
        process_mid = p.blue;
        process_end = p.mauve;
      };

  themeContent = pkgs.writeText themeFile ''
    # nix-themes: ${config.themes.theme}/${config.themes.variant}
    theme[main_bg]="${sh p.base}"
    theme[main_fg]="${sh p.text}"
    theme[title]="${sh c.title}"
    theme[hi_fg]="${sh c.hi_fg}"
    theme[selected_bg]="${sh p.surface1}"
    theme[selected_fg]="${sh c.selected_fg}"
    theme[inactive_fg]="${sh c.inactive_fg}"
    theme[graph_text]="${sh c.graph_text}"
    theme[meter_bg]="${sh c.meter_bg}"
    theme[proc_misc]="${sh c.proc_misc}"
    theme[cpu_box]="${sh c.cpu_box}"
    theme[mem_box]="${sh p.green}"
    theme[net_box]="${sh c.net_box}"
    theme[proc_box]="${sh c.proc_box}"
    theme[div_line]="${sh c.div_line}"
    theme[temp_start]="${sh c.temp_start}"
    theme[temp_mid]="${sh p.yellow}"
    theme[temp_end]="${sh p.red}"
    theme[cpu_start]="${sh p.teal}"
    theme[cpu_mid]="${sh c.cpu_mid}"
    theme[cpu_end]="${sh c.cpu_end}"
    theme[free_start]="${sh c.free_start}"
    theme[free_mid]="${sh c.free_mid}"
    theme[free_end]="${sh p.blue}"
    theme[cached_start]="${sh c.cached_start}"
    theme[cached_mid]="${sh c.cached_mid}"
    theme[cached_end]="${sh c.cached_end}"
    theme[available_start]="${sh c.available_start}"
    theme[available_mid]="${sh c.available_mid}"
    theme[available_end]="${sh c.available_end}"
    theme[used_start]="${sh c.used_start}"
    theme[used_mid]="${sh c.used_mid}"
    theme[used_end]="${sh c.used_end}"
    theme[download_start]="${sh c.download_start}"
    theme[download_mid]="${sh c.download_mid}"
    theme[download_end]="${sh c.download_end}"
    theme[upload_start]="${sh p.green}"
    theme[upload_mid]="${sh c.upload_mid}"
    theme[upload_end]="${sh c.upload_end}"
    theme[process_start]="${sh c.process_start}"
    theme[process_mid]="${sh c.process_mid}"
    theme[process_end]="${sh c.process_end}"
  '';
in

{
  options.themes.btop = themesLib.mkThemeOption { name = "btop"; };

  config = lib.mkIf enable {

    xdg.configFile."btop/themes/${themeFile}".source = themeContent;

    programs.btop.settings.color_theme = themeFile;
  };
}
