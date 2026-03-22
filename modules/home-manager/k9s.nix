{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.k9s;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.k9s.enable;

  # On macOS without XDG, k9s uses ~/Library/Application Support
  enableXdgConfig = !pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable;

  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";
  themeFile = "${themeName}.yaml";
  themePath = "k9s/skins/${themeFile}";

  themeContent = ''
    k9s:
      body:
        fgColor: '${p.text.hex}'
        bgColor: '${p.base.hex}'
        logoColor: '${p.mauve.hex}'
      prompt:
        fgColor: '${p.text.hex}'
        bgColor: '${p.mantle.hex}'
        suggestColor: '${p.blue.hex}'
      help:
        fgColor: '${p.text.hex}'
        bgColor: '${p.base.hex}'
        sectionColor: '${p.green.hex}'
        keyColor: '${p.blue.hex}'
        numKeyColor: '${p.maroon.hex}'
      frame:
        title:
          fgColor: '${p.teal.hex}'
          bgColor: '${p.base.hex}'
          highlightColor: '${p.pink.hex}'
          counterColor: '${p.yellow.hex}'
          filterColor: '${p.green.hex}'
        border:
          fgColor: '${p.mauve.hex}'
          focusColor: '${p.lavender.hex}'
        menu:
          fgColor: '${p.text.hex}'
          keyColor: '${p.blue.hex}'
          numKeyColor: '${p.maroon.hex}'
        crumbs:
          fgColor: '${p.base.hex}'
          bgColor: '${p.maroon.hex}'
          activeColor: '${p.flamingo.hex}'
        status:
          newColor: '${p.blue.hex}'
          modifyColor: '${p.lavender.hex}'
          addColor: '${p.green.hex}'
          pendingColor: '${p.peach.hex}'
          errorColor: '${p.red.hex}'
          highlightColor: '${p.sky.hex}'
          killColor: '${p.mauve.hex}'
          completedColor: '${p.overlay0.hex}'
      info:
        fgColor: '${p.peach.hex}'
        sectionColor: '${p.text.hex}'
      views:
        table:
          fgColor: '${p.text.hex}'
          bgColor: '${p.base.hex}'
          cursorFgColor: '${p.surface0.hex}'
          cursorBgColor: '${p.surface1.hex}'
          markColor: '${p.rosewater.hex}'
          header:
            fgColor: '${p.yellow.hex}'
            bgColor: '${p.base.hex}'
            sorterColor: '${p.sky.hex}'
        xray:
          fgColor: '${p.text.hex}'
          bgColor: '${p.base.hex}'
          cursorColor: '${p.surface1.hex}'
          cursorTextColor: '${p.base.hex}'
          graphicColor: '${p.pink.hex}'
        charts:
          bgColor: '${p.base.hex}'
          chartBgColor: '${p.base.hex}'
          dialBgColor: '${p.base.hex}'
          defaultDialColors:
            - '${p.green.hex}'
            - '${p.red.hex}'
          defaultChartColors:
            - '${p.green.hex}'
            - '${p.red.hex}'
          resourceColors:
            cpu:
              - '${p.mauve.hex}'
              - '${p.blue.hex}'
            mem:
              - '${p.yellow.hex}'
              - '${p.peach.hex}'
        yaml:
          keyColor: '${p.blue.hex}'
          valueColor: '${p.text.hex}'
          colonColor: '${p.subtext0.hex}'
        logs:
          fgColor: '${p.text.hex}'
          bgColor: '${p.base.hex}'
          indicator:
            fgColor: '${p.lavender.hex}'
            bgColor: '${p.base.hex}'
            toggleOnColor: '${p.green.hex}'
            toggleOffColor: '${p.subtext0.hex}'
      dialog:
        fgColor: '${p.yellow.hex}'
        bgColor: '${p.overlay2.hex}'
        buttonFgColor: '${p.base.hex}'
        buttonBgColor: '${p.overlay1.hex}'
        buttonFocusFgColor: '${p.base.hex}'
        buttonFocusBgColor: '${p.pink.hex}'
        labelFgColor: '${p.rosewater.hex}'
        fieldFgColor: '${p.text.hex}'
  '';
in

{
  options.themes.k9s = themesLib.mkThemeOption { name = "k9s"; };

  config = lib.mkIf enable (
    lib.mkMerge [
      {
        programs.k9s.settings.k9s.ui.skin = themeName;
      }

      (lib.mkIf (!enableXdgConfig) {
        home.file."Library/Application Support/${themePath}".text = themeContent;
      })

      (lib.mkIf enableXdgConfig {
        xdg.configFile.${themePath}.text = themeContent;
      })
    ]
  );
}
