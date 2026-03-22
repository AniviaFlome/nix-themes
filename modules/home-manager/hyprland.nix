{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.hyprland;
  palette = config.themes.palette;
  accent = cfg.accent;

  # Hyprland expects colors as 0xRRGGBB or 0xAARRGGBB (without leading #)
  # Strip the '#' from hex values
  hex = color: builtins.substring 1 6 color.hex;

  # Generate a Hyprland variables file with all palette colors exposed as $colorName
  # Also exposes $accent pointing to the chosen accent color
  paletteConf = pkgs.writeText "nix-themes-hyprland.conf" ''
    # nix-themes: generated palette variables for ${config.themes.theme}/${config.themes.variant}
    $t_crust     = rgb(${hex palette.crust})
    $t_mantle    = rgb(${hex palette.mantle})
    $t_base      = rgb(${hex palette.base})
    $t_surface0  = rgb(${hex palette.surface0})
    $t_surface1  = rgb(${hex palette.surface1})
    $t_surface2  = rgb(${hex palette.surface2})
    $t_overlay0  = rgb(${hex palette.overlay0})
    $t_overlay1  = rgb(${hex palette.overlay1})
    $t_overlay2  = rgb(${hex palette.overlay2})
    $t_subtext0  = rgb(${hex palette.subtext0})
    $t_subtext1  = rgb(${hex palette.subtext1})
    $t_text      = rgb(${hex palette.text})
    $t_rosewater = rgb(${hex palette.rosewater})
    $t_flamingo  = rgb(${hex palette.flamingo})
    $t_pink      = rgb(${hex palette.pink})
    $t_mauve     = rgb(${hex palette.mauve})
    $t_red       = rgb(${hex palette.red})
    $t_maroon    = rgb(${hex palette.maroon})
    $t_peach     = rgb(${hex palette.peach})
    $t_yellow    = rgb(${hex palette.yellow})
    $t_green     = rgb(${hex palette.green})
    $t_teal      = rgb(${hex palette.teal})
    $t_sky       = rgb(${hex palette.sky})
    $t_sapphire  = rgb(${hex palette.sapphire})
    $t_blue      = rgb(${hex palette.blue})
    $t_lavender  = rgb(${hex palette.lavender})
    $t_accent    = $t_${accent}
  '';
in

{
  options.themes.hyprland = themesLib.mkThemeOption {
    name = "hyprland";
    accentSupport = true;
  };

  config = lib.mkIf (cfg.enable && config.wayland.windowManager.hyprland.enable) {

    wayland.windowManager.hyprland.settings.source = [ "${paletteConf}" ];
  };
}
