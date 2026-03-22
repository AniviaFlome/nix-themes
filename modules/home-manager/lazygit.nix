{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.lazygit;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.lazygit.enable;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;

  # NOTE: On macOS, lazygit uses ~/Library/Application Support when not using XDG
  enableXdgConfig = !pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable;
  configDirectory =
    if enableXdgConfig then
      config.xdg.configHome
    else
      "${config.home.homeDirectory}/Library/Application Support";
  userConfigFile = "${configDirectory}/lazygit/config.yml";

  themeFile = pkgs.writeText "nix-themes-lazygit.yml" ''
    # nix-themes: ${config.themes.theme}/${config.themes.variant}
    gui:
      theme:
        activeBorderColor:
          - '${accentColor}'
          - bold
        inactiveBorderColor:
          - '${p.overlay0.hex}'
        optionsTextColor:
          - '${p.blue.hex}'
        selectedLineBgColor:
          - '${p.surface1.hex}'
        selectedRangeBgColor:
          - '${p.surface1.hex}'
        cherryPickedCommitBgColor:
          - '${p.teal.hex}'
        cherryPickedCommitFgColor:
          - '${accentColor}'
        unstagedChangesColor:
          - '${p.red.hex}'
        defaultFgColor:
          - '${p.text.hex}'
      authorColors:
        '*': '${p.mauve.hex}'
  '';
in

{
  options.themes.lazygit = themesLib.mkThemeOption {
    name = "lazygit";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    home.sessionVariables.LG_CONFIG_FILE = lib.concatStringsSep "," (
      [ "${themeFile}" ] ++ lib.optional (config.programs.lazygit.settings != { }) userConfigFile
    );
  };
}
