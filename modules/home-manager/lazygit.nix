{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.lazygit;
  theme = config.themes.theme;
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

  # catppuccin/lazygit uses different colors for several fields
  mkThemeYaml =
    {
      inactiveBorderColor,
      selectedBgColor,
      cherryPickedBgColor,
      authorColor,
      extraLines ? "",
    }:
    ''
      # nix-themes: ${config.themes.theme}/${config.themes.variant}
      gui:
        theme:
          activeBorderColor:
            - '${accentColor}'
            - bold
          inactiveBorderColor:
            - '${inactiveBorderColor}'
          optionsTextColor:
            - '${p.blue.hex}'
          selectedLineBgColor:
            - '${selectedBgColor}'
          selectedRangeBgColor:
            - '${selectedBgColor}'
          cherryPickedCommitBgColor:
            - '${cherryPickedBgColor}'
          cherryPickedCommitFgColor:
            - '${accentColor}'
          unstagedChangesColor:
            - '${p.red.hex}'
          defaultFgColor:
            - '${p.text.hex}'${extraLines}
        authorColors:
          '*': '${authorColor}'
    '';

  themeFile = pkgs.writeText "nix-themes-lazygit.yml" (
    if theme == "catppuccin" then
      mkThemeYaml {
        inactiveBorderColor = p.subtext0.hex;
        selectedBgColor = p.surface0.hex;
        cherryPickedBgColor = p.surface1.hex;
        authorColor = p.lavender.hex;
        extraLines = "\n    searchingActiveBorderColor:\n      - '${p.yellow.hex}'";
      }
    else
      mkThemeYaml {
        inactiveBorderColor = p.overlay0.hex;
        selectedBgColor = p.surface1.hex;
        cherryPickedBgColor = p.teal.hex;
        authorColor = p.mauve.hex;
      }
  );
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
