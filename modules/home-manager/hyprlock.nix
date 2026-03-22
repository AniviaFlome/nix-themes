{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.hyprlock;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  accent = cfg.accent;

  # Generate a Hyprlock palette variables file
  paletteConf = pkgs.writeText "nix-themes-hyprlock.conf" ''
    # nix-themes: generated palette variables for ${config.themes.theme}/${config.themes.variant}
    $t_crust     = rgb(${sh p.crust})
    $t_mantle    = rgb(${sh p.mantle})
    $t_base      = rgb(${sh p.base})
    $t_surface0  = rgb(${sh p.surface0})
    $t_surface1  = rgb(${sh p.surface1})
    $t_surface2  = rgb(${sh p.surface2})
    $t_overlay0  = rgb(${sh p.overlay0})
    $t_overlay1  = rgb(${sh p.overlay1})
    $t_overlay2  = rgb(${sh p.overlay2})
    $t_subtext0  = rgb(${sh p.subtext0})
    $t_subtext1  = rgb(${sh p.subtext1})
    $t_text      = rgb(${sh p.text})
    $t_rosewater = rgb(${sh p.rosewater})
    $t_flamingo  = rgb(${sh p.flamingo})
    $t_pink      = rgb(${sh p.pink})
    $t_mauve     = rgb(${sh p.mauve})
    $t_red       = rgb(${sh p.red})
    $t_maroon    = rgb(${sh p.maroon})
    $t_peach     = rgb(${sh p.peach})
    $t_yellow    = rgb(${sh p.yellow})
    $t_green     = rgb(${sh p.green})
    $t_teal      = rgb(${sh p.teal})
    $t_sky       = rgb(${sh p.sky})
    $t_sapphire  = rgb(${sh p.sapphire})
    $t_blue      = rgb(${sh p.blue})
    $t_lavender  = rgb(${sh p.lavender})
    $t_accent    = $t_${accent}
  '';
in

{
  options.themes.hyprlock = themesLib.mkThemeOption {
    name = "hyprlock";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.hyprlock.settings.source = [ "${paletteConf}" ];
  };
}
