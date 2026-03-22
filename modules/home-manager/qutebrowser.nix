{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.qutebrowser;
  p = config.themes.palette;
  accent = cfg.accent;
  enable = cfg.enable && config.programs.qutebrowser.enable;
in

{
  options.themes.qutebrowser = themesLib.mkThemeOption {
    name = "qutebrowser";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    programs.qutebrowser.settings = {
      # Completion widget
      colors.completion.category.bg = p.mantle.hex;
      colors.completion.category.border.bottom = p.mantle.hex;
      colors.completion.category.border.top = p.mantle.hex;
      colors.completion.category.fg = p.text.hex;
      colors.completion.even.bg = p.base.hex;
      colors.completion.fg = [
        p.text.hex
        p.text.hex
        p.text.hex
      ];
      colors.completion.item.selected.bg = p.surface1.hex;
      colors.completion.item.selected.border.bottom = p.surface1.hex;
      colors.completion.item.selected.border.top = p.surface1.hex;
      colors.completion.item.selected.fg = p.text.hex;
      colors.completion.item.selected.match.fg = p.${accent}.hex;
      colors.completion.match.fg = p.${accent}.hex;
      colors.completion.odd.bg = p.base.hex;
      colors.completion.scrollbar.bg = p.base.hex;
      colors.completion.scrollbar.fg = p.overlay0.hex;
      # Context menu
      colors.contextmenu.disabled.bg = p.surface1.hex;
      colors.contextmenu.disabled.fg = p.overlay0.hex;
      colors.contextmenu.menu.bg = p.base.hex;
      colors.contextmenu.menu.fg = p.text.hex;
      colors.contextmenu.selected.bg = p.surface1.hex;
      colors.contextmenu.selected.fg = p.text.hex;
      # Download bar
      colors.downloads.bar.bg = p.mantle.hex;
      colors.downloads.error.bg = p.red.hex;
      colors.downloads.error.fg = p.base.hex;
      colors.downloads.stop.bg = p.surface2.hex;
      colors.downloads.system.bg = "none";
      # Hints
      colors.hints.bg = p.mantle.hex;
      colors.hints.fg = p.text.hex;
      colors.hints.match.fg = p.${accent}.hex;
      # Keyhint widget
      colors.keyhint.bg = p.surface0.hex;
      colors.keyhint.fg = p.text.hex;
      colors.keyhint.suffix.fg = p.${accent}.hex;
      # Message overlays
      colors.messages.error.bg = p.red.hex;
      colors.messages.error.border = p.red.hex;
      colors.messages.error.fg = p.base.hex;
      colors.messages.info.bg = p.base.hex;
      colors.messages.info.border = p.base.hex;
      colors.messages.info.fg = p.text.hex;
      colors.messages.warning.bg = p.peach.hex;
      colors.messages.warning.border = p.peach.hex;
      colors.messages.warning.fg = p.base.hex;
      # Prompts
      colors.prompts.bg = p.surface0.hex;
      colors.prompts.border = "1px solid ${p.${accent}.hex}";
      colors.prompts.fg = p.text.hex;
      colors.prompts.selected.bg = p.surface1.hex;
      colors.prompts.selected.fg = p.text.hex;
      # Statusbar
      colors.statusbar.caret.bg = p.mauve.hex;
      colors.statusbar.caret.fg = p.base.hex;
      colors.statusbar.caret.selection.bg = p.mauve.hex;
      colors.statusbar.caret.selection.fg = p.base.hex;
      colors.statusbar.command.bg = p.mantle.hex;
      colors.statusbar.command.fg = p.text.hex;
      colors.statusbar.command.private.bg = p.surface0.hex;
      colors.statusbar.command.private.fg = p.text.hex;
      colors.statusbar.insert.bg = p.green.hex;
      colors.statusbar.insert.fg = p.base.hex;
      colors.statusbar.normal.bg = p.mantle.hex;
      colors.statusbar.normal.fg = p.text.hex;
      colors.statusbar.passthrough.bg = p.teal.hex;
      colors.statusbar.passthrough.fg = p.base.hex;
      colors.statusbar.private.bg = p.surface0.hex;
      colors.statusbar.private.fg = p.text.hex;
      colors.statusbar.progress.bg = p.${accent}.hex;
      colors.statusbar.url.error.fg = p.red.hex;
      colors.statusbar.url.fg = p.text.hex;
      colors.statusbar.url.hover.fg = p.sky.hex;
      colors.statusbar.url.success.http.fg = p.green.hex;
      colors.statusbar.url.success.https.fg = p.green.hex;
      colors.statusbar.url.warn.fg = p.yellow.hex;
      # Tab bar
      colors.tabs.bar.bg = p.mantle.hex;
      colors.tabs.even.bg = p.mantle.hex;
      colors.tabs.even.fg = p.subtext0.hex;
      colors.tabs.indicator.error = p.red.hex;
      colors.tabs.indicator.start = p.${accent}.hex;
      colors.tabs.indicator.stop = p.green.hex;
      colors.tabs.indicator.system = "none";
      colors.tabs.odd.bg = p.mantle.hex;
      colors.tabs.odd.fg = p.subtext0.hex;
      colors.tabs.pinned.even.bg = p.teal.hex;
      colors.tabs.pinned.even.fg = p.base.hex;
      colors.tabs.pinned.odd.bg = p.teal.hex;
      colors.tabs.pinned.odd.fg = p.base.hex;
      colors.tabs.pinned.selected.even.bg = p.surface1.hex;
      colors.tabs.pinned.selected.even.fg = p.text.hex;
      colors.tabs.pinned.selected.odd.bg = p.surface1.hex;
      colors.tabs.pinned.selected.odd.fg = p.text.hex;
      colors.tabs.selected.even.bg = p.base.hex;
      colors.tabs.selected.even.fg = p.text.hex;
      colors.tabs.selected.odd.bg = p.base.hex;
      colors.tabs.selected.odd.fg = p.text.hex;
      # Web page
      colors.webpage.bg = p.base.hex;
    };
  };
}
