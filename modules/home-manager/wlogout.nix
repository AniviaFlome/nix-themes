{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.wlogout;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;

  themeCSS = ''
    /* nix-themes: ${config.themes.theme}/${config.themes.variant} */
    * {
      background-image: none;
      background-color: transparent;
      color: ${p.text.hex};
    }
    window {
      background-color: alpha(${p.base.hex}, 0.9);
    }
    button {
      background-color: ${p.surface0.hex};
      border: 2px solid transparent;
      border-radius: 8px;
      margin: 8px;
      padding: 16px;
    }
    button:focus, button:hover {
      background-color: ${p.surface1.hex};
      border-color: ${accentColor};
      color: ${accentColor};
    }
    button:active {
      background-color: ${p.surface2.hex};
    }
  '';
in

{
  options.themes.wlogout = themesLib.mkThemeOption {
    name = "wlogout";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    xdg.configFile."wlogout/style.css".text = themeCSS;
  };
}
