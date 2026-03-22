{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.btop;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.btop.enable;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";
  themeFile = "${themeName}.theme";

  # btop theme format — key = "RRGGBB" (no #)
  sh = themesLib.stripHash;
  themeContent = pkgs.writeText themeFile ''
    # nix-themes: ${config.themes.theme}/${config.themes.variant}
    theme[main_bg]="${sh p.base}"
    theme[main_fg]="${sh p.text}"
    theme[title]="${sh p.blue}"
    theme[hi_fg]="${sh p.sky}"
    theme[selected_bg]="${sh p.surface1}"
    theme[selected_fg]="${sh p.text}"
    theme[inactive_fg]="${sh p.overlay0}"
    theme[graph_text]="${sh p.text}"
    theme[meter_bg]="${sh p.surface0}"
    theme[proc_misc]="${sh p.overlay1}"
    theme[cpu_box]="${sh p.blue}"
    theme[mem_box]="${sh p.green}"
    theme[net_box]="${sh p.mauve}"
    theme[proc_box]="${sh p.yellow}"
    theme[div_line]="${sh p.surface0}"
    theme[temp_start]="${sh p.teal}"
    theme[temp_mid]="${sh p.yellow}"
    theme[temp_end]="${sh p.red}"
    theme[cpu_start]="${sh p.teal}"
    theme[cpu_mid]="${sh p.blue}"
    theme[cpu_end]="${sh p.mauve}"
    theme[free_start]="${sh p.teal}"
    theme[free_mid]="${sh p.green}"
    theme[free_end]="${sh p.blue}"
    theme[cached_start]="${sh p.yellow}"
    theme[cached_mid]="${sh p.peach}"
    theme[cached_end]="${sh p.red}"
    theme[available_start]="${sh p.green}"
    theme[available_mid]="${sh p.teal}"
    theme[available_end]="${sh p.blue}"
    theme[used_start]="${sh p.mauve}"
    theme[used_mid]="${sh p.pink}"
    theme[used_end]="${sh p.red}"
    theme[download_start]="${sh p.teal}"
    theme[download_mid]="${sh p.blue}"
    theme[download_end]="${sh p.mauve}"
    theme[upload_start]="${sh p.green}"
    theme[upload_mid]="${sh p.yellow}"
    theme[upload_end]="${sh p.red}"
    theme[process_start]="${sh p.teal}"
    theme[process_mid]="${sh p.blue}"
    theme[process_end]="${sh p.mauve}"
  '';
in

{
  options.themes.btop = themesLib.mkThemeOption { name = "btop"; };

  config = lib.mkIf enable {

    xdg.configFile."btop/themes/${themeFile}".source = themeContent;

    programs.btop.settings.color_theme = themeFile;
  };
}
