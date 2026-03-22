{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    attrNames
    foldl'
    hasAttr
    importJSON
    toSentenceCase
    mapAttrs
    mkIf
    mkOption
    optional
    getAttrFromPath
    setAttrByPath
    types
    ;

  palette = config.themes.palette;

  # Generate themes.json from palette — no external build needed
  firefoxPkg = pkgs.callPackage ../../pkgs/firefox/package.nix {
    inherit palette pkgs;
    inherit (config.themes) theme variant;
  };

  themes = importJSON "${firefoxPkg}/themes.json";

  mkFirefoxModule =
    {
      name,
      prettyName ? toSentenceCase name,
      hmModulePath ? [
        "programs"
        name
      ],
    }:
    let
      modulePath = [
        "themes"
        name
      ];

      getAttrStringFromPath = lib.concatStringsSep ".";

      cfg = getAttrFromPath modulePath config;
      firefoxCfg = getAttrFromPath hmModulePath config;

      mkProfileOptions =
        {
          forceDefault ? false,
          enableDefault ? null,
        }:
        let
          baseOpts = themesLib.mkThemeOption {
            inherit name;
            accentSupport = true;
          };
        in
        baseOpts
        // lib.optionalAttrs (enableDefault != null) {
          enable = baseOpts.enable // {
            default = enableDefault;
          };
        }
        // {
          force = mkOption {
            type = types.bool;
            default = forceDefault;
            description = "Forcibly override any existing configuration for Firefox Color.";
            example = true;
          };
        };
    in
    {
      options =
        (setAttrByPath modulePath (
          (mkProfileOptions { })
          // {
            profiles = mkOption {
              type = types.attrsOf (
                types.submodule {
                  options = mkProfileOptions {
                    enableDefault = cfg.enable;
                    forceDefault = cfg.force;
                  };
                  config = {
                    accent = lib.mkDefault cfg.accent;
                  };
                }
              );
              default = mapAttrs (_: _: { }) firefoxCfg.profiles;
              defaultText = "<profiles declared in `${getAttrStringFromPath hmModulePath}.profiles`>";
              description = "themes settings for ${prettyName} profiles.";
            };
          }
        ))
        // (setAttrByPath hmModulePath {
          profiles = mkOption {
            type = types.attrsOf (
              types.submodule (
                { name, ... }:
                let
                  profile = cfg.profiles.${name} or { enable = false; };
                  # Resolve theme data: themes.json is keyed by theme→variant→accent
                  themeData = themes.${config.themes.theme}.${config.themes.variant}.${profile.accent} or null;
                in
                {
                  config = mkIf (profile.enable && themeData != null) {
                    extensions = {
                      settings."FirefoxColor@mozilla.com" = {
                        inherit (profile) force;
                        settings = {
                          firstRunDone = true;
                          theme = themeData;
                        };
                      };
                    };
                  };
                }
              )
            );
          };
        });

      config = {
        warnings = foldl' (
          acc: profileName:
          acc
          ++
            optional (!(hasAttr profileName firefoxCfg.profiles))
              "${prettyName} profile '${profileName}' is defined in '${getAttrStringFromPath modulePath}', but not '${getAttrStringFromPath hmModulePath}'. This will have no effect."
        ) [ ] (attrNames cfg.profiles);
      };
    };
in
{
  imports = map mkFirefoxModule [
    { name = "firefox"; }
    {
      name = "librewolf";
      prettyName = "LibreWolf";
    }
    { name = "floorp"; }
  ];
}
