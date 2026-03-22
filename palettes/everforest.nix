{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Dark Hard ─────────────────────────────────────────────────────────────
  # https://github.com/sainnhe/everforest
  dark-hard = {
    meta = {
      name = "Everforest";
      slug = "everforest";
      variant = "dark-hard";
      dark = true;
    };
    crust = mkColor "1a2024" 26 32 36;
    mantle = mkColor "1e2629" 30 38 41;
    base = mkColor "272e33" 39 46 51;
    surface0 = mkColor "2e383c" 46 56 60;
    surface1 = mkColor "374145" 55 65 69;
    surface2 = mkColor "414b4f" 65 75 79;
    overlay0 = mkColor "4a555a" 74 85 90;
    overlay1 = mkColor "5c6a72" 92 106 114;
    overlay2 = mkColor "7a8478" 122 132 120;
    subtext0 = mkColor "859289" 133 146 137;
    subtext1 = mkColor "9da9a0" 157 169 160;
    text = mkColor "d3c6aa" 211 198 170;
    rosewater = mkColor "e69875" 230 152 117; # orange
    flamingo = mkColor "e67e80" 230 126 128; # red (warm)
    pink = mkColor "d699b6" 214 153 182;
    mauve = mkColor "d699b6" 214 153 182;
    red = mkColor "e67e80" 230 126 128;
    maroon = mkColor "cc6a6d" 204 106 109; # derived: darken red
    peach = mkColor "e69875" 230 152 117;
    yellow = mkColor "dbbc7f" 219 188 127;
    green = mkColor "a7c080" 167 192 128;
    teal = mkColor "83c092" 131 192 146;
    sky = mkColor "7fbbb3" 127 187 179;
    sapphire = mkColor "6fa8a0" 111 168 160; # derived: darken sky
    blue = mkColor "7fbbb3" 127 187 179;
    lavender = mkColor "b0a8c8" 176 168 200; # derived
    ansi = {
      black = mkAnsi "3c4841" 60 72 65 "475258" 71 82 88;
      red = mkAnsi "e67e80" 230 126 128 "e67e80" 230 126 128;
      green = mkAnsi "a7c080" 167 192 128 "a7c080" 167 192 128;
      yellow = mkAnsi "dbbc7f" 219 188 127 "dbbc7f" 219 188 127;
      blue = mkAnsi "7fbbb3" 127 187 179 "7fbbb3" 127 187 179;
      magenta = mkAnsi "d699b6" 214 153 182 "d699b6" 214 153 182;
      cyan = mkAnsi "83c092" 131 192 146 "83c092" 131 192 146;
      white = mkAnsi "d3c6aa" 211 198 170 "d3c6aa" 211 198 170;
    };
  };

  # ── Dark Medium ───────────────────────────────────────────────────────────
  dark-medium = {
    meta = {
      name = "Everforest";
      slug = "everforest";
      variant = "dark-medium";
      dark = true;
    };
    crust = mkColor "1a2228" 26 34 40;
    mantle = mkColor "1e282e" 30 40 46;
    base = mkColor "2d353b" 45 53 59;
    surface0 = mkColor "343f44" 52 63 68;
    surface1 = mkColor "3d484d" 61 72 77;
    surface2 = mkColor "475258" 71 82 88;
    overlay0 = mkColor "4f585e" 79 88 94;
    overlay1 = mkColor "56635f" 86 99 95;
    overlay2 = mkColor "7a8478" 122 132 120;
    subtext0 = mkColor "859289" 133 146 137;
    subtext1 = mkColor "9da9a0" 157 169 160;
    text = mkColor "d3c6aa" 211 198 170;
    rosewater = mkColor "e69875" 230 152 117;
    flamingo = mkColor "e67e80" 230 126 128;
    pink = mkColor "d699b6" 214 153 182;
    mauve = mkColor "d699b6" 214 153 182;
    red = mkColor "e67e80" 230 126 128;
    maroon = mkColor "cc6a6d" 204 106 109;
    peach = mkColor "e69875" 230 152 117;
    yellow = mkColor "dbbc7f" 219 188 127;
    green = mkColor "a7c080" 167 192 128;
    teal = mkColor "83c092" 131 192 146;
    sky = mkColor "7fbbb3" 127 187 179;
    sapphire = mkColor "6fa8a0" 111 168 160;
    blue = mkColor "7fbbb3" 127 187 179;
    lavender = mkColor "b0a8c8" 176 168 200;
    ansi = {
      black = mkAnsi "3c4841" 60 72 65 "475258" 71 82 88;
      red = mkAnsi "e67e80" 230 126 128 "e67e80" 230 126 128;
      green = mkAnsi "a7c080" 167 192 128 "a7c080" 167 192 128;
      yellow = mkAnsi "dbbc7f" 219 188 127 "dbbc7f" 219 188 127;
      blue = mkAnsi "7fbbb3" 127 187 179 "7fbbb3" 127 187 179;
      magenta = mkAnsi "d699b6" 214 153 182 "d699b6" 214 153 182;
      cyan = mkAnsi "83c092" 131 192 146 "83c092" 131 192 146;
      white = mkAnsi "d3c6aa" 211 198 170 "d3c6aa" 211 198 170;
    };
  };

  # ── Dark Soft ─────────────────────────────────────────────────────────────
  dark-soft = {
    meta = {
      name = "Everforest";
      slug = "everforest";
      variant = "dark-soft";
      dark = true;
    };
    crust = mkColor "1e2a30" 30 42 48;
    mantle = mkColor "222e34" 34 46 52;
    base = mkColor "333c43" 51 60 67;
    surface0 = mkColor "3d474d" 61 71 77;
    surface1 = mkColor "454f55" 69 79 85;
    surface2 = mkColor "4e585e" 78 88 94;
    overlay0 = mkColor "56615e" 86 97 94;
    overlay1 = mkColor "5e6b67" 94 107 103;
    overlay2 = mkColor "7a8478" 122 132 120;
    subtext0 = mkColor "859289" 133 146 137;
    subtext1 = mkColor "9da9a0" 157 169 160;
    text = mkColor "d3c6aa" 211 198 170;
    rosewater = mkColor "e69875" 230 152 117;
    flamingo = mkColor "e67e80" 230 126 128;
    pink = mkColor "d699b6" 214 153 182;
    mauve = mkColor "d699b6" 214 153 182;
    red = mkColor "e67e80" 230 126 128;
    maroon = mkColor "cc6a6d" 204 106 109;
    peach = mkColor "e69875" 230 152 117;
    yellow = mkColor "dbbc7f" 219 188 127;
    green = mkColor "a7c080" 167 192 128;
    teal = mkColor "83c092" 131 192 146;
    sky = mkColor "7fbbb3" 127 187 179;
    sapphire = mkColor "6fa8a0" 111 168 160;
    blue = mkColor "7fbbb3" 127 187 179;
    lavender = mkColor "b0a8c8" 176 168 200;
    ansi = {
      black = mkAnsi "3c4841" 60 72 65 "475258" 71 82 88;
      red = mkAnsi "e67e80" 230 126 128 "e67e80" 230 126 128;
      green = mkAnsi "a7c080" 167 192 128 "a7c080" 167 192 128;
      yellow = mkAnsi "dbbc7f" 219 188 127 "dbbc7f" 219 188 127;
      blue = mkAnsi "7fbbb3" 127 187 179 "7fbbb3" 127 187 179;
      magenta = mkAnsi "d699b6" 214 153 182 "d699b6" 214 153 182;
      cyan = mkAnsi "83c092" 131 192 146 "83c092" 131 192 146;
      white = mkAnsi "d3c6aa" 211 198 170 "d3c6aa" 211 198 170;
    };
  };

  # ── Light Hard ────────────────────────────────────────────────────────────
  light-hard = {
    meta = {
      name = "Everforest";
      slug = "everforest";
      variant = "light-hard";
      dark = false;
    };
    crust = mkColor "d4cdc0" 212 205 192;
    mantle = mkColor "ddd8cb" 221 216 203;
    base = mkColor "fff9ef" 255 249 239;
    surface0 = mkColor "f0ebe1" 240 235 225;
    surface1 = mkColor "e7e2d8" 231 226 216;
    surface2 = mkColor "ddd8ce" 221 216 206;
    overlay0 = mkColor "bdc3af" 189 195 175;
    overlay1 = mkColor "a6b0a0" 166 176 160;
    overlay2 = mkColor "939f91" 147 159 145;
    subtext0 = mkColor "829181" 130 145 129;
    subtext1 = mkColor "6c7c6b" 108 124 107;
    text = mkColor "5c6a72" 92 106 114;
    rosewater = mkColor "f57d26" 245 125 38;
    flamingo = mkColor "f85552" 248 85 82;
    pink = mkColor "df69ba" 223 105 186;
    mauve = mkColor "df69ba" 223 105 186;
    red = mkColor "f85552" 248 85 82;
    maroon = mkColor "d44040" 212 64 64;
    peach = mkColor "f57d26" 245 125 38;
    yellow = mkColor "dfa000" 223 160 0;
    green = mkColor "8da101" 141 161 1;
    teal = mkColor "35a77c" 53 167 124;
    sky = mkColor "3a94c5" 58 148 197;
    sapphire = mkColor "2a84b5" 42 132 181;
    blue = mkColor "3a94c5" 58 148 197;
    lavender = mkColor "8080c0" 128 128 192;
    ansi = {
      black = mkAnsi "f0ebe1" 240 235 225 "829181" 130 145 129;
      red = mkAnsi "f85552" 248 85 82 "f85552" 248 85 82;
      green = mkAnsi "8da101" 141 161 1 "8da101" 141 161 1;
      yellow = mkAnsi "dfa000" 223 160 0 "dfa000" 223 160 0;
      blue = mkAnsi "3a94c5" 58 148 197 "3a94c5" 58 148 197;
      magenta = mkAnsi "df69ba" 223 105 186 "df69ba" 223 105 186;
      cyan = mkAnsi "35a77c" 53 167 124 "35a77c" 53 167 124;
      white = mkAnsi "5c6a72" 92 106 114 "5c6a72" 92 106 114;
    };
  };

  # ── Light Medium ──────────────────────────────────────────────────────────
  light-medium = {
    meta = {
      name = "Everforest";
      slug = "everforest";
      variant = "light-medium";
      dark = false;
    };
    crust = mkColor "d8d2c5" 216 210 197;
    mantle = mkColor "e2dbd0" 226 219 208;
    base = mkColor "fdf6e3" 253 246 227;
    surface0 = mkColor "f4f0d9" 244 240 217;
    surface1 = mkColor "efebd4" 239 235 212;
    surface2 = mkColor "e6e2cc" 230 226 204;
    overlay0 = mkColor "bdc3af" 189 195 175;
    overlay1 = mkColor "a6b0a0" 166 176 160;
    overlay2 = mkColor "939f91" 147 159 145;
    subtext0 = mkColor "829181" 130 145 129;
    subtext1 = mkColor "6c7c6b" 108 124 107;
    text = mkColor "5c6a72" 92 106 114;
    rosewater = mkColor "f57d26" 245 125 38;
    flamingo = mkColor "f85552" 248 85 82;
    pink = mkColor "df69ba" 223 105 186;
    mauve = mkColor "df69ba" 223 105 186;
    red = mkColor "f85552" 248 85 82;
    maroon = mkColor "d44040" 212 64 64;
    peach = mkColor "f57d26" 245 125 38;
    yellow = mkColor "dfa000" 223 160 0;
    green = mkColor "8da101" 141 161 1;
    teal = mkColor "35a77c" 53 167 124;
    sky = mkColor "3a94c5" 58 148 197;
    sapphire = mkColor "2a84b5" 42 132 181;
    blue = mkColor "3a94c5" 58 148 197;
    lavender = mkColor "8080c0" 128 128 192;
    ansi = {
      black = mkAnsi "efebd4" 239 235 212 "829181" 130 145 129;
      red = mkAnsi "f85552" 248 85 82 "f85552" 248 85 82;
      green = mkAnsi "8da101" 141 161 1 "8da101" 141 161 1;
      yellow = mkAnsi "dfa000" 223 160 0 "dfa000" 223 160 0;
      blue = mkAnsi "3a94c5" 58 148 197 "3a94c5" 58 148 197;
      magenta = mkAnsi "df69ba" 223 105 186 "df69ba" 223 105 186;
      cyan = mkAnsi "35a77c" 53 167 124 "35a77c" 53 167 124;
      white = mkAnsi "5c6a72" 92 106 114 "5c6a72" 92 106 114;
    };
  };

  # ── Light Soft ────────────────────────────────────────────────────────────
  light-soft = {
    meta = {
      name = "Everforest";
      slug = "everforest";
      variant = "light-soft";
      dark = false;
    };
    crust = mkColor "d5cfbb" 213 207 187;
    mantle = mkColor "ddd8c8" 221 216 200;
    base = mkColor "f2efdf" 242 239 223;
    surface0 = mkColor "eae7d6" 234 231 214;
    surface1 = mkColor "e2dfce" 226 223 206;
    surface2 = mkColor "dad7c6" 218 215 198;
    overlay0 = mkColor "bdc3af" 189 195 175;
    overlay1 = mkColor "a6b0a0" 166 176 160;
    overlay2 = mkColor "939f91" 147 159 145;
    subtext0 = mkColor "829181" 130 145 129;
    subtext1 = mkColor "6c7c6b" 108 124 107;
    text = mkColor "5c6a72" 92 106 114;
    rosewater = mkColor "f57d26" 245 125 38;
    flamingo = mkColor "f85552" 248 85 82;
    pink = mkColor "df69ba" 223 105 186;
    mauve = mkColor "df69ba" 223 105 186;
    red = mkColor "f85552" 248 85 82;
    maroon = mkColor "d44040" 212 64 64;
    peach = mkColor "f57d26" 245 125 38;
    yellow = mkColor "dfa000" 223 160 0;
    green = mkColor "8da101" 141 161 1;
    teal = mkColor "35a77c" 53 167 124;
    sky = mkColor "3a94c5" 58 148 197;
    sapphire = mkColor "2a84b5" 42 132 181;
    blue = mkColor "3a94c5" 58 148 197;
    lavender = mkColor "8080c0" 128 128 192;
    ansi = {
      black = mkAnsi "e2dfce" 226 223 206 "829181" 130 145 129;
      red = mkAnsi "f85552" 248 85 82 "f85552" 248 85 82;
      green = mkAnsi "8da101" 141 161 1 "8da101" 141 161 1;
      yellow = mkAnsi "dfa000" 223 160 0 "dfa000" 223 160 0;
      blue = mkAnsi "3a94c5" 58 148 197 "3a94c5" 58 148 197;
      magenta = mkAnsi "df69ba" 223 105 186 "df69ba" 223 105 186;
      cyan = mkAnsi "35a77c" 53 167 124 "35a77c" 53 167 124;
      white = mkAnsi "5c6a72" 92 106 114 "5c6a72" 92 106 114;
    };
  };
}
