# TODO: Generate an X11/Hyprcursor cursor theme from palette data.
#
# The upstream catppuccin/cursors package has the most complex build pipeline:
#   - whiskers (Catppuccin Tera template engine) renders SVG templates
#   - inkscape renders SVGs → PNGs at each cursor size
#   - xcursorgen assembles PNGs + cursor hotspot config → .xcursor files
#   - hyprcursor assembles into Hyprland cursor format
#   - python3 + PySide6 for additional processing
#
# A universal implementation would need to:
#   (a) Maintain SVG cursor templates with color variables (not catppuccin-specific)
#   (b) Substitute palette hex values into the SVG templates at build time
#   (c) Run the same inkscape → xcursorgen pipeline
#
# This requires either:
#   - Maintaining a full set of SVG cursor templates in this repo, OR
#   - Using the upstream templates with a color-variable substitution step
#
# Upstream reference: github.com/catppuccin/cursors
# Upstream package: pkgs/cursors/package.nix (builds 64 flavor×accent variants)

{
  lib,
  palette,
  theme,
  variant,
  accent ? "blue",
  ...
}:

throw ''
  themes.pkgs.cursors: not yet implemented.
  TODO: Generate cursor theme assets from palette data (${theme}/${variant}/${accent}).
  See themes/pkgs/cursors/package.nix for implementation guidance.
''
