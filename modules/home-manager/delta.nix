{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.delta;
  theme = config.themes.theme;
  variant = config.themes.variant;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.delta.enable;

  # catppuccin/delta uses blended hex colors for diff backgrounds (not palette colors)
  catppuccinBlended = {
    latte = {
      minusBg = "#e9c4cf";
      minusEmphBg = "#e5a2b3";
      plusBg = "#cce1cd";
      plusEmphBg = "#b2d5ae";
      mapPurple = "#cbb1f2";
      mapBlue = "#a6c1f5";
      mapCyan = "#9dd7ef";
      mapYellow = "#eacfa9";
      syntaxTheme = "Catppuccin Latte";
    };
    frappe = {
      minusBg = "#544452";
      minusEmphBg = "#704f5c";
      plusBg = "#475453";
      plusEmphBg = "#596b5e";
      mapPurple = "#66597e";
      mapBlue = "#505d81";
      mapCyan = "#546b7a";
      mapYellow = "#6f6860";
      syntaxTheme = "Catppuccin Frappe";
    };
    macchiato = {
      minusBg = "#4c3a4c";
      minusEmphBg = "#6a485a";
      plusBg = "#3e4b4c";
      plusEmphBg = "#51655a";
      mapPurple = "#5c517c";
      mapBlue = "#47557b";
      mapCyan = "#4a6475";
      mapYellow = "#6a635d";
      syntaxTheme = "Catppuccin Macchiato";
    };
    mocha = {
      minusBg = "#493447";
      minusEmphBg = "#694559";
      plusBg = "#394545";
      plusEmphBg = "#4e6356";
      mapPurple = "#5b4e74";
      mapBlue = "#445375";
      mapCyan = "#446170";
      mapYellow = "#6b635b";
      syntaxTheme = "Catppuccin Mocha";
    };
  };
  cb = catppuccinBlended.${variant} or catppuccinBlended.mocha;
in

{
  options.themes.delta = themesLib.mkThemeOption { name = "delta"; };

  config = lib.mkIf enable (
    lib.mkMerge [
      {
        programs.delta.options = {
          blame-palette = "${p.base.hex} ${p.mantle.hex} ${p.crust.hex} ${p.surface0.hex} ${p.surface1.hex}";
          commit-decoration-style = "${p.overlay0.hex} bold box ul";
          file-decoration-style = p.overlay0.hex;
          file-style = p.text.hex;
          hunk-header-decoration-style = "${p.overlay0.hex} box ul";
          hunk-header-file-style = "bold";
          hunk-header-line-number-style = lib.mkDefault "bold ${p.subtext1.hex}";
          hunk-header-style = "file line-number syntax";
          line-numbers-left-style = p.overlay0.hex;
          line-numbers-minus-style = lib.mkDefault "bold ${p.red.hex}";
          line-numbers-plus-style = lib.mkDefault "bold ${p.green.hex}";
          line-numbers-right-style = p.overlay0.hex;
          line-numbers-zero-style = p.overlay0.hex;
          minus-emph-style = lib.mkDefault "bold syntax ${p.surface1.hex}";
          minus-style = lib.mkDefault "syntax ${p.surface0.hex}";
          plus-emph-style = lib.mkDefault "bold syntax ${p.surface1.hex}";
          plus-style = lib.mkDefault "syntax ${p.surface0.hex}";
          map-styles = lib.mkDefault (
            lib.concatStringsSep ", " [
              "bold purple => syntax ${p.mauve.hex}"
              "bold blue => syntax ${p.blue.hex}"
              "bold cyan => syntax ${p.teal.hex}"
              "bold yellow => syntax ${p.yellow.hex}"
            ]
          );
        };
      }

      # catppuccin/delta uses blended diff backgrounds and the bat catppuccin syntax theme
      (lib.mkIf (theme == "catppuccin") {
        programs.delta.options = {
          hunk-header-line-number-style = "bold ${p.overlay0.hex}";
          line-numbers-minus-style = p.red.hex;
          line-numbers-plus-style = p.green.hex;
          minus-style = "syntax ${cb.minusBg}";
          minus-emph-style = "bold syntax ${cb.minusEmphBg}";
          plus-style = "syntax ${cb.plusBg}";
          plus-emph-style = "bold syntax ${cb.plusEmphBg}";
          map-styles = lib.concatStringsSep ", " [
            "bold purple => syntax ${cb.mapPurple}"
            "bold blue => syntax ${cb.mapBlue}"
            "bold cyan => syntax ${cb.mapCyan}"
            "bold yellow => syntax ${cb.mapYellow}"
          ];
          syntax-theme = cb.syntaxTheme;
        };
      })
    ]
  );
}
