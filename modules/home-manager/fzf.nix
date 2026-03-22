{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.fzf;
  palette = config.themes.palette;
  accent = cfg.accent;

  colors = lib.attrsets.mapAttrs (_: colorName: palette.${colorName}.hex) {
    "bg+" = "surface0";
    bg = "base";
    spinner = "rosewater";
    hl = accent;
    fg = "text";
    header = accent;
    info = accent;
    pointer = accent;
    marker = accent;
    "fg+" = "text";
    prompt = accent;
    "hl+" = accent;
  };
in

{
  options.themes.fzf = themesLib.mkThemeOption {
    name = "fzf";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.fzf = { inherit colors; };
  };
}
