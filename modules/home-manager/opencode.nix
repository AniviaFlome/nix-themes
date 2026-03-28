{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.opencode;
  enable = cfg.enable && config.programs.opencode.enable;

  # Map Catppuccin flavors to OpenCode's available theme names
  # OpenCode provides: "catppuccin", "catppuccin-frappe", "catppuccin-macchiato"
  themeName =
    if cfg.flavor == "frappe" then # TODO: flavor → variant; verify palette supports this variant
      "catppuccin-frappe"
    else if cfg.flavor == "macchiato" then # TODO: flavor → variant; verify palette supports this variant
      "catppuccin-macchiato"
    else
      "catppuccin"; # Default for mocha and latte
in

{
  options.themes.opencode = themesLib.mkThemeOption { name = "opencode"; };
  config = lib.mkIf enable {
    programs.opencode.settings = {
      theme = themeName;
    };
  };
}
