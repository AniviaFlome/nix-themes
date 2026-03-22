# Generates a Kvantum theme from palette data.
# Output: $out/share/Kvantum/nix-themes-<theme>-<variant>-<accent>/
#   nix-themes-<theme>-<variant>-<accent>.kvconfig
#   nix-themes-<theme>-<variant>-<accent>.svg  (TODO: full SVG, currently minimal stub)
#
# The .kvconfig specifies numeric color values; the .svg is the widget rendering template.
# Note: a full Kvantum SVG theme requires a large SVG file with named widget regions.
# The minimal SVG stub here produces a functional but plain flat theme.
{
  lib,
  stdenvNoCC,
  palette,
  theme,
  variant,
  accent ? "blue",
}:

let
  h = palette;
  accentColor = h.${accent};
  strip = c: lib.removePrefix "#" c.hex;
  themeName = "nix-themes-${theme}-${variant}-${accent}";

  # Kvantum .kvconfig: color and style overrides (INI-style)
  # Reference: https://github.com/tsujan/Kvantum/blob/master/Kvantum/themes/kvthemes/KvGlass/KvGlass.kvconfig
  kvconfig = ''
    [%General]
    author=nix-themes
    comment=Universal Kvantum theme (${theme}/${variant}/${accent})
    x11drag=true
    alt_mnemonic=true
    left_tabs=false
    attach_active_tab=false
    toolbarSize=small
    button_width_from_text=false
    textless_progressbar=false
    progressbar_as_far_as_possible=false
    spread_progressbar=true
    progressbar_thickness=10
    menubar_mouse_tracking=true
    merge_menubar_with_toolbar=true
    toolbutton_style=0
    scrollbar_width=12
    scroll_arrows=false
    scroll_min_extent=36
    transient_scrollbar=false
    tooltip_delay=-1
    no_inactiveness=false

    [GeneralColors]
    window.color=${strip h.base}
    base.color=${strip h.mantle}
    alt.base.color=${strip h.crust}
    button.color=${strip h.surface0}
    light.color=${strip h.surface1}
    mid.light.color=${strip h.surface0}
    dark.color=${strip h.crust}
    mid.color=${strip h.mantle}
    shadow.color=${strip h.crust}
    highlight.color=${strip accentColor}
    inactive.highlight.color=${strip h.surface2}
    text.color=${strip h.text}
    window.text.color=${strip h.text}
    button.text.color=${strip h.text}
    disabled.text.color=${strip h.overlay0}
    tooltip.text.color=${strip h.text}
    highlight.text.color=${strip h.base}
    link.color=${strip h.blue}
    link.visited.color=${strip h.mauve}
    tooltip.base.color=${strip h.surface0}
    status.bar.text.color=${strip h.text}
  '';

  # Minimal stub SVG — Kvantum requires an SVG file to be present alongside the kvconfig.
  # TODO: Replace with a full Kvantum SVG widget template for proper rendering.
  # A proper SVG has named regions (e.g. push-button, spinbox, combobox, etc.)
  # matching the IDs that Kvantum looks up at runtime.
  svgStub = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!-- nix-themes Kvantum theme stub for ${theme}/${variant}/${accent} -->
    <!-- TODO: Replace with a full Kvantum SVG widget template. -->
    <svg xmlns="http://www.w3.org/2000/svg" width="500" height="500">
      <!-- placeholder: flat colored background -->
      <rect width="500" height="500" fill="#${strip h.base}"/>
    </svg>
  '';
in

stdenvNoCC.mkDerivation {
  pname = "nix-themes-kvantum-${theme}-${variant}-${accent}";
  version = "0.1.0";
  dontUnpack = true;

  buildPhase = ''
    mkdir -p "themes/${themeName}"
    printf '%s' ${lib.escapeShellArg kvconfig} > "themes/${themeName}/${themeName}.kvconfig"
    printf '%s' ${lib.escapeShellArg svgStub}  > "themes/${themeName}/${themeName}.svg"
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share
    mv themes $out/share/Kvantum
    runHook postInstall
  '';

  meta = {
    description = "Universal Kvantum theme (${theme}/${variant}/${accent})";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
