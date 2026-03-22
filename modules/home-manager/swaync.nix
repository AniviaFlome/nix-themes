{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.swaync;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;

  themeCSS = ''
    /* nix-themes: ${config.themes.theme}/${config.themes.variant} */
    * {
      --t-base:      ${p.base.hex};
      --t-mantle:    ${p.mantle.hex};
      --t-crust:     ${p.crust.hex};
      --t-surface0:  ${p.surface0.hex};
      --t-surface1:  ${p.surface1.hex};
      --t-overlay0:  ${p.overlay0.hex};
      --t-text:      ${p.text.hex};
      --t-subtext0:  ${p.subtext0.hex};
      --t-accent:    ${accentColor};
      --t-red:       ${p.red.hex};
      --t-green:     ${p.green.hex};
      --t-yellow:    ${p.yellow.hex};
      color: var(--t-text);
    }
    .notification-row .notification-background {
      background-color: var(--t-base);
      border: 1px solid var(--t-accent);
    }
    .notification-row .notification-background .close-button {
      background-color: var(--t-red);
      color: var(--t-base);
    }
    .notification-row .notification-background .notification {
      background-color: transparent;
    }
    .control-center {
      background-color: var(--t-mantle);
    }
    .control-center .notification-row .notification-background {
      background-color: var(--t-base);
    }
    .blank-window {
      background: transparent;
    }
    .notification-group-headers {
      color: var(--t-subtext0);
    }
    .floating-notifications.background .notification-row .notification-background {
      background-color: var(--t-base);
      border: 1px solid var(--t-surface1);
    }
    .urgency-low {
      border-left-color: var(--t-overlay0);
    }
    .urgency-normal {
      border-left-color: var(--t-accent);
    }
    .urgency-critical {
      border-left-color: var(--t-red);
    }
  '';
in

{
  options.themes.swaync = themesLib.mkThemeOption {
    name = "swaync";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    xdg.configFile."swaync/style.css".text = themeCSS;
  };
}
