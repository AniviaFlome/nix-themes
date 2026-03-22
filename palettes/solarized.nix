{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Dark ──────────────────────────────────────────────────────────────────
  # https://ethanschoonover.com/solarized/
  dark = {
    meta = {
      name = "Solarized";
      slug = "solarized";
      variant = "dark";
      dark = true;
    };
    crust = mkColor "001e26" 0 30 38; # derived: darker base03
    mantle = mkColor "002531" 0 37 49; # derived: between crust and base03
    base = mkColor "002b36" 0 43 54; # base03
    surface0 = mkColor "073642" 7 54 66; # base02
    surface1 = mkColor "0e3e4e" 14 62 78; # derived: slightly lighter
    surface2 = mkColor "114455" 17 68 85; # derived
    overlay0 = mkColor "586e75" 88 110 117; # base01
    overlay1 = mkColor "657b83" 101 123 131; # base00
    overlay2 = mkColor "748b93" 116 139 147; # derived: lighten base00
    subtext0 = mkColor "839496" 131 148 150; # base0
    subtext1 = mkColor "93a1a1" 147 161 161; # base1
    text = mkColor "eee8d5" 238 232 213; # base2 (body text on dark)
    rosewater = mkColor "cb4b16" 203 75 22; # orange
    flamingo = mkColor "d33682" 211 54 130; # magenta as warm pink
    pink = mkColor "d33682" 211 54 130; # magenta
    mauve = mkColor "6c71c4" 108 113 196; # violet
    red = mkColor "dc322f" 220 50 47; # red
    maroon = mkColor "c82020" 200 32 32; # derived: darken red
    peach = mkColor "cb4b16" 203 75 22; # orange
    yellow = mkColor "b58900" 181 137 0;
    green = mkColor "859900" 133 153 0;
    teal = mkColor "2aa198" 42 161 152; # cyan
    sky = mkColor "268bd2" 38 139 210; # blue as sky
    sapphire = mkColor "1e7ab0" 30 122 176; # derived: darken blue
    blue = mkColor "268bd2" 38 139 210; # blue
    lavender = mkColor "5a7fbf" 90 127 191; # derived: blue with purple tint
    ansi = {
      black = mkAnsi "073642" 7 54 66 "002b36" 0 43 54;
      red = mkAnsi "dc322f" 220 50 47 "cb4b16" 203 75 22;
      green = mkAnsi "859900" 133 153 0 "586e75" 88 110 117;
      yellow = mkAnsi "b58900" 181 137 0 "657b83" 101 123 131;
      blue = mkAnsi "268bd2" 38 139 210 "839496" 131 148 150;
      magenta = mkAnsi "d33682" 211 54 130 "6c71c4" 108 113 196;
      cyan = mkAnsi "2aa198" 42 161 152 "93a1a1" 147 161 161;
      white = mkAnsi "eee8d5" 238 232 213 "fdf6e3" 253 246 227;
    };
  };

  # ── Light ─────────────────────────────────────────────────────────────────
  light = {
    meta = {
      name = "Solarized";
      slug = "solarized";
      variant = "light";
      dark = false;
    };
    crust = mkColor "dcd8c8" 220 216 200; # derived: darker base2
    mantle = mkColor "e5e0d0" 229 224 208; # derived
    base = mkColor "fdf6e3" 253 246 227; # base3
    surface0 = mkColor "eee8d5" 238 232 213; # base2
    surface1 = mkColor "e4dcc8" 228 220 200; # derived
    surface2 = mkColor "d9d0bb" 217 208 187; # derived
    overlay0 = mkColor "93a1a1" 147 161 161; # base1 (comments)
    overlay1 = mkColor "839496" 131 148 150; # base0
    overlay2 = mkColor "748b93" 116 139 147; # derived
    subtext0 = mkColor "657b83" 101 123 131; # base00
    subtext1 = mkColor "586e75" 88 110 117; # base01
    text = mkColor "073642" 7 54 66; # base02 (body text on light)
    rosewater = mkColor "cb4b16" 203 75 22;
    flamingo = mkColor "d33682" 211 54 130;
    pink = mkColor "d33682" 211 54 130;
    mauve = mkColor "6c71c4" 108 113 196;
    red = mkColor "dc322f" 220 50 47;
    maroon = mkColor "c82020" 200 32 32;
    peach = mkColor "cb4b16" 203 75 22;
    yellow = mkColor "b58900" 181 137 0;
    green = mkColor "859900" 133 153 0;
    teal = mkColor "2aa198" 42 161 152;
    sky = mkColor "268bd2" 38 139 210;
    sapphire = mkColor "1e7ab0" 30 122 176;
    blue = mkColor "268bd2" 38 139 210;
    lavender = mkColor "5a7fbf" 90 127 191;
    ansi = {
      black = mkAnsi "073642" 7 54 66 "002b36" 0 43 54;
      red = mkAnsi "dc322f" 220 50 47 "cb4b16" 203 75 22;
      green = mkAnsi "859900" 133 153 0 "586e75" 88 110 117;
      yellow = mkAnsi "b58900" 181 137 0 "657b83" 101 123 131;
      blue = mkAnsi "268bd2" 38 139 210 "839496" 131 148 150;
      magenta = mkAnsi "d33682" 211 54 130 "6c71c4" 108 113 196;
      cyan = mkAnsi "2aa198" 42 161 152 "93a1a1" 147 161 161;
      white = mkAnsi "eee8d5" 238 232 213 "fdf6e3" 253 246 227;
    };
  };
}
