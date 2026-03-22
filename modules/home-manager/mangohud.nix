{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.mangohud;
  p = config.themes.palette;
  sh = themesLib.stripHash;
  enable = cfg.enable && config.programs.mangohud.enable;
in

{
  options.themes.mangohud = themesLib.mkThemeOption { name = "mangohud"; };

  config = lib.mkIf enable {

    programs.mangohud.settings = {
      background_color = sh p.base;
      text_color = sh p.text;
      gpu_color = sh p.green;
      cpu_color = sh p.blue;
      ram_color = sh p.pink;
      vram_color = sh p.mauve;
      engine_color = sh p.red;
      io_color = sh p.teal;
      frametime_color = sh p.green;
      wine_color = sh p.red;
      media_player_color = sh p.text;
      network_color = sh p.sapphire;
      battery_color = sh p.yellow;
    };
  };
}
