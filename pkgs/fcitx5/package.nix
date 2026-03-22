# Generates fcitx5 classic UI theme files from palette data.
# Output mirrors the structure expected by the upstream catppuccin/fcitx5 package:
#   $out/share/fcitx5/themes/nix-themes-<theme>-<variant>/theme.conf
{
  lib,
  stdenvNoCC,
  palette,
  theme,
  variant,
}:

let
  h = palette;

  # fcitx5's theme.conf uses #rrggbb or #aarrggbb hex color values
  themeConf = ''
    [Metadata]
    Name=nix-themes-${theme}-${variant}
    Version=0.1
    Author=nix-themes
    Description=Universal theme (${theme}/${variant})
    ScaleWithDPI=True

    [NormalText]
    Color=${h.text.hex}
    InactiveColor=${h.subtext0.hex}

    [InputPanel]
    Font=Sans 10
    NormalColor=${h.text.hex}
    HighLightColor=${h.text.hex}
    HighLightBackgroundColor=${h.surface1.hex}
    BackgroundColor=${h.base.hex}
    Vertical=True

    [InputPanel/TextMargin]
    Left=3
    Right=3
    Top=3
    Bottom=3

    [InputPanel/Background]
    Color=${h.base.hex}

    [InputPanel/Background/BorderColor]
    Color=${h.surface1.hex}

    [InputPanel/Background/Border]
    Left=3
    Right=3
    Top=3
    Bottom=3

    [InputPanel/Highlight]
    Color=${h.surface1.hex}

    [InputPanel/Highlight/BorderColor]
    Color=${h.blue.hex}

    [InputPanel/Highlight/Border]
    Left=3
    Right=3
    Top=3
    Bottom=3

    [Menu]
    Font=Sans 10
    NormalColor=${h.text.hex}
    HighLightColor=${h.text.hex}
    HighLightBackgroundColor=${h.surface1.hex}
    BackgroundColor=${h.base.hex}
    LineSpacing=3

    [Menu/Background]
    Color=${h.base.hex}

    [Menu/Background/BorderColor]
    Color=${h.surface1.hex}

    [Menu/Background/Border]
    Left=3
    Right=3
    Top=3
    Bottom=3

    [Menu/Highlight]
    Color=${h.surface1.hex}

    [Menu/Highlight/BorderColor]
    Color=${h.blue.hex}

    [Menu/Highlight/Border]
    Left=3
    Right=3
    Top=3
    Bottom=3
  '';

  themeName = "nix-themes-${theme}-${variant}";
in

stdenvNoCC.mkDerivation {
  pname = "nix-themes-fcitx5-${theme}-${variant}";
  version = "0.1.0";
  dontUnpack = true;

  buildPhase = ''
    mkdir -p "themes/${themeName}"
    cat > "themes/${themeName}/theme.conf" << 'THEMEEOF'
    ${themeConf}
    THEMEEOF
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fcitx5
    mv themes $out/share/fcitx5/
    runHook postInstall
  '';

  meta = {
    description = "Universal fcitx5 theme (${theme}/${variant})";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
