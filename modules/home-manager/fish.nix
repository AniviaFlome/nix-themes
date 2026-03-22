{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.fish;
  p = config.themes.palette;
  ansi = p.ansi;

  # fish color variables: fish uses hex values directly (no #)
  # set -U persists across sessions
  colorVars = ''
    # nix-themes: ${config.themes.theme}/${config.themes.variant}
    set -U fish_color_normal ${p.text.hex}
    set -U fish_color_command ${p.blue.hex}
    set -U fish_color_keyword ${p.mauve.hex}
    set -U fish_color_quote ${p.green.hex}
    set -U fish_color_redirection ${p.pink.hex}
    set -U fish_color_end ${p.peach.hex}
    set -U fish_color_error ${p.red.hex}
    set -U fish_color_param ${p.text.hex}
    set -U fish_color_comment ${p.overlay0.hex}
    set -U fish_color_operator ${p.sky.hex}
    set -U fish_color_escape ${p.pink.hex}
    set -U fish_color_autosuggestion ${p.overlay1.hex}
    set -U fish_color_cancel ${p.red.hex}
    set -U fish_color_search_match --background=${p.surface1.hex}
    set -U fish_color_selection --background=${p.surface1.hex}
    set -U fish_pager_color_progress ${p.overlay1.hex}
    set -U fish_pager_color_prefix ${p.sky.hex}
    set -U fish_pager_color_completion ${p.text.hex}
    set -U fish_pager_color_description ${p.overlay1.hex}
    set -U fish_pager_color_selected_background --background=${p.surface1.hex}
  '';
in

{
  options.themes.fish = themesLib.mkThemeOption { name = "fish"; };

  config = lib.mkIf cfg.enable {

    programs.fish.interactiveShellInit = colorVars;
  };
}
