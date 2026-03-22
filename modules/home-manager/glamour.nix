{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.glamour;
  p = config.themes.palette;

  glamourStyle = builtins.toJSON {
    document = {
      block_prefix = "\n";
      block_suffix = "\n";
      color = p.text.hex;
      margin = 2;
    };
    block_quote = {
      indent = 1;
      indent_token = "│ ";
    };
    paragraph = { };
    list.level_indent = 2;
    heading = {
      block_suffix = "\n";
      color = p.text.hex;
      bold = true;
    };
    h1 = {
      prefix = "▓▓▓ ";
      suffix = " ";
      color = p.red.hex;
      bold = true;
    };
    h2 = {
      prefix = "▓▓▓▓ ";
      color = p.peach.hex;
    };
    h3 = {
      prefix = "▓▓▓▓▓ ";
      color = p.yellow.hex;
    };
    h4 = {
      prefix = "▓▓▓▓▓▓ ";
      color = p.green.hex;
    };
    h5 = {
      prefix = "▓▓▓▓▓▓▓ ";
      color = p.sapphire.hex;
    };
    h6 = {
      prefix = "▓▓▓▓▓▓▓▓ ";
      color = p.lavender.hex;
    };
    text = { };
    strikethrough.crossed_out = true;
    emph.italic = true;
    strong.bold = true;
    hr = {
      color = p.overlay0.hex;
      format = "\n--------\n";
    };
    item.block_prefix = "• ";
    enumeration.block_prefix = ". ";
    task = {
      ticked = "[✓] ";
      unticked = "[ ] ";
    };
    link = {
      color = p.blue.hex;
      underline = true;
    };
    link_text = {
      color = p.lavender.hex;
      bold = true;
    };
    image = {
      color = p.blue.hex;
      underline = true;
    };
    image_text = {
      color = p.lavender.hex;
      format = "Image: {{.text}} →";
    };
    code = {
      prefix = " ";
      suffix = " ";
      color = p.maroon.hex;
      background_color = p.mantle.hex;
    };
    code_block = {
      color = p.mantle.hex;
      margin = 2;
      chroma = {
        text.color = p.text.hex;
        error = {
          color = p.text.hex;
          background_color = p.red.hex;
        };
        comment.color = p.overlay0.hex;
        comment_preproc.color = p.blue.hex;
        keyword.color = p.mauve.hex;
        keyword_reserved.color = p.mauve.hex;
        keyword_namespace.color = p.yellow.hex;
        keyword_type.color = p.yellow.hex;
        operator.color = p.sky.hex;
        punctuation.color = p.overlay2.hex;
        name.color = p.lavender.hex;
        name_builtin.color = p.peach.hex;
        name_tag.color = p.mauve.hex;
        name_attribute.color = p.yellow.hex;
        name_class.color = p.yellow.hex;
        name_constant.color = p.yellow.hex;
        name_decorator.color = p.pink.hex;
        name_exception = { };
        name_function.color = p.blue.hex;
        name_other = { };
        literal = { };
        literal_number.color = p.peach.hex;
        literal_date = { };
        literal_string.color = p.green.hex;
        literal_string_escape.color = p.pink.hex;
        generic_deleted.color = p.red.hex;
        generic_emph = {
          color = p.text.hex;
          italic = true;
        };
        generic_inserted.color = p.green.hex;
        generic_strong = {
          color = p.text.hex;
          bold = true;
        };
        generic_subheading.color = p.sky.hex;
        background.background_color = p.mantle.hex;
      };
    };
    table = {
      center_separator = "┼";
      column_separator = "│";
      row_separator = "─";
    };
    definition_list = { };
    definition_term = { };
    definition_description.block_prefix = "\n🠶 ";
    html_block = { };
    html_span = { };
  };

  glamourStyleFile = pkgs.writeText "glamour-nix-themes.json" glamourStyle;
in

{
  options.themes.glamour = themesLib.mkThemeOption { name = "glamour"; };

  config = lib.mkIf cfg.enable {

    home.sessionVariables.GLAMOUR_STYLE = "${glamourStyleFile}";
  };
}
