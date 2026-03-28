{ pkgs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in

{
  xdg.enable = true;
  xfconf.enable = isLinux;
  gtk.enable = isLinux;
  qt.enable = isLinux;

  themes = {
    enable = true;
    theme = "catppuccin";
    variant = "mocha";
    accent = "blue";
  };

  programs = {
    # keep-sorted start block=yes sticky_comments=yes
    aerc.enable = true;
    alacritty.enable = true;
    anki.enable = true;
    atuin.enable = true;
    bat.enable = true;
    bottom.enable = true;
    brave.enable = isLinux;
    broot.enable = true;
    btop.enable = true;
    cava.enable = isLinux;
    chromium.enable = isLinux;
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    element-desktop.enable = true;
    eza.enable = true;
    fish.enable = true;
    foot.enable = isLinux;
    freetube.enable = isLinux;
    fuzzel.enable = isLinux;
    fzf.enable = true;
    gemini-cli.enable = true;
    gh-dash.enable = true;
    ghostty.enable = isLinux;
    gitui.enable = true;
    halloy.enable = true;
    helix.enable = true;
    hyprlock.enable = isLinux;
    imv.enable = isLinux;
    k9s.enable = true;
    kitty.enable = true;
    lazygit.enable = true;
    lsd.enable = true;
    mangohud.enable = isLinux;
    micro.enable = true;
    mpv.enable = true;
    neovim.enable = true;
    newsboat.enable = true;
    nushell.enable = true;
    obs-studio.enable = isLinux;
    opencode.enable = isLinux;
    qutebrowser.enable = false; # broken package due to python3.13-lxml-html-clean-0.4.2
    rio.enable = true;
    rofi.enable = isLinux;
    sioyek.enable = true;
    skim.enable = true;
    spotify-player.enable = true;
    starship.enable = true;
    swaylock.enable = isLinux;
    television.enable = true;
    thunderbird.enable = true;
    tmux.enable = true;
    tofi.enable = isLinux;
    vesktop.enable = isLinux;
    vicinae.enable = isLinux;
    vivaldi.enable = isLinux;
    vivid.enable = true;
    waybar.enable = isLinux;
    wezterm.enable = true;
    wleave.enable = isLinux;
    wlogout.enable = isLinux;
    yazi.enable = true;
    zathura.enable = true;
    zed-editor.enable = true;
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };
    # keep-sorted end
  };

  services = {
    # keep-sorted start block=yes
    dunst.enable = isLinux;
    mako.enable = isLinux;
    polybar = {
      enable = isLinux;
      script = ''
        polybar top &
      '';
    };
    swaync.enable = isLinux;
    # keep-sorted end
  };

  wayland.windowManager = {
    # keep-sorted start
    hyprland.enable = isLinux;
    sway.enable = isLinux;
    # keep-sorted end
  };
}
