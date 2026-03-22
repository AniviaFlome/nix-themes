# Generates a GRUB2 theme from palette data.
# Output: $out/share/grub/themes/nix-themes-<theme>-<variant>/
#   theme.txt   — GRUB theme config with palette colors
#   font.pf2    — copied from grub2's built-in font (unifont or ascii)
#   background.png — 1×1 solid-color PNG in the base color (minimal fallback)
#
# GRUB module config:
#   boot.loader.grub.theme = "${pkg}/share/grub/themes/nix-themes-<theme>-<variant>";
{
  lib,
  stdenvNoCC,
  grub2,
  netpbm,
  palette,
  theme,
  variant,
}:

let
  h = palette;

  themeName = "nix-themes-${theme}-${variant}";

  # GRUB theme.txt — color names must be GRUB color identifiers or #rrggbb
  # Reference: https://www.gnu.org/software/grub/manual/grub/html_node/Theme-file-format.html
  themeConf = ''
    # nix-themes GRUB theme: ${theme}/${variant}

    desktop-color: "${h.base.hex}"
    desktop-image: ""

    + boot_menu {
      left = 15%
      top = 20%
      width = 70%
      height = 50%
      item_color: "${h.text.hex}"
      selected_item_color: "${h.base.hex}"
      item_height: 24
      item_padding: 4
      item_spacing: 4
      selected_item_pixmap_style: "select_bg.*"
      menu_pixmap_style: "menu_bg.*"
      scrollbar = true
      scrollbar_width = 4
      scrollbar_thumb = "scrollbar_thumb.*"
      scrollbar_frame = "scrollbar_frame.*"
    }

    + label {
      id = "title"
      text = "Boot Menu"
      left = 15%
      top = 15%
      color = "${h.blue.hex}"
      font = "nix-themes-18"
      align = "left"
    }

    + progress_bar {
      id = "progress_bar"
      left = 15%
      top = 75%
      width = 70%
      height = 16
      show_text = true
      font = "nix-themes-12"
      text_color = "${h.subtext0.hex}"
      fg_color = "${h.blue.hex}"
      bg_color = "${h.surface0.hex}"
      border_color = "${h.surface1.hex}"
    }
  '';
in

stdenvNoCC.mkDerivation {
  pname = "nix-themes-grub-${theme}-${variant}";
  version = "0.1.0";
  dontUnpack = true;

  nativeBuildInputs = [
    netpbm
    grub2
  ];

  buildPhase = ''
    mkdir -p "${themeName}"

    # theme.txt
    cat > "${themeName}/theme.txt" << 'GRUBEOF'
    ${themeConf}
    GRUBEOF

    # Solid 1280x800 background PNG in the base color (no ImageMagick needed — use netpbm)
    local r=${toString h.base.rgb.r}
    local g=${toString h.base.rgb.g}
    local b=${toString h.base.rgb.b}
    # Create a 1px PPM then scale up with pamscale
    printf "P6\n1 1\n255\n" > bg.ppm
    printf "\\x$(printf '%02x' $r)\\x$(printf '%02x' $g)\\x$(printf '%02x' $b)" >> bg.ppm
    pamscale -width 1280 -height 800 bg.ppm | pnmtopng > "${themeName}/background.png"

    # Use GRUB's bundled unifont.pf2 as the theme font
    cp ${grub2}/share/grub/unicode.pf2 "${themeName}/font.pf2"
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/grub/themes
    mv "${themeName}" $out/share/grub/themes/
    runHook postInstall
  '';

  meta = {
    description = "Universal GRUB theme (${theme}/${variant})";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
