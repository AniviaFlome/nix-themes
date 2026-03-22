# TODO: Generate a Plymouth boot theme from palette data.
#
# Plymouth themes require:
#   - A .plymouth descriptor file (INI-format, patches /usr to $out)
#   - A .script file (Plymouth's scripting language) that references image/color assets
#   - PNG image assets for logo, background, progress bar, etc.
#
# Generating the script and descriptor from palette is straightforward.
# Generating PNG image assets requires an image generation step (e.g. ImageMagick or
# a pre-rendered template with color substitution).
#
# Upstream reference: github.com/catppuccin/plymouth  (fetches pre-built assets)
# The upstream .script files contain hardcoded flavor names and hex colors.
# A universal implementation would need to substitute all color references.
#
# For now this package throws an error if instantiated.
# To implement: generate a minimal spinner-only theme using palette colors,
# using ImageMagick or a pure-Nix SVG→PNG pipeline.

{
  lib,
  palette,
  theme,
  variant,
  ...
}:

throw ''
  themes.pkgs.plymouth: not yet implemented.
  TODO: Generate Plymouth theme assets from palette data (${theme}/${variant}).
  See themes/pkgs/plymouth/package.nix for implementation guidance.
''
