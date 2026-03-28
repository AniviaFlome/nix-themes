{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    concatStringsSep
    # TODO: remove or adapt – this removes legacy catppuccin options that do not exist in themes
    mkRemovedOptionModule
    toList
    ;

  cfg = config.themes.gtk;

  # Relative to `catppuccin.gtk`
  removedOptions = [
    "enable"
    "flavor"
    "accent"

    "gnomeShellTheme"
    "size"
    "tweaks"
  ];

  removedOptionModules = map (
    optionPath:

    let
      attrPath = [
        "catppuccin"
        "gtk"
      ]
      ++ toList optionPath;
      moduleName = concatStringsSep "." attrPath;
    in

    # TODO: remove or adapt – this removes legacy catppuccin options that do not exist in themes
    mkRemovedOptionModule attrPath ''
      `${moduleName}` was removed from catppuccin/nix, as the upstream port has been archived and began experiencing breakages.

      Please see https://github.com/catppuccin/gtk/issues/262
    ''
  ) removedOptions;
in

{
  imports = removedOptionModules;

  options.themes.gtk = {
    icon = themesLib.mkThemeOption {
      name = "GTK modified Papirus icon theme";

      accentSupport = true;
    };
  };

  config = lib.mkIf cfg.icon.enable {
    gtk.iconTheme =
      let
        # use the light icon theme for latte
        polarity = if cfg.icon.flavor == "latte" then "Light" else "Dark";
      in
      {
        name = "Papirus-${polarity}";
        package = pkgs.catppuccin-papirus-folders.override { inherit (cfg.icon) accent flavor; };
      };
  };
}
