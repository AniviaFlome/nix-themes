{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.zed-editor;
  p = config.themes.palette;
  accent = cfg.accent;
  enable = cfg.enable && config.programs.zed-editor.enable;

  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";

  themeJSON = builtins.toJSON {
    "$schema" = "https://zed.dev/schema/themes/v0.2.0.json";
    name = "nix-themes";
    author = "nix-themes";
    themes = [
      {
        name = themeName;
        appearance = if p.meta.dark then "dark" else "light";
        style = {
          accents = [
            p.mauve.hex
            p.blue.hex
            p.teal.hex
            p.green.hex
            p.yellow.hex
            p.peach.hex
            p.red.hex
          ];
          background = p.base.hex;
          "background.appearance" = "opaque";
          border = p.surface1.hex;
          "border.variant" = p.${accent}.hex;
          "border.focused" = p.${accent}.hex;
          "border.selected" = p.mauve.hex;
          "border.transparent" = p.green.hex;
          "border.disabled" = p.overlay0.hex;
          "elevated_surface.background" = p.mantle.hex;
          "surface.background" = p.mantle.hex;
          "element.background" = p.surface0.hex;
          "element.hover" = p.surface1.hex;
          "element.active" = p.surface2.hex;
          "element.selected" = p.surface1.hex;
          "element.disabled" = p.overlay0.hex;
          "drop_target.background" = p.surface1.hex;
          "ghost_element.background" = "transparent";
          "ghost_element.hover" = p.surface0.hex;
          "ghost_element.active" = p.surface1.hex;
          "ghost_element.selected" = p.surface0.hex;
          "ghost_element.disabled" = p.overlay0.hex;
          text = p.text.hex;
          "text.muted" = p.subtext1.hex;
          "text.placeholder" = p.overlay2.hex;
          "text.disabled" = p.overlay0.hex;
          "text.accent" = p.${accent}.hex;
          icon = p.text.hex;
          "icon.muted" = p.overlay2.hex;
          "icon.disabled" = p.overlay0.hex;
          "icon.placeholder" = p.overlay2.hex;
          "icon.accent" = p.${accent}.hex;
          "status_bar.background" = p.mantle.hex;
          "title_bar.background" = p.mantle.hex;
          "title_bar.inactive_background" = p.crust.hex;
          "toolbar.background" = p.base.hex;
          "tab_bar.background" = p.mantle.hex;
          "tab.inactive_background" = p.crust.hex;
          "tab.active_background" = p.base.hex;
          "search.match_background" = p.surface0.hex;
          "search.active_match_background" = p.surface1.hex;
          "panel.background" = p.mantle.hex;
          "panel.focused_border" = p.${accent}.hex;
          "panel.indent_guide" = p.surface1.hex;
          "panel.indent_guide_active" = p.overlay0.hex;
          "panel.indent_guide_hover" = p.${accent}.hex;
          "pane.focused_border" = p.${accent}.hex;
          "pane_group.border" = p.surface1.hex;
          "scrollbar.thumb.background" = p.surface2.hex;
          "scrollbar.thumb.hover_background" = p.overlay0.hex;
          "scrollbar.track.background" = p.mantle.hex;
          "scrollbar.track.border" = p.surface0.hex;
          "editor.foreground" = p.text.hex;
          "editor.background" = p.base.hex;
          "editor.gutter.background" = p.base.hex;
          "editor.active_line.background" = p.surface0.hex;
          "editor.line_number" = p.surface1.hex;
          "editor.active_line_number" = p.lavender.hex;
          "editor.invisible" = p.surface1.hex;
          "editor.wrap_guide" = p.surface0.hex;
          "editor.active_wrap_guide" = p.surface1.hex;
          "editor.document_highlight.read_background" = p.surface0.hex;
          "editor.document_highlight.write_background" = p.surface1.hex;
          "terminal.background" = p.base.hex;
          "terminal.foreground" = p.text.hex;
          "terminal.bright_foreground" = p.text.hex;
          "terminal.dim_foreground" = p.subtext0.hex;
          "terminal.ansi.black" = p.ansi.black.normal.hex;
          "terminal.ansi.bright_black" = p.ansi.black.bright.hex;
          "terminal.ansi.red" = p.ansi.red.normal.hex;
          "terminal.ansi.bright_red" = p.ansi.red.bright.hex;
          "terminal.ansi.green" = p.ansi.green.normal.hex;
          "terminal.ansi.bright_green" = p.ansi.green.bright.hex;
          "terminal.ansi.yellow" = p.ansi.yellow.normal.hex;
          "terminal.ansi.bright_yellow" = p.ansi.yellow.bright.hex;
          "terminal.ansi.blue" = p.ansi.blue.normal.hex;
          "terminal.ansi.bright_blue" = p.ansi.blue.bright.hex;
          "terminal.ansi.magenta" = p.ansi.magenta.normal.hex;
          "terminal.ansi.bright_magenta" = p.ansi.magenta.bright.hex;
          "terminal.ansi.cyan" = p.ansi.cyan.normal.hex;
          "terminal.ansi.bright_cyan" = p.ansi.cyan.bright.hex;
          "terminal.ansi.white" = p.ansi.white.normal.hex;
          "terminal.ansi.bright_white" = p.ansi.white.bright.hex;
          # Syntax
          "syntax.attribute" = {
            color = p.yellow.hex;
          };
          "syntax.boolean" = {
            color = p.peach.hex;
          };
          "syntax.comment" = {
            color = p.overlay2.hex;
            font_style = "italic";
          };
          "syntax.comment.doc" = {
            color = p.overlay2.hex;
          };
          "syntax.constant" = {
            color = p.peach.hex;
          };
          "syntax.constructor" = {
            color = p.sapphire.hex;
          };
          "syntax.embedded" = {
            color = p.text.hex;
          };
          "syntax.emphasis" = {
            color = p.red.hex;
            font_style = "italic";
          };
          "syntax.emphasis.strong" = {
            color = p.red.hex;
            font_weight = 700;
          };
          "syntax.enum" = {
            color = p.teal.hex;
          };
          "syntax.function" = {
            color = p.blue.hex;
          };
          "syntax.hint" = {
            color = p.teal.hex;
            font_weight = 700;
          };
          "syntax.keyword" = {
            color = p.mauve.hex;
          };
          "syntax.label" = {
            color = p.sapphire.hex;
          };
          "syntax.link_text" = {
            color = p.blue.hex;
            font_style = "italic";
          };
          "syntax.link_uri" = {
            color = p.sky.hex;
          };
          "syntax.number" = {
            color = p.peach.hex;
          };
          "syntax.operator" = {
            color = p.sky.hex;
          };
          "syntax.predictive" = {
            color = p.overlay2.hex;
            font_style = "italic";
          };
          "syntax.preproc" = {
            color = p.mauve.hex;
          };
          "syntax.property" = {
            color = p.blue.hex;
          };
          "syntax.punctuation.bracket" = {
            color = p.overlay2.hex;
          };
          "syntax.punctuation.delimiter" = {
            color = p.overlay2.hex;
          };
          "syntax.punctuation.list_marker" = {
            color = p.teal.hex;
          };
          "syntax.punctuation.special" = {
            color = p.sky.hex;
          };
          "syntax.string" = {
            color = p.green.hex;
          };
          "syntax.string.escape" = {
            color = p.pink.hex;
          };
          "syntax.string.regex" = {
            color = p.pink.hex;
          };
          "syntax.string.special.symbol" = {
            color = p.red.hex;
          };
          "syntax.tag" = {
            color = p.blue.hex;
          };
          "syntax.text.literal" = {
            color = p.green.hex;
          };
          "syntax.title" = {
            color = p.blue.hex;
            font_weight = 700;
          };
          "syntax.type" = {
            color = p.yellow.hex;
          };
          "syntax.variable" = {
            color = p.text.hex;
          };
          "syntax.variable.special" = {
            color = p.red.hex;
          };
          "syntax.variant" = {
            color = p.teal.hex;
          };
        };
      }
    ];
  };

  themeFile = pkgs.writeText "nix-themes-zed.json" themeJSON;
in

{
  options.themes.zed-editor = themesLib.mkThemeOption {
    name = "zed-editor";
    accentSupport = true;
  };

  config = lib.mkIf enable {

    programs.zed-editor.userSettings = {
      theme = {
        light = themeName;
        dark = themeName;
      };
    };

    xdg.configFile."zed/themes/nix-themes.json".source = themeFile;
  };
}
