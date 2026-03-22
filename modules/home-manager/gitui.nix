{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.gitui;
  p = config.themes.palette;

  # gitui uses RON format (Rusty Object Notation)
  themeFile = pkgs.writeText "nix-themes-gitui.ron" ''
    // nix-themes: ${config.themes.theme}/${config.themes.variant}
    (
      selected_tab: Reset,
      command_fg: Some(Rgb(${toString p.text.rgb.r}, ${toString p.text.rgb.g}, ${toString p.text.rgb.b})),
      selection_bg: Some(Rgb(${toString p.surface1.rgb.r}, ${toString p.surface1.rgb.g}, ${toString p.surface1.rgb.b})),
      selection_fg: Some(Rgb(${toString p.text.rgb.r}, ${toString p.text.rgb.g}, ${toString p.text.rgb.b})),
      cmdbar_bg: Some(Rgb(${toString p.surface0.rgb.r}, ${toString p.surface0.rgb.g}, ${toString p.surface0.rgb.b})),
      cmdbar_extra_lines_bg: Some(Rgb(${toString p.surface0.rgb.r}, ${toString p.surface0.rgb.g}, ${toString p.surface0.rgb.b})),
      disabled_fg: Some(Rgb(${toString p.overlay0.rgb.r}, ${toString p.overlay0.rgb.g}, ${toString p.overlay0.rgb.b})),
      diff_line_add: Some(Rgb(${toString p.green.rgb.r}, ${toString p.green.rgb.g}, ${toString p.green.rgb.b})),
      diff_line_delete: Some(Rgb(${toString p.red.rgb.r}, ${toString p.red.rgb.g}, ${toString p.red.rgb.b})),
      diff_file_added: Some(Rgb(${toString p.green.rgb.r}, ${toString p.green.rgb.g}, ${toString p.green.rgb.b})),
      diff_file_removed: Some(Rgb(${toString p.red.rgb.r}, ${toString p.red.rgb.g}, ${toString p.red.rgb.b})),
      diff_file_moved: Some(Rgb(${toString p.blue.rgb.r}, ${toString p.blue.rgb.g}, ${toString p.blue.rgb.b})),
      diff_file_modified: Some(Rgb(${toString p.yellow.rgb.r}, ${toString p.yellow.rgb.g}, ${toString p.yellow.rgb.b})),
      commit_hash: Some(Rgb(${toString p.mauve.rgb.r}, ${toString p.mauve.rgb.g}, ${toString p.mauve.rgb.b})),
      commit_time: Some(Rgb(${toString p.blue.rgb.r}, ${toString p.blue.rgb.g}, ${toString p.blue.rgb.b})),
      commit_author: Some(Rgb(${toString p.green.rgb.r}, ${toString p.green.rgb.g}, ${toString p.green.rgb.b})),
      danger_fg: Some(Rgb(${toString p.red.rgb.r}, ${toString p.red.rgb.g}, ${toString p.red.rgb.b})),
      push_gauge_bg: Some(Rgb(${toString p.blue.rgb.r}, ${toString p.blue.rgb.g}, ${toString p.blue.rgb.b})),
      push_gauge_fg: Some(Rgb(${toString p.base.rgb.r}, ${toString p.base.rgb.g}, ${toString p.base.rgb.b})),
      tag_fg: Some(Rgb(${toString p.yellow.rgb.r}, ${toString p.yellow.rgb.g}, ${toString p.yellow.rgb.b})),
      branch_fg: Some(Rgb(${toString p.teal.rgb.r}, ${toString p.teal.rgb.g}, ${toString p.teal.rgb.b})),
    )
  '';
in

{
  options.themes.gitui = themesLib.mkThemeOption { name = "gitui"; };

  config = lib.mkIf cfg.enable {

    programs.gitui.theme = themeFile;
  };
}
