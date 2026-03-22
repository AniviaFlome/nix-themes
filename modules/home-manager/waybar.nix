{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.waybar;
  palette = config.themes.palette;
  accent = cfg.accent;

  # Generate CSS custom properties for all palette colors
  # All variables use the prefix --t- to avoid conflicts
  cssVars = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: color: "  --t-${name}: ${color.hex};") (
      lib.filterAttrs (n: _: n != "ansi" && n != "meta") palette
    )
  );

  themeCSS = ''
    /** nix-themes: ${config.themes.theme}/${config.themes.variant} **/
    * {
    ${cssVars}
      --t-accent: var(--t-${accent});
    }
  '';
in

{
  options.themes.waybar =
    themesLib.mkThemeOption {
      name = "waybar";
      accentSupport = true;
    }
    // {
      mode = lib.mkOption {
        type = lib.types.enum [
          "prependStyle"
          "createFile"
        ];
        default = "prependStyle";
        description = ''
          How to include the theme CSS:

          - `prependStyle`: Prepends CSS variables to `programs.waybar.style`.
          - `createFile`: Writes variables to `~/.config/waybar/nix-themes.css`,
            which you can `@import` in your own stylesheet.
        '';
      };
    };

  config = lib.mkIf (cfg.enable && config.programs.waybar.enable) {

    programs.waybar = lib.mkIf (cfg.mode == "prependStyle") {
      style = lib.mkBefore themeCSS;
    };

    xdg.configFile = lib.mkIf (cfg.mode == "createFile") {
      "waybar/nix-themes.css".text = themeCSS;
    };
  };
}
