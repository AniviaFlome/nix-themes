{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Main ──────────────────────────────────────────────────────────────────
  # https://rosepinetheme.com/palette/
  main = {
    meta = {
      name = "Rosé Pine";
      slug = "rose-pine";
      variant = "main";
      dark = true;
    };
    crust = mkColor "111018" 17 16 24;
    mantle = mkColor "17151e" 23 21 30;
    base = mkColor "191724" 25 23 36;
    surface0 = mkColor "1f1d2e" 31 29 46;
    surface1 = mkColor "26233a" 38 35 58;
    surface2 = mkColor "403d52" 64 61 82;
    overlay0 = mkColor "6e6a86" 110 106 134;
    overlay1 = mkColor "7e7a96" 126 122 150;
    overlay2 = mkColor "908caa" 144 140 170;
    subtext0 = mkColor "a0a0c0" 160 160 192; # derived
    subtext1 = mkColor "c4c1d4" 196 193 212; # derived
    text = mkColor "e0def4" 224 222 244;
    rosewater = mkColor "ebbcba" 235 188 186; # rose
    flamingo = mkColor "ebbcba" 235 188 186; # rose (closest)
    pink = mkColor "eb6f92" 235 111 146; # love
    mauve = mkColor "c4a7e7" 196 167 231; # iris
    red = mkColor "eb6f92" 235 111 146; # love
    maroon = mkColor "c95a7a" 201 90 122; # derived: darken love
    peach = mkColor "f6c177" 246 193 119; # gold
    yellow = mkColor "f6c177" 246 193 119; # gold
    green = mkColor "31748f" 49 116 143; # pine (used as green in terminals)
    teal = mkColor "9ccfd8" 156 207 216; # foam
    sky = mkColor "9ccfd8" 156 207 216; # foam
    sapphire = mkColor "31748f" 49 116 143; # pine
    blue = mkColor "31748f" 49 116 143; # pine
    lavender = mkColor "c4a7e7" 196 167 231; # iris
    ansi = {
      black = mkAnsi "26233a" 38 35 58 "6e6a86" 110 106 134;
      red = mkAnsi "eb6f92" 235 111 146 "eb6f92" 235 111 146;
      green = mkAnsi "31748f" 49 116 143 "31748f" 49 116 143;
      yellow = mkAnsi "f6c177" 246 193 119 "f6c177" 246 193 119;
      blue = mkAnsi "9ccfd8" 156 207 216 "9ccfd8" 156 207 216;
      magenta = mkAnsi "c4a7e7" 196 167 231 "c4a7e7" 196 167 231;
      cyan = mkAnsi "ebbcba" 235 188 186 "ebbcba" 235 188 186;
      white = mkAnsi "e0def4" 224 222 244 "e0def4" 224 222 244;
    };
  };

  # ── Moon ──────────────────────────────────────────────────────────────────
  moon = {
    meta = {
      name = "Rosé Pine";
      slug = "rose-pine";
      variant = "moon";
      dark = true;
    };
    crust = mkColor "191726" 25 23 38;
    mantle = mkColor "1e1c30" 30 28 48;
    base = mkColor "232136" 35 33 54;
    surface0 = mkColor "2a273f" 42 39 63;
    surface1 = mkColor "393552" 57 53 82;
    surface2 = mkColor "44415a" 68 65 90;
    overlay0 = mkColor "6e6a86" 110 106 134;
    overlay1 = mkColor "817c98" 129 124 152;
    overlay2 = mkColor "908caa" 144 140 170;
    subtext0 = mkColor "a4a0b8" 164 160 184;
    subtext1 = mkColor "c0bccc" 192 188 204;
    text = mkColor "e0def4" 224 222 244;
    rosewater = mkColor "ea9a97" 234 154 151; # rose (moon variant)
    flamingo = mkColor "ea9a97" 234 154 151;
    pink = mkColor "eb6f92" 235 111 146; # love
    mauve = mkColor "c4a7e7" 196 167 231; # iris
    red = mkColor "eb6f92" 235 111 146;
    maroon = mkColor "c95a7a" 201 90 122;
    peach = mkColor "f6c177" 246 193 119;
    yellow = mkColor "f6c177" 246 193 119;
    green = mkColor "3e8fb0" 62 143 176; # pine (moon)
    teal = mkColor "9ccfd8" 156 207 216; # foam
    sky = mkColor "9ccfd8" 156 207 216;
    sapphire = mkColor "3e8fb0" 62 143 176;
    blue = mkColor "3e8fb0" 62 143 176;
    lavender = mkColor "c4a7e7" 196 167 231;
    ansi = {
      black = mkAnsi "393552" 57 53 82 "6e6a86" 110 106 134;
      red = mkAnsi "eb6f92" 235 111 146 "eb6f92" 235 111 146;
      green = mkAnsi "3e8fb0" 62 143 176 "3e8fb0" 62 143 176;
      yellow = mkAnsi "f6c177" 246 193 119 "f6c177" 246 193 119;
      blue = mkAnsi "9ccfd8" 156 207 216 "9ccfd8" 156 207 216;
      magenta = mkAnsi "c4a7e7" 196 167 231 "c4a7e7" 196 167 231;
      cyan = mkAnsi "ea9a97" 234 154 151 "ea9a97" 234 154 151;
      white = mkAnsi "e0def4" 224 222 244 "e0def4" 224 222 244;
    };
  };

  # ── Dawn (light) ──────────────────────────────────────────────────────────
  dawn = {
    meta = {
      name = "Rosé Pine";
      slug = "rose-pine";
      variant = "dawn";
      dark = false;
    };
    crust = mkColor "dcd8d1" 220 216 209;
    mantle = mkColor "e5e1da" 229 225 218;
    base = mkColor "faf4ed" 250 244 237;
    surface0 = mkColor "fffaf3" 255 250 243;
    surface1 = mkColor "f4ede8" 244 237 232;
    surface2 = mkColor "dfdad9" 223 218 217;
    overlay0 = mkColor "9893a5" 152 147 165;
    overlay1 = mkColor "8e8a9a" 142 138 154;
    overlay2 = mkColor "797593" 121 117 147;
    subtext0 = mkColor "6e6b7a" 110 107 122;
    subtext1 = mkColor "645e74" 100 94 116;
    text = mkColor "575279" 87 82 121;
    rosewater = mkColor "d7827e" 215 130 126; # rose (dawn)
    flamingo = mkColor "d7827e" 215 130 126;
    pink = mkColor "b4637a" 180 99 122; # love (dawn)
    mauve = mkColor "907aa9" 144 122 169; # iris (dawn)
    red = mkColor "b4637a" 180 99 122;
    maroon = mkColor "9c4e65" 156 78 101;
    peach = mkColor "ea9d34" 234 157 52; # gold (dawn)
    yellow = mkColor "ea9d34" 234 157 52;
    green = mkColor "286983" 40 105 131; # pine (dawn)
    teal = mkColor "56949f" 86 148 159; # foam (dawn)
    sky = mkColor "56949f" 86 148 159;
    sapphire = mkColor "286983" 40 105 131;
    blue = mkColor "286983" 40 105 131;
    lavender = mkColor "907aa9" 144 122 169;
    ansi = {
      black = mkAnsi "f2e9e1" 242 233 225 "9893a5" 152 147 165;
      red = mkAnsi "b4637a" 180 99 122 "b4637a" 180 99 122;
      green = mkAnsi "286983" 40 105 131 "286983" 40 105 131;
      yellow = mkAnsi "ea9d34" 234 157 52 "ea9d34" 234 157 52;
      blue = mkAnsi "56949f" 86 148 159 "56949f" 86 148 159;
      magenta = mkAnsi "907aa9" 144 122 169 "907aa9" 144 122 169;
      cyan = mkAnsi "d7827e" 215 130 126 "d7827e" 215 130 126;
      white = mkAnsi "575279" 87 82 121 "575279" 87 82 121;
    };
  };
}
