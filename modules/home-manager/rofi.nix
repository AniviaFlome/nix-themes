{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.rofi;
  p = config.themes.palette;
  enable = cfg.enable && config.programs.rofi.enable;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;

  # Generate a self-contained rofi .rasi theme from the palette
  themeFile = pkgs.writeText "nix-themes-rofi.rasi" ''
    * {
      /* nix-themes: ${config.themes.theme}/${config.themes.variant} */
      t-base:      ${p.base.hex};
      t-mantle:    ${p.mantle.hex};
      t-crust:     ${p.crust.hex};
      t-surface0:  ${p.surface0.hex};
      t-surface1:  ${p.surface1.hex};
      t-surface2:  ${p.surface2.hex};
      t-overlay0:  ${p.overlay0.hex};
      t-subtext0:  ${p.subtext0.hex};
      t-subtext1:  ${p.subtext1.hex};
      t-text:      ${p.text.hex};
      t-accent:    ${accentColor};
      t-red:       ${p.red.hex};
      t-green:     ${p.green.hex};

      background-color: @t-base;
      border-color:     @t-accent;
      text-color:       @t-text;
    }
    window {
      background-color: @t-base;
      border: 2px;
      border-color: @t-accent;
    }
    mainbox { background-color: @t-base; }
    inputbar {
      background-color: @t-surface0;
      text-color: @t-text;
      border: 0 0 2px 0;
      border-color: @t-accent;
    }
    listview { background-color: @t-base; }
    element {
      background-color: @t-base;
      text-color: @t-text;
    }
    element selected {
      background-color: @t-surface1;
      text-color: @t-accent;
    }
    element-text {
      background-color: inherit;
      text-color: inherit;
    }
    prompt { text-color: @t-accent; }
    entry { text-color: @t-text; }
    message {
      background-color: @t-surface0;
      text-color: @t-text;
    }
  '';
in

{
  options.themes.rofi = themesLib.mkThemeOption {
    name = "rofi";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    xdg.dataFile."rofi/themes/nix-themes.rasi".source = themeFile;

    programs.rofi.theme = "${config.xdg.dataHome}/rofi/themes/nix-themes.rasi";
  };
}
