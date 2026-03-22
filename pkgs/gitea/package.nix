# Generates a Gitea custom CSS theme from palette data.
# Output: $out/<theme>-<variant>.css (drop-in custom theme for Gitea's custom CSS feature)
#
# Gitea configuration to use this:
#   [ui]
#   CUSTOM_THEME_DEFAULT = <theme>-<variant>
# Then copy the CSS file to Gitea's custom/public/css/ directory.
{
  lib,
  stdenvNoCC,
  palette,
  theme,
  variant,
}:

let
  h = palette;

  # Strip # prefix for hex values where needed
  hex = color: lib.removePrefix "#" color.hex;

  cssContent = ''
    /* nix-themes: ${theme}/${variant} */

    :root {
      /* Background layers */
      --color-body:              ${h.base.hex};
      --color-card:              ${h.mantle.hex};
      --color-navbar:            ${h.crust.hex};
      --color-input-background:  ${h.surface0.hex};
      --color-hover:             ${h.surface1.hex};
      --color-active:            ${h.surface1.hex};
      --color-menu:              ${h.base.hex};
      --color-sidebar-bg:        ${h.mantle.hex};

      /* Text */
      --color-text:              ${h.text.hex};
      --color-text-dark:         ${h.text.hex};
      --color-text-light-1:      ${h.subtext1.hex};
      --color-text-light-2:      ${h.subtext0.hex};
      --color-text-light-3:      ${h.overlay2.hex};
      --color-placeholder-text:  ${h.overlay0.hex};
      --color-editor-line-highlight: ${h.surface0.hex};

      /* Borders */
      --color-light:             ${h.surface0.hex};
      --color-secondary:         ${h.surface1.hex};
      --color-border:            ${h.surface0.hex};
      --color-second-header-bg:  ${h.crust.hex};

      /* Primary accent (blue by convention) */
      --color-primary:           ${h.blue.hex};
      --color-primary-contrast:  ${h.base.hex};
      --color-primary-light-1:   ${h.sky.hex};
      --color-primary-light-2:   ${h.sapphire.hex};
      --color-primary-light-3:   ${h.blue.hex};
      --color-primary-light-4:   ${h.blue.hex};
      --color-primary-light-5:   ${h.blue.hex};
      --color-primary-light-6:   ${h.blue.hex};
      --color-primary-dark-1:    ${h.lavender.hex};
      --color-primary-dark-2:    ${h.mauve.hex};
      --color-primary-dark-3:    ${h.mauve.hex};
      --color-primary-dark-4:    ${h.mauve.hex};
      --color-primary-dark-5:    ${h.mauve.hex};
      --color-primary-dark-6:    ${h.mauve.hex};

      /* Status colors */
      --color-red:               ${h.red.hex};
      --color-red-badge:         ${h.red.hex};
      --color-red-light:         ${h.red.hex};
      --color-red-dark:          ${h.maroon.hex};
      --color-green:             ${h.green.hex};
      --color-green-badge:       ${h.green.hex};
      --color-green-light:       ${h.green.hex};
      --color-green-dark:        ${h.teal.hex};
      --color-yellow:            ${h.yellow.hex};
      --color-yellow-badge:      ${h.peach.hex};
      --color-orange:            ${h.peach.hex};
      --color-teal:              ${h.teal.hex};
      --color-purple:            ${h.mauve.hex};
      --color-blue:              ${h.blue.hex};
      --color-cyan:              ${h.sky.hex};
      --color-pink:              ${h.pink.hex};

      /* Diff colors */
      --color-add-bg:            rgba(${h.green.rgb.r}, ${h.green.rgb.g}, ${h.green.rgb.b}, 0.12);
      --color-add-border:        rgba(${h.green.rgb.r}, ${h.green.rgb.g}, ${h.green.rgb.b}, 0.4);
      --color-del-bg:            rgba(${h.red.rgb.r}, ${h.red.rgb.g}, ${h.red.rgb.b}, 0.12);
      --color-del-border:        rgba(${h.red.rgb.r}, ${h.red.rgb.g}, ${h.red.rgb.b}, 0.4);
      --color-add-word-bg:       rgba(${h.green.rgb.r}, ${h.green.rgb.g}, ${h.green.rgb.b}, 0.3);
      --color-del-word-bg:       rgba(${h.red.rgb.r}, ${h.red.rgb.g}, ${h.red.rgb.b}, 0.3);

      /* Misc */
      --color-shadow:            rgba(0, 0, 0, 0.4);
      --color-markup-code-block: ${h.surface0.hex};
      --color-label-fg:          ${h.text.hex};
      --color-timestamp-text:    ${h.overlay2.hex};
      --color-editor-linenumber-bg: ${h.mantle.hex};
      --color-editor-linenumber-text: ${h.overlay0.hex};
    }

    /* Syntax highlighting */
    .chroma .ln, .chroma .lnt { color: ${h.overlay0.hex}; }
    .chroma .k, .chroma .kc, .chroma .kd, .chroma .kn, .chroma .kp, .chroma .kr, .chroma .kt
      { color: ${h.mauve.hex}; }
    .chroma .s, .chroma .sb, .chroma .sc, .chroma .dl, .chroma .sd, .chroma .s2, .chroma .se,
    .chroma .sh, .chroma .si, .chroma .sx, .chroma .sr, .chroma .s1, .chroma .ss
      { color: ${h.green.hex}; }
    .chroma .na, .chroma .nb, .chroma .bp, .chroma .fm, .chroma .py
      { color: ${h.blue.hex}; }
    .chroma .n, .chroma .nc, .chroma .nd, .chroma .ne, .chroma .nf, .chroma .nl, .chroma .nn,
    .chroma .nx, .chroma .nt, .chroma .nv, .chroma .vc, .chroma .vg, .chroma .vi, .chroma .vm
      { color: ${h.text.hex}; }
    .chroma .m, .chroma .mb, .chroma .mf, .chroma .mh, .chroma .mi, .chroma .mo,
    .chroma .il, .chroma .m  { color: ${h.peach.hex}; }
    .chroma .c, .chroma .ch, .chroma .cm, .chroma .c1, .chroma .cs, .chroma .cp, .chroma .cpf
      { color: ${h.overlay2.hex}; }
    .chroma .o, .chroma .ow { color: ${h.sky.hex}; }
    .chroma .p, .chroma .pi { color: ${h.text.hex}; }
  '';
in

stdenvNoCC.mkDerivation {
  pname = "nix-themes-gitea-${theme}-${variant}";
  version = "0.1.0";
  dontUnpack = true;

  buildPhase = ''
    cat > "${theme}-${variant}.css" << 'CSSEOF'
    ${cssContent}
    CSSEOF
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp "${theme}-${variant}.css" $out/
    runHook postInstall
  '';

  meta = {
    description = "Universal Gitea theme (${theme}/${variant})";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
