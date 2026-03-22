# TODO: Generate an SDDM theme from palette data.
#
# The upstream catppuccin/sddm package uses whiskers (Catppuccin's Tera template engine)
# + just to render QML files from .tera templates that reference @catppuccin/palette.
#
# A universal implementation would need to either:
#   (a) Replace whiskers with a Nix-native template renderer that substitutes palette
#       color variables into the QML/config templates
#   (b) Write new QML templates with Nix string interpolation
#
# The QML templates are in the upstream catppuccin/sddm repo under src/.
# Each template references CSS-style color variables that whiskers fills in.
#
# Upstream reference: github.com/catppuccin/sddm
# Upstream package: pkgs/sddm/package.nix (uses buildCatppuccinPort + just + whiskers)

{
  lib,
  palette,
  theme,
  variant,
  ...
}:

throw ''
  themes.pkgs.sddm: not yet implemented.
  TODO: Generate SDDM QML theme from palette data (${theme}/${variant}).
  See themes/pkgs/sddm/package.nix for implementation guidance.
''
