{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.delta;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  enable = cfg.enable && config.programs.delta.enable;
in

{
  options.themes.delta = themesLib.mkThemeOption { name = "delta"; };

  config = lib.mkIf enable {

    programs.delta.options = {
      blame-palette = "${p.base.hex} ${p.mantle.hex} ${p.crust.hex} ${p.surface0.hex} ${p.surface1.hex}";
      commit-decoration-style = "${p.overlay0.hex} bold box ul";
      file-decoration-style = p.overlay0.hex;
      file-style = p.text.hex;
      hunk-header-decoration-style = "${p.overlay0.hex} box ul";
      hunk-header-file-style = "bold";
      hunk-header-line-number-style = "bold ${p.subtext1.hex}";
      hunk-header-style = "file line-number syntax";
      line-numbers-left-style = p.overlay0.hex;
      line-numbers-minus-style = "bold ${p.red.hex}";
      line-numbers-plus-style = "bold ${p.green.hex}";
      line-numbers-right-style = p.overlay0.hex;
      line-numbers-zero-style = p.overlay0.hex;
      minus-emph-style = "bold syntax ${p.surface1.hex}";
      minus-style = "syntax ${p.surface0.hex}";
      plus-emph-style = "bold syntax ${p.surface1.hex}";
      plus-style = "syntax ${p.surface0.hex}";
      map-styles = lib.concatStringsSep ", " [
        "bold purple => syntax ${p.mauve.hex}"
        "bold blue => syntax ${p.blue.hex}"
        "bold cyan => syntax ${p.teal.hex}"
        "bold yellow => syntax ${p.yellow.hex}"
      ];
    };
  };
}
