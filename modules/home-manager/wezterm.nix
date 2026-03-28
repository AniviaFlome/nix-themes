{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.wezterm;
  theme = config.themes.theme;
  p = config.themes.palette;
  ansi = p.ansi;

  # catppuccin/wezterm uses surface1/surface2 for black/bright-black, selection_fg=text, active_tab=lavender/crust
  isCatppuccin = theme == "catppuccin";
in

{
  options.themes.wezterm = themesLib.mkThemeOption { name = "wezterm"; };

  config = lib.mkIf cfg.enable {

    programs.wezterm.extraConfig = ''
      -- nix-themes: ${config.themes.theme}/${config.themes.variant}
      local nix_themes_colors = {
        foreground    = "${p.text.hex}",
        background    = "${p.base.hex}",
        cursor_bg     = "${p.rosewater.hex}",
        cursor_fg     = "${p.base.hex}",
        cursor_border = "${p.rosewater.hex}",
        selection_fg  = "${if isCatppuccin then p.text.hex else p.base.hex}",
        selection_bg  = "${if isCatppuccin then p.surface1.hex else p.surface2.hex}",
        scrollbar_thumb = "${p.surface1.hex}",
        split         = "${p.overlay0.hex}",
        ansi = {
          "${if isCatppuccin then p.surface1.hex else ansi.black.normal.hex}",
          "${ansi.red.normal.hex}",
          "${ansi.green.normal.hex}",
          "${ansi.yellow.normal.hex}",
          "${ansi.blue.normal.hex}",
          "${ansi.magenta.normal.hex}",
          "${ansi.cyan.normal.hex}",
          "${ansi.white.normal.hex}",
        },
        brights = {
          "${if isCatppuccin then p.surface2.hex else ansi.black.bright.hex}",
          "${ansi.red.bright.hex}",
          "${ansi.green.bright.hex}",
          "${ansi.yellow.bright.hex}",
          "${ansi.blue.bright.hex}",
          "${ansi.magenta.bright.hex}",
          "${ansi.cyan.bright.hex}",
          "${ansi.white.bright.hex}",
        },
        tab_bar = {
          background = "${p.crust.hex}",
          active_tab = { bg_color = "${
            if isCatppuccin then p.lavender.hex else p.base.hex
          }", fg_color = "${if isCatppuccin then p.crust.hex else p.text.hex}" },
          inactive_tab = { bg_color = "${p.mantle.hex}", fg_color = "${p.subtext0.hex}" },
          inactive_tab_hover = { bg_color = "${p.surface0.hex}", fg_color = "${p.subtext1.hex}" },
          new_tab = { bg_color = "${p.crust.hex}", fg_color = "${p.subtext0.hex}" },
          new_tab_hover = { bg_color = "${p.surface0.hex}", fg_color = "${p.text.hex}" },
        },
      }
      local config_obj = wezterm.config_builder and wezterm.config_builder() or {}
      config_obj.colors = nix_themes_colors
      return config_obj
    '';
  };
}
