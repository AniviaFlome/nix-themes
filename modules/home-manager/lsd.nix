{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.lsd;
  p = config.themes.palette;

  # lsd color theme is a YAML file
  # We generate it using pkgs.writeText and put it in the lsd config dir
  themeContent = pkgs.writeText "nix-themes-lsd.yaml" ''
    # nix-themes: ${config.themes.theme}/${config.themes.variant}
    user: ${p.blue.hex}
    group: ${p.blue.hex}
    permission:
      read: ${p.green.hex}
      write: ${p.yellow.hex}
      exec: ${p.red.hex}
      exec-sticky: ${p.mauve.hex}
      no-access: ${p.overlay0.hex}
      octal: ${p.overlay1.hex}
      acl: ${p.blue.hex}
      context: ${p.teal.hex}
    date:
      hour-old: ${p.text.hex}
      day-old: ${p.subtext1.hex}
      older: ${p.subtext0.hex}
    size:
      none: ${p.overlay0.hex}
      small: ${p.green.hex}
      medium: ${p.yellow.hex}
      large: ${p.red.hex}
    inode:
      valid: ${p.blue.hex}
      invalid: ${p.red.hex}
    links:
      valid: ${p.blue.hex}
      invalid: ${p.red.hex}
    tree-edge: ${p.overlay0.hex}
    git-status:
      default: ${p.overlay0.hex}
      unmodified: ${p.text.hex}
      ignored: ${p.overlay0.hex}
      new-in-index: ${p.green.hex}
      new-in-workdir: ${p.green.hex}
      typechange: ${p.yellow.hex}
      deleted: ${p.red.hex}
      renamed: ${p.blue.hex}
      modified: ${p.yellow.hex}
      staged: ${p.green.hex}
      conflicted: ${p.red.hex}
  '';
in

{
  options.themes.lsd = themesLib.mkThemeOption { name = "lsd"; };

  config = lib.mkIf cfg.enable {

    xdg.configFile."lsd/colors.yaml".source = themeContent;

    programs.lsd.settings.color.theme = "custom";
  };
}
