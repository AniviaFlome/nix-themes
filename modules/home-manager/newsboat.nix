{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.newsboat;
  p = config.themes.palette;

  colorConfig = ''
    # nix-themes: ${config.themes.theme}/${config.themes.variant}
    color background          default  default
    color listnormal          default  default
    color listnormal_unread   color2   default  bold
    color listfocus           default  color0
    color listfocus_unread    color2   color0   bold
    color info                color6   color0
    color article             default  default
    highlight article "^(Feed|Link|Author|Date|Title):.*$" color6 default bold
    highlight article "https?://[^ ]+" color4 default underline
    highlight article "^Title: .*$" color5 default bold
  '';
in

{
  options.themes.newsboat = themesLib.mkThemeOption { name = "newsboat"; };

  config = lib.mkIf cfg.enable {

    programs.newsboat.extraConfig = colorConfig;
  };
}
