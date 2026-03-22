{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.tmux;
  p = config.themes.palette;
  accent = cfg.accent;
  accentColor = p.${accent}.hex;
in

{
  options.themes.tmux = themesLib.mkThemeOption {
    name = "tmux";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {

    programs.tmux.extraConfig = ''
      # nix-themes: ${config.themes.theme}/${config.themes.variant}
      set -g status-style "bg=${p.base.hex},fg=${p.text.hex}"
      set -g status-left-style "bg=${p.base.hex},fg=${p.text.hex}"
      set -g status-right-style "bg=${p.base.hex},fg=${p.text.hex}"
      set -g pane-border-style "fg=${p.surface1.hex}"
      set -g pane-active-border-style "fg=${accentColor}"
      set -g message-style "bg=${p.surface0.hex},fg=${p.text.hex}"
      set -g message-command-style "bg=${p.surface0.hex},fg=${p.blue.hex}"
      set -g popup-border-style "fg=${accentColor}"
      setw -g window-status-style "bg=${p.base.hex},fg=${p.subtext0.hex}"
      setw -g window-status-current-style "bg=${p.surface0.hex},fg=${accentColor},bold"
      setw -g window-status-bell-style "bg=${p.red.hex},fg=${p.base.hex}"
      set -g mode-style "bg=${p.surface1.hex},fg=${p.text.hex}"
      set -g copy-mode-mark-style "bg=${p.surface2.hex},fg=${p.text.hex}"
    '';
  };
}
