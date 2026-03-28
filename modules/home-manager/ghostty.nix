{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.ghostty;
  theme = config.themes.theme;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  ansi = p.ansi;

  isCatppuccin = theme == "catppuccin";

  # Ghostty palette format: N=RRGGBB (0-15)
  # catppuccin/ghostty uses surface1/surface2 for black/bright-black and subtext0/subtext1 for white/bright-white
  paletteEntries = lib.concatStringsSep "\n" (
    lib.imap0 (i: hex: "palette = ${toString i}=${hex}") [
      (sh (if isCatppuccin then p.surface1 else ansi.black.normal))
      (sh ansi.red.normal)
      (sh ansi.green.normal)
      (sh ansi.yellow.normal)
      (sh ansi.blue.normal)
      (sh ansi.magenta.normal)
      (sh ansi.cyan.normal)
      (sh (if isCatppuccin then p.subtext0 else ansi.white.normal))
      (sh (if isCatppuccin then p.surface2 else ansi.black.bright))
      (sh ansi.red.bright)
      (sh ansi.green.bright)
      (sh ansi.yellow.bright)
      (sh ansi.blue.bright)
      (sh ansi.magenta.bright)
      (sh ansi.cyan.bright)
      (sh (if isCatppuccin then p.subtext1 else ansi.white.bright))
    ]
  );

  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";

  themeConf = pkgs.writeText "ghostty-nix-themes.conf" ''
    background = ${sh p.base}
    foreground = ${sh p.text}
    cursor-color = ${sh p.rosewater}
    ${lib.optionalString isCatppuccin "cursor-text = ${sh p.crust}"}
    selection-background = ${sh (if isCatppuccin then p.surface1 else p.surface2)}
    selection-foreground = ${sh p.text}
    ${lib.optionalString isCatppuccin "split-divider-color = ${sh p.surface0}"}
    ${paletteEntries}
  '';
in

{
  options.themes.ghostty = themesLib.mkThemeOption { name = "ghostty"; };

  config = lib.mkIf (cfg.enable && config.programs.ghostty.enable) {

    xdg.configFile."ghostty/themes/${themeName}".source = themeConf;

    programs.ghostty.settings = {
      theme = themeName;
    };
  };
}
