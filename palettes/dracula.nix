{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Default (dark) ────────────────────────────────────────────────────────
  # https://draculatheme.com/contribute
  default = {
    meta = {
      name = "Dracula";
      slug = "dracula";
      variant = "default";
      dark = true;
    };
    # Backgrounds: derived by darkening the official background
    crust = mkColor "1e2029" 30 32 41;
    mantle = mkColor "21222c" 33 34 44;
    base = mkColor "282a36" 40 42 54;
    surface0 = mkColor "44475a" 68 71 90;
    surface1 = mkColor "525566" 82 85 102;
    surface2 = mkColor "606270" 96 98 112;
    overlay0 = mkColor "6272a4" 98 114 164;
    overlay1 = mkColor "7483b6" 116 131 182;
    overlay2 = mkColor "8695c7" 134 149 199;
    subtext0 = mkColor "c4c4c9" 196 196 201;
    subtext1 = mkColor "dededf" 222 222 223;
    text = mkColor "f8f8f2" 248 248 242;
    rosewater = mkColor "ffb86c" 255 184 108; # orange (warm highlight)
    flamingo = mkColor "ffb3d9" 255 179 217; # derived pink lightened
    pink = mkColor "ff79c6" 255 121 198;
    mauve = mkColor "bd93f9" 189 147 249;
    red = mkColor "ff5555" 255 85 85;
    maroon = mkColor "e04444" 224 68 68; # darkened red
    peach = mkColor "ffb86c" 255 184 108; # orange
    yellow = mkColor "f1fa8c" 241 250 140;
    green = mkColor "50fa7b" 80 250 123;
    teal = mkColor "3ff5c6" 63 245 198; # derived: mix cyan + green
    sky = mkColor "8be9fd" 139 233 253;
    sapphire = mkColor "5dd4f0" 93 212 240; # derived: darken cyan
    blue = mkColor "6272a4" 98 114 164; # comment color (closest blue)
    lavender = mkColor "9ba7c9" 155 167 201; # derived: lighten blue
    ansi = {
      black = mkAnsi "21222c" 33 34 44 "6272a4" 98 114 164;
      red = mkAnsi "ff5555" 255 85 85 "ff6e6e" 255 110 110;
      green = mkAnsi "50fa7b" 80 250 123 "69ff94" 105 255 148;
      yellow = mkAnsi "f1fa8c" 241 250 140 "ffffa5" 255 255 165;
      blue = mkAnsi "bd93f9" 189 147 249 "d6acff" 214 172 255;
      magenta = mkAnsi "ff79c6" 255 121 198 "ff92df" 255 146 223;
      cyan = mkAnsi "8be9fd" 139 233 253 "a4ffff" 164 255 255;
      white = mkAnsi "f8f8f2" 248 248 242 "ffffff" 255 255 255;
    };
  };

  # ── Alucard (light) ───────────────────────────────────────────────────────
  alucard = {
    meta = {
      name = "Dracula";
      slug = "dracula";
      variant = "alucard";
      dark = false;
    };
    crust = mkColor "e8e2d6" 232 226 214;
    mantle = mkColor "f0ecdf" 240 236 223;
    base = mkColor "fffbeb" 255 251 235;
    surface0 = mkColor "e8e4d0" 232 228 208;
    surface1 = mkColor "d8d5c0" 216 213 192;
    surface2 = mkColor "c8c5b0" 200 197 176;
    overlay0 = mkColor "9da19a" 157 161 154;
    overlay1 = mkColor "8a8e87" 138 142 135;
    overlay2 = mkColor "787c74" 120 124 116;
    subtext0 = mkColor "555952" 85 89 82;
    subtext1 = mkColor "3d403b" 61 64 59;
    text = mkColor "1f1f1f" 31 31 31;
    rosewater = mkColor "a34d14" 163 77 20; # dark orange
    flamingo = mkColor "b54060" 181 64 96; # muted pink
    pink = mkColor "a3144d" 163 20 77;
    mauve = mkColor "644ac9" 100 74 201;
    red = mkColor "cb3a2a" 203 58 42;
    maroon = mkColor "b33020" 179 48 32;
    peach = mkColor "a34d14" 163 77 20;
    yellow = mkColor "846e15" 132 110 21;
    green = mkColor "14710a" 20 113 10;
    teal = mkColor "1a6b50" 26 107 80; # derived
    sky = mkColor "036a96" 3 106 150;
    sapphire = mkColor "1a7899" 26 120 153; # derived
    blue = mkColor "1a4f8a" 26 79 138;
    lavender = mkColor "5560a8" 85 96 168;
    ansi = {
      black = mkAnsi "1f1f1f" 31 31 31 "6c664b" 108 102 75;
      red = mkAnsi "cb3a2a" 203 58 42 "a32a1a" 163 42 26;
      green = mkAnsi "14710a" 20 113 10 "14710a" 20 113 10;
      yellow = mkAnsi "846e15" 132 110 21 "846e15" 132 110 21;
      blue = mkAnsi "1a4f8a" 26 79 138 "1a4f8a" 26 79 138;
      magenta = mkAnsi "a3144d" 163 20 77 "644ac9" 100 74 201;
      cyan = mkAnsi "036a96" 3 106 150 "036a96" 3 106 150;
      white = mkAnsi "cfcfde" 207 207 222 "ffffff" 255 255 255;
    };
  };
}
