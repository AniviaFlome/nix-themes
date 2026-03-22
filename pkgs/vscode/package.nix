# TODO: Generate a VS Code extension/theme from palette data.
#
# The upstream catppuccin/vscode package uses pnpm + nodejs to run a JS build
# pipeline (generateThemes.cjs) that produces VS Code theme JSON files.
# The JS code reads catppuccin palette data and generates TextMate/VS Code
# color theme JSON with complex token scoping rules.
#
# A universal implementation would need to:
#   (a) Re-implement the theme JSON generation in Nix (doable but verbose)
#   (b) OR write a standalone template generator that works with any palette
#
# The VS Code theme JSON format is documented at:
#   https://code.visualstudio.com/api/extension-guides/color-theme
#
# The generated JSON maps:
#   - Editor colors (background, foreground, cursor, selection, etc.)
#   - Token colors (syntax highlighting scopes)
#   - Workbench colors (sidebar, statusbar, titlebar, etc.)
#
# This is achievable in pure Nix but requires mapping many color slots.
# Upstream reference: github.com/catppuccin/vscode

{
  lib,
  palette,
  theme,
  variant,
  accent ? "blue",
  ...
}:

throw ''
  themes.pkgs.vscode: not yet implemented.
  TODO: Generate VS Code theme JSON from palette data (${theme}/${variant}/${accent}).
  See themes/pkgs/vscode/package.nix for implementation guidance.
''
