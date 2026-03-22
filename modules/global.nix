{ themesModules }:
{
  config,
  lib,
  ...
}:

let
  themesLib = import ./lib { inherit config lib; };

  allPalettes = {
    catppuccin = import ../palettes/catppuccin.nix { inherit themesLib; };
    dracula = import ../palettes/dracula.nix { inherit themesLib; };
    everforest = import ../palettes/everforest.nix { inherit themesLib; };
    gruvbox = import ../palettes/gruvbox.nix { inherit themesLib; };
    kanagawa = import ../palettes/kanagawa.nix { inherit themesLib; };
    nord = import ../palettes/nord.nix { inherit themesLib; };
    one-dark = import ../palettes/one-dark.nix { inherit themesLib; };
    rose-pine = import ../palettes/rose-pine.nix { inherit themesLib; };
    solarized = import ../palettes/solarized.nix { inherit themesLib; };
    tokyo-night = import ../palettes/tokyo-night.nix { inherit themesLib; };
  };

  cfg = config.themes;
in

{
  imports = themesLib.applyToModules themesModules;

  options.themes = {
    enable = lib.mkEnableOption "universal theming";

    theme = lib.mkOption {
      type = themesLib.types.theme;
      default = "catppuccin";
      description = "Color theme to use";
    };

    variant = lib.mkOption {
      type = lib.types.str;
      default = "mocha";
      description = ''
        Theme variant to use. Available variants depend on the selected theme:

        - catppuccin: latte, frappe, macchiato, mocha
        - dracula: default, alucard
        - everforest: dark-hard, dark-medium, dark-soft, light-hard, light-medium, light-soft
        - gruvbox: dark-hard, dark-medium, dark-soft, light-hard, light-medium, light-soft
        - kanagawa: wave, dragon, lotus
        - nord: dark
        - one-dark: dark, light
        - rose-pine: main, moon, dawn
        - solarized: dark, light
        - tokyo-night: storm, night, moon, day
      '';
    };

    accent = lib.mkOption {
      type = themesLib.types.accent;
      default = "blue";
      description = "Global accent color (used by modules that support accent overrides)";
    };

    palette = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = ''
        The resolved color palette for the current theme and variant.

        Each color is an attrset: `{ hex = "#rrggbb"; rgb = { r, g, b }; }`

        Available top-level keys:
        crust, mantle, base, surface0, surface1, surface2,
        overlay0, overlay1, overlay2, subtext0, subtext1, text,
        rosewater, flamingo, pink, mauve, red, maroon, peach,
        yellow, green, teal, sky, sapphire, blue, lavender,
        ansi (with black, red, green, yellow, blue, magenta, cyan, white;
              each having .normal and .bright)

        Can be overridden to supply a custom palette.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    themes.palette =
      let
        themePalettes =
          allPalettes.${cfg.theme}
            or (throw "themes: unknown theme '${cfg.theme}'. Available: ${lib.concatStringsSep ", " (lib.attrNames allPalettes)}");
        resolved =
          themePalettes.${cfg.variant}
            or (throw "themes: unknown variant '${cfg.variant}' for theme '${cfg.theme}'");
      in
      resolved;
  };
}
