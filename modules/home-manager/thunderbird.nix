{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  # TODO: sources removed – generate theme content inline from config.themes.palette
  cfg = config.themes.thunderbird;
  enable = cfg.enable && config.programs.thunderbird.enable;
in
{
  options.themes.thunderbird =
    themesLib.mkThemeOption {
      name = "thunderbird";
      accentSupport = true;
    }
    // {
      profile = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-${cfg.flavor}-${cfg.accent}"; # TODO: flavor → variant; verify palette supports this variant
        description = "The profile name";
      };
    };

  config = lib.mkIf enable {
    programs.thunderbird = {
      profiles."${cfg.profile}".extensions = [
        (pkgs.runCommandLocal "catppuccin-${cfg.flavor}-${cfg.accent}.thunderbird.theme" # TODO: flavor → variant; verify palette supports this variant
          {
            buildInputs = [ sources.thunderbird ]; # TODO: replace with inline palette-based generation
            nativeBuildInputs = with pkgs; [
              jq
              unzip
            ];
          }
          ''
            xpi=${sources.thunderbird}/${cfg.flavor}/${cfg.flavor}-${cfg.accent}.xpi # TODO: replace with inline palette-based generation # TODO: flavor → variant; verify palette supports this variant
            extId=$(unzip -qc $xpi manifest.json | jq -r .applications.gecko.id)
            # The extensions path shared by all profiles.
            extensionPath="extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            install -Dv $xpi $out/share/mozilla/$extensionPath/$extId.xpi
          ''
        )
      ];
    };
  };
}
