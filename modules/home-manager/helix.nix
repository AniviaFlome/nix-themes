{ themesLib }:
{ config, lib, ... }:

let
  cfg = config.themes.helix;
  p = config.themes.palette;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";
  enable = cfg.enable && config.programs.helix.enable;

  # Derived colors (computed from palette for cursor/selection variants)
  cursorline = p.surface0.hex;
  secondary_cursor = p.overlay0.hex;
  secondary_cursor_select = p.blue.hex;
  secondary_cursor_normal = p.overlay0.hex;
  secondary_cursor_insert = p.green.hex;
in

{
  options.themes.helix = themesLib.mkThemeOption { name = "helix"; };

  config = lib.mkIf enable {

    programs.helix = {
      settings = {
        theme = themeName;
        editor.color-modes = lib.mkDefault true;
      };
    };

    xdg.configFile."helix/themes/${themeName}.toml".text = ''
      # Syntax highlighting
      "attribute" = "yellow"

      "type" = "yellow"
      "type.builtin" = "mauve"
      "type.enum.variant" = "teal"

      "constructor" = "sapphire"

      "constant" = "peach"
      "constant.character" = "teal"
      "constant.character.escape" = "pink"

      "string" = "green"
      "string.regexp" = "pink"
      "string.special" = "blue"
      "string.special.symbol" = "red"

      "comment" = { fg = "overlay2", modifiers = ["italic"] }

      "variable" = "text"
      "variable.parameter" = { fg = "maroon", modifiers = ["italic"] }
      "variable.builtin" = "red"
      "variable.other.member" = "blue"

      "label" = "sapphire"

      "punctuation" = "overlay2"
      "punctuation.special" = "sky"

      "keyword" = "mauve"
      "keyword.control.conditional" = { fg = "mauve", modifiers = ["italic"] }

      "operator" = "sky"

      "function" = "blue"
      "function.macro" = "rosewater"

      "tag" = "blue"

      "namespace" = { fg = "yellow", modifiers = ["italic"] }

      "special" = "blue"

      "markup.heading.1" = "red"
      "markup.heading.2" = "peach"
      "markup.heading.3" = "yellow"
      "markup.heading.4" = "green"
      "markup.heading.5" = "sapphire"
      "markup.heading.6" = "lavender"
      "markup.list" = "teal"
      "markup.list.unchecked" = "overlay2"
      "markup.list.checked" = "green"
      "markup.bold" = { fg = "red", modifiers = ["bold"] }
      "markup.italic" = { fg = "red", modifiers = ["italic"] }
      "markup.strikethrough" = { modifiers = ["crossed_out"] }
      "markup.link.url" = { fg = "blue", modifiers = ["italic", "underlined"] }
      "markup.link.text" = "lavender"
      "markup.link.label" = "sapphire"
      "markup.raw" = "green"
      "markup.quote" = "pink"

      "diff.plus" = "green"
      "diff.minus" = "red"
      "diff.delta" = "blue"

      # User Interface
      "ui.background" = { fg = "text", bg = "base" }

      "ui.linenr" = { fg = "surface1" }
      "ui.linenr.selected" = { fg = "lavender" }

      "ui.statusline" = { fg = "subtext1", bg = "mantle" }
      "ui.statusline.inactive" = { fg = "surface2", bg = "mantle" }
      "ui.statusline.normal" = { fg = "base", bg = "rosewater", modifiers = ["bold"] }
      "ui.statusline.insert" = { fg = "base", bg = "green", modifiers = ["bold"] }
      "ui.statusline.select" = { fg = "base", bg = "lavender", modifiers = ["bold"] }

      "ui.popup" = { fg = "text", bg = "surface0" }
      "ui.window" = { fg = "crust" }
      "ui.help" = { fg = "overlay2", bg = "surface0" }

      "ui.bufferline" = { fg = "subtext0", bg = "mantle" }
      "ui.bufferline.active" = { fg = "mauve", bg = "base", underline = { color = "mauve", style = "line" } }
      "ui.bufferline.background" = { bg = "crust" }

      "ui.text" = "text"
      "ui.text.focus" = { fg = "text", bg = "surface0", modifiers = ["bold"] }
      "ui.text.inactive" = { fg = "overlay1" }
      "ui.text.directory" = { fg = "blue" }

      "ui.virtual" = "overlay0"
      "ui.virtual.ruler" = { bg = "surface0" }
      "ui.virtual.indent-guide" = "surface0"
      "ui.virtual.inlay-hint" = { fg = "surface1", bg = "mantle" }
      "ui.virtual.jump-label" = { fg = "rosewater", modifiers = ["bold"] }

      "ui.selection" = { bg = "surface1" }

      "ui.cursor" = { fg = "base", bg = "secondary_cursor" }
      "ui.cursor.primary" = { fg = "base", bg = "rosewater" }
      "ui.cursor.match" = { fg = "peach", modifiers = ["bold"] }

      "ui.cursor.primary.normal" = { fg = "base", bg = "rosewater" }
      "ui.cursor.primary.insert" = { fg = "base", bg = "green" }
      "ui.cursor.primary.select" = { fg = "base", bg = "lavender" }

      "ui.cursor.normal" = { fg = "base", bg = "secondary_cursor_normal" }
      "ui.cursor.insert" = { fg = "base", bg = "secondary_cursor_insert" }
      "ui.cursor.select" = { fg = "base", bg = "secondary_cursor_select" }

      "ui.cursorline.primary" = { bg = "cursorline" }

      "ui.highlight" = { bg = "surface1", modifiers = ["bold"] }

      "ui.menu" = { fg = "overlay2", bg = "surface0" }
      "ui.menu.selected" = { fg = "text", bg = "surface1", modifiers = ["bold"] }

      "diagnostic.error" = { underline = { color = "red", style = "curl" } }
      "diagnostic.warning" = { underline = { color = "yellow", style = "curl" } }
      "diagnostic.info" = { underline = { color = "sky", style = "curl" } }
      "diagnostic.hint" = { underline = { color = "teal", style = "curl" } }
      "diagnostic.unnecessary" = { modifiers = ["dim"] }
      "diagnostic.deprecated" = { modifiers = ["crossed_out"] }

      error = "red"
      warning = "yellow"
      info = "sky"
      hint = "teal"

      rainbow = ["red", "peach", "yellow", "green", "sapphire", "lavender"]

      [palette]
      rosewater = "${p.rosewater.hex}"
      flamingo = "${p.flamingo.hex}"
      pink = "${p.pink.hex}"
      mauve = "${p.mauve.hex}"
      red = "${p.red.hex}"
      maroon = "${p.maroon.hex}"
      peach = "${p.peach.hex}"
      yellow = "${p.yellow.hex}"
      green = "${p.green.hex}"
      teal = "${p.teal.hex}"
      sky = "${p.sky.hex}"
      sapphire = "${p.sapphire.hex}"
      blue = "${p.blue.hex}"
      lavender = "${p.lavender.hex}"
      text = "${p.text.hex}"
      subtext1 = "${p.subtext1.hex}"
      subtext0 = "${p.subtext0.hex}"
      overlay2 = "${p.overlay2.hex}"
      overlay1 = "${p.overlay1.hex}"
      overlay0 = "${p.overlay0.hex}"
      surface2 = "${p.surface2.hex}"
      surface1 = "${p.surface1.hex}"
      surface0 = "${p.surface0.hex}"
      base = "${p.base.hex}"
      mantle = "${p.mantle.hex}"
      crust = "${p.crust.hex}"
      cursorline = "${cursorline}"
      secondary_cursor = "${secondary_cursor}"
      secondary_cursor_select = "${secondary_cursor_select}"
      secondary_cursor_normal = "${secondary_cursor_normal}"
      secondary_cursor_insert = "${secondary_cursor_insert}"
    '';
  };
}
