{ themesLib }:
{
  config,
  lib,
  ...
}:

let
  # TODO: sources removed – generate theme content inline from config.themes.palette

  cfg = config.themes.cursors;

  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = lib.types.mergeTypes themesLib.types.accent (
    lib.types.enum [
      "dark"
      "light"
    ]
  );
in

{
  options.themes.cursors =
    themesLib.mkThemeOption {
      name = "pointer cursors";
      # NOTE: We exclude this as there is no `enable` option in the upstream
      # module to guard it
      useGlobalEnable = false;
    }
    // {
      accent = lib.mkOption {
        type = cursorAccentType;
        default = config.catppuccin.accent;
        description = "Catppuccin accent for pointer cursors";
      };
    };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      name = "catppuccin-${cfg.flavor}-${cfg.accent}-cursors"; # TODO: flavor → variant; verify palette supports this variant
      package = sources.cursors."${cfg.flavor}${lib.toSentenceCase cfg.accent}"; # TODO: replace with inline palette-based generation # TODO: flavor → variant; verify palette supports this variant
    };
  };
}
