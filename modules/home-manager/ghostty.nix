{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.ghostty;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  ansi = p.ansi;

  # Ghostty palette format: N=RRGGBB (0-15)
  paletteEntries = lib.concatStringsSep "\n" (
    lib.imap0 (i: hex: "palette = ${toString i}=${hex}") [
      (sh ansi.black.normal)
      (sh ansi.red.normal)
      (sh ansi.green.normal)
      (sh ansi.yellow.normal)
      (sh ansi.blue.normal)
      (sh ansi.magenta.normal)
      (sh ansi.cyan.normal)
      (sh ansi.white.normal)
      (sh ansi.black.bright)
      (sh ansi.red.bright)
      (sh ansi.green.bright)
      (sh ansi.yellow.bright)
      (sh ansi.blue.bright)
      (sh ansi.magenta.bright)
      (sh ansi.cyan.bright)
      (sh ansi.white.bright)
    ]
  );

  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";

  themeConf = pkgs.writeText "ghostty-nix-themes.conf" ''
    background = ${sh p.base}
    foreground = ${sh p.text}
    cursor-color = ${sh p.rosewater}
    selection-background = ${sh p.surface2}
    selection-foreground = ${sh p.text}
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
