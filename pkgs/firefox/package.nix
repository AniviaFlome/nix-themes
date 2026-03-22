# Generates a Firefox Color themes.json from palette data.
# The upstream package uses yarn+nodejs to run a JS script that reads @catppuccin/palette.
# The themes system generates the same JSON structure directly in Nix — no build tools needed.
#
# Output: $out/themes.json  (same path as the upstream catppuccin package)
# The JSON maps accent → Firefox Color theme object (hex color values, no # prefix).
# This is consumed by themes/home-manager/firefox.nix.
{
  lib,
  pkgs,
  palette,
  theme,
  variant,
}:

let
  h = palette;

  # Firefox Color theme object: maps Firefox UI slots to hex values (no # prefix).
  # Reference: https://color.firefox.com — the "Custom Theme" JSON format.
  mkThemeForAccent =
    accentName:
    let
      accent = h.${accentName};
      strip = c: lib.removePrefix "#" c.hex;
    in
    {
      # Frame (browser chrome background)
      frame = strip h.base;
      frame_inactive = strip h.mantle;

      # Active tab
      tab_text = strip h.text;
      tab_selected = strip h.surface0;
      tab_line = strip accent;
      tab_loading = strip accent;

      # Background tabs
      tab_background_text = strip h.subtext0;
      tab_background_separator = strip h.surface1;

      # Toolbar
      toolbar = strip h.mantle;
      toolbar_text = strip h.text;
      toolbar_field = strip h.surface0;
      toolbar_field_text = strip h.text;
      toolbar_field_border = strip h.surface1;
      toolbar_field_focus = strip h.surface1;
      toolbar_field_text_focus = strip h.text;
      toolbar_field_border_focus = strip accent;
      toolbar_bottom_separator = strip h.surface1;
      toolbar_top_separator = strip h.base;
      toolbar_vertical_separator = strip h.surface1;

      # Bookmark toolbar
      bookmark_text = strip h.text;

      # Popup (autocomplete, menus)
      popup = strip h.base;
      popup_text = strip h.text;
      popup_border = strip h.surface1;
      popup_highlight = strip h.surface1;
      popup_highlight_text = strip h.text;

      # Sidebar
      sidebar = strip h.base;
      sidebar_text = strip h.text;
      sidebar_border = strip h.surface1;
      sidebar_highlight = strip h.surface1;
      sidebar_highlight_text = strip h.text;

      # New Tab page
      ntp_background = strip h.base;
      ntp_card_background = strip h.mantle;
      ntp_text = strip h.text;

      # Buttons / interactive
      button_background_hover = strip h.surface1;
      button_background_active = strip h.surface2;

      # Icons (tinting)
      icons = strip accent;
      icons_attention = strip h.red;
    };

  # Build theme map for all accents
  accents = [
    "blue"
    "flamingo"
    "green"
    "lavender"
    "maroon"
    "mauve"
    "peach"
    "pink"
    "red"
    "rosewater"
    "sapphire"
    "sky"
    "teal"
    "yellow"
  ];

  themesJSON = builtins.toJSON {
    "${theme}" = {
      "${variant}" = lib.listToAttrs (map (a: lib.nameValuePair a (mkThemeForAccent a)) accents);
    };
  };
in

pkgs.writeTextDir "themes.json" themesJSON
