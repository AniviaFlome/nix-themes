{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.micro;
  p = config.themes.palette;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";
  enable = cfg.enable && config.programs.micro.enable;
in

{
  options.themes.micro = themesLib.mkThemeOption { name = "micro"; };

  config = lib.mkIf enable {

    programs.micro.settings.colorscheme = themeName;

    xdg.configFile."micro/colorschemes/${themeName}.micro".text = ''
      color-link default "${p.text.hex},${p.base.hex}"
      color-link comment "${p.overlay2.hex}"
      color-link selection "${p.text.hex},${p.surface1.hex}"
      color-link hlsearch "${p.teal.hex}"

      color-link identifier "${p.blue.hex}"
      color-link identifier.class "${p.blue.hex}"
      color-link identifier.var "${p.blue.hex}"

      color-link constant "${p.peach.hex}"
      color-link constant.number "${p.peach.hex}"
      color-link constant.string "${p.green.hex}"

      color-link symbol "${p.pink.hex}"
      color-link symbol.brackets "${p.flamingo.hex}"
      color-link symbol.tag "${p.blue.hex}"

      color-link type "${p.blue.hex}"
      color-link type.keyword "${p.yellow.hex}"

      color-link special "${p.pink.hex}"
      color-link statement "${p.mauve.hex}"
      color-link preproc "${p.pink.hex}"

      color-link underlined "${p.sky.hex}"
      color-link error "bold ${p.red.hex}"
      color-link todo "bold ${p.yellow.hex}"

      color-link diff-added "${p.green.hex}"
      color-link diff-modified "${p.yellow.hex}"
      color-link diff-deleted "${p.red.hex}"

      color-link gutter-error "${p.red.hex}"
      color-link gutter-warning "${p.yellow.hex}"

      color-link scrollbar "${p.overlay2.hex}"
      color-link statusline "${p.text.hex},${p.mantle.hex}"
      color-link tabbar "${p.text.hex},${p.mantle.hex}"
      color-link indent-char "${p.surface1.hex}"
      color-link line-number "${p.surface1.hex}"
      color-link current-line-number "${p.lavender.hex}"

      color-link cursor-line "${p.surface0.hex},${p.text.hex}"
      color-link color-column "${p.surface0.hex}"
      color-link type.extended "default"
    '';
  };
}
