{ config, lib }:

let
  inherit (lib)
    flip
    mkEnableOption
    mkOption
    optionalAttrs
    types
    ;

  inherit (lib.modules) importApply;
in

lib.makeExtensible (thm: {
  inherit (import ./color-utils.nix { inherit lib; }) mkColor mkAnsi;

  types = {
    theme = types.enum [
      "catppuccin"
      "dracula"
      "everforest"
      "gruvbox"
      "kanagawa"
      "nord"
      "one-dark"
      "rose-pine"
      "solarized"
      "tokyo-night"
    ];

    # Universal accent names (matches catppuccin's set for compatibility)
    accent = types.enum [
      "blue"
      "flamingo"
      "green"
      "lavender"
      "maroon"
      "mauve"
      "peach"
      "pink"
      "red"
      "rosewater"
      "sapphire"
      "sky"
      "teal"
      "yellow"
    ];
  };

  /**
    Creates an attribute set of standard themes module options.

    # Example

    ```nix
    mkThemeOption { name = "fzf"; }
    ```

    # Arguments

    - [name] Name of the module
    - [accentSupport] Add a per-app `accent` override option (defaults to `false`)
  */
  mkThemeOption =
    {
      name,
      accentSupport ? false,
    }:
    {
      enable = mkEnableOption "universal theme for ${name}" // {
        default = config.themes.enable;
        defaultText = "themes.enable";
      };
    }
    // optionalAttrs accentSupport {
      accent = mkOption {
        type = thm.types.accent;
        default = config.themes.accent;
        defaultText = "themes.accent";
        description = "Accent color for ${name}";
      };
    };

  /**
    Strip the leading '#' from a color's hex value.
    Useful for apps that expect hex without the '#' prefix.

    # Example

    ```nix
    themesLib.stripHash palette.base
    => "1e1e2e"
    ```
  */
  stripHash = color: builtins.substring 1 6 color.hex;

  /**
    Imports the given modules with the current themes library.

    # Arguments

    - [modules] List of module paths to import
  */
  applyToModules = map (flip importApply { themesLib = thm; });
})
