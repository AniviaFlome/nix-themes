{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.fish;
  theme = config.themes.theme;
  p = config.themes.palette;

  # fish color variables: fish uses hex values directly (no #)
  # set -U persists across sessions; later set -U for the same variable wins
  genericColorVars = ''
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

  # catppuccin/fish uses different colors for several variables
  catppuccinColorVars = ''
    set -U fish_color_param ${p.flamingo.hex}
    set -U fish_color_comment ${p.overlay1.hex}
    set -U fish_color_operator ${p.pink.hex}
    set -U fish_color_escape ${p.maroon.hex}
    set -U fish_color_autosuggestion ${p.overlay0.hex}
    set -U fish_color_search_match --background=${p.surface0.hex}
    set -U fish_color_selection --background=${p.surface0.hex}
    set -U fish_pager_color_progress ${p.overlay0.hex}
    set -U fish_pager_color_prefix ${p.pink.hex}
    set -U fish_pager_color_description ${p.overlay0.hex}
    set -U fish_color_option ${p.green.hex}
    set -U fish_color_cwd ${p.yellow.hex}
    set -U fish_color_user ${p.teal.hex}
    set -U fish_color_host ${p.blue.hex}
  '';
in

{
  options.themes.fish = themesLib.mkThemeOption { name = "fish"; };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.fish.interactiveShellInit = genericColorVars;
      }

      (lib.mkIf (theme == "catppuccin") {
        programs.fish.interactiveShellInit = catppuccinColorVars;
      })
    ]
  );
}
