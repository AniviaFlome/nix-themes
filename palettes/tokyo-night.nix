{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Storm ─────────────────────────────────────────────────────────────────
  # https://github.com/folke/tokyonight.nvim
  storm = {
    meta = {
      name = "Tokyo Night";
      slug = "tokyo-night";
      variant = "storm";
      dark = true;
    };
    crust = mkColor "191c27" 25 28 39;
    mantle = mkColor "1c1f2d" 28 31 45;
    base = mkColor "24283b" 36 40 59;
    surface0 = mkColor "292e42" 41 46 66;
    surface1 = mkColor "343850" 52 56 80;
    surface2 = mkColor "414868" 65 72 104;
    overlay0 = mkColor "565f89" 86 95 137;
    overlay1 = mkColor "636d94" 99 109 148;
    overlay2 = mkColor "737b9e" 115 123 158;
    subtext0 = mkColor "8894c1" 136 148 193;
    subtext1 = mkColor "9aa5ce" 154 165 206;
    text = mkColor "c0caf5" 192 202 245;
    rosewater = mkColor "ff9e64" 255 158 100; # orange (warm)
    flamingo = mkColor "ff757f" 255 117 127; # red (warm pink)
    pink = mkColor "bb9af7" 187 154 247; # mauve-ish
    mauve = mkColor "bb9af7" 187 154 247;
    red = mkColor "f7768e" 247 118 142;
    maroon = mkColor "db6070" 219 96 112; # derived: darken red
    peach = mkColor "ff9e64" 255 158 100;
    yellow = mkColor "e0af68" 224 175 104;
    green = mkColor "9ece6a" 158 206 106;
    teal = mkColor "1abc9c" 26 188 156;
    sky = mkColor "7dcfff" 125 207 255;
    sapphire = mkColor "2ac3de" 42 195 222;
    blue = mkColor "7aa2f7" 122 162 247;
    lavender = mkColor "a9b1f5" 169 177 245; # derived: lighter blue
    ansi = {
      black = mkAnsi "1d202f" 29 32 47 "414868" 65 72 104;
      red = mkAnsi "f7768e" 247 118 142 "f7768e" 247 118 142;
      green = mkAnsi "9ece6a" 158 206 106 "9ece6a" 158 206 106;
      yellow = mkAnsi "e0af68" 224 175 104 "e0af68" 224 175 104;
      blue = mkAnsi "7aa2f7" 122 162 247 "7aa2f7" 122 162 247;
      magenta = mkAnsi "bb9af7" 187 154 247 "bb9af7" 187 154 247;
      cyan = mkAnsi "7dcfff" 125 207 255 "7dcfff" 125 207 255;
      white = mkAnsi "a9b1d6" 169 177 214 "c0caf5" 192 202 245;
    };
  };

  # ── Night ─────────────────────────────────────────────────────────────────
  night = {
    meta = {
      name = "Tokyo Night";
      slug = "tokyo-night";
      variant = "night";
      dark = true;
    };
    crust = mkColor "11121a" 17 18 26;
    mantle = mkColor "14151f" 20 21 31;
    base = mkColor "1a1b26" 26 27 38;
    surface0 = mkColor "1e2030" 30 32 48;
    surface1 = mkColor "24283b" 36 40 59;
    surface2 = mkColor "414868" 65 72 104;
    overlay0 = mkColor "565f89" 86 95 137;
    overlay1 = mkColor "636d94" 99 109 148;
    overlay2 = mkColor "737b9e" 115 123 158;
    subtext0 = mkColor "8894c1" 136 148 193;
    subtext1 = mkColor "9aa5ce" 154 165 206;
    text = mkColor "c0caf5" 192 202 245;
    rosewater = mkColor "ff9e64" 255 158 100;
    flamingo = mkColor "ff757f" 255 117 127;
    pink = mkColor "bb9af7" 187 154 247;
    mauve = mkColor "bb9af7" 187 154 247;
    red = mkColor "f7768e" 247 118 142;
    maroon = mkColor "db6070" 219 96 112;
    peach = mkColor "ff9e64" 255 158 100;
    yellow = mkColor "e0af68" 224 175 104;
    green = mkColor "9ece6a" 158 206 106;
    teal = mkColor "1abc9c" 26 188 156;
    sky = mkColor "7dcfff" 125 207 255;
    sapphire = mkColor "2ac3de" 42 195 222;
    blue = mkColor "7aa2f7" 122 162 247;
    lavender = mkColor "a9b1f5" 169 177 245;
    ansi = {
      black = mkAnsi "15161e" 21 22 30 "414868" 65 72 104;
      red = mkAnsi "f7768e" 247 118 142 "f7768e" 247 118 142;
      green = mkAnsi "9ece6a" 158 206 106 "9ece6a" 158 206 106;
      yellow = mkAnsi "e0af68" 224 175 104 "e0af68" 224 175 104;
      blue = mkAnsi "7aa2f7" 122 162 247 "7aa2f7" 122 162 247;
      magenta = mkAnsi "bb9af7" 187 154 247 "bb9af7" 187 154 247;
      cyan = mkAnsi "7dcfff" 125 207 255 "7dcfff" 125 207 255;
      white = mkAnsi "a9b1d6" 169 177 214 "c0caf5" 192 202 245;
    };
  };

  # ── Moon ──────────────────────────────────────────────────────────────────
  moon = {
    meta = {
      name = "Tokyo Night";
      slug = "tokyo-night";
      variant = "moon";
      dark = true;
    };
    crust = mkColor "181825" 24 24 37;
    mantle = mkColor "1e1f2d" 30 31 45;
    base = mkColor "222436" 34 36 54;
    surface0 = mkColor "2a2b3d" 42 43 61;
    surface1 = mkColor "323449" 50 52 73;
    surface2 = mkColor "444a73" 68 74 115;
    overlay0 = mkColor "636da6" 99 109 166;
    overlay1 = mkColor "737aaf" 115 122 175;
    overlay2 = mkColor "8087b8" 128 135 184;
    subtext0 = mkColor "9599c3" 149 153 195;
    subtext1 = mkColor "a8aecb" 168 174 203;
    text = mkColor "c8d3f5" 200 211 245;
    rosewater = mkColor "ff966c" 255 150 108;
    flamingo = mkColor "ff757f" 255 117 127;
    pink = mkColor "fca7ea" 252 167 234;
    mauve = mkColor "c099ff" 192 153 255;
    red = mkColor "ff757f" 255 117 127;
    maroon = mkColor "e06070" 224 96 112;
    peach = mkColor "ff966c" 255 150 108;
    yellow = mkColor "ffc777" 255 199 119;
    green = mkColor "c3e88d" 195 232 141;
    teal = mkColor "4fd6be" 79 214 190;
    sky = mkColor "86e1fc" 134 225 252;
    sapphire = mkColor "4fd6be" 79 214 190;
    blue = mkColor "82aaff" 130 170 255;
    lavender = mkColor "a9b8f5" 169 184 245;
    ansi = {
      black = mkAnsi "1b1d2b" 27 29 43 "444a73" 68 74 115;
      red = mkAnsi "ff757f" 255 117 127 "ff757f" 255 117 127;
      green = mkAnsi "c3e88d" 195 232 141 "c3e88d" 195 232 141;
      yellow = mkAnsi "ffc777" 255 199 119 "ffc777" 255 199 119;
      blue = mkAnsi "82aaff" 130 170 255 "82aaff" 130 170 255;
      magenta = mkAnsi "c099ff" 192 153 255 "c099ff" 192 153 255;
      cyan = mkAnsi "86e1fc" 134 225 252 "86e1fc" 134 225 252;
      white = mkAnsi "828bb8" 130 139 184 "c8d3f5" 200 211 245;
    };
  };

  # ── Day ───────────────────────────────────────────────────────────────────
  day = {
    meta = {
      name = "Tokyo Night";
      slug = "tokyo-night";
      variant = "day";
      dark = false;
    };
    crust = mkColor "cdd0d9" 205 208 217;
    mantle = mkColor "d2d5de" 210 213 222;
    base = mkColor "e1e2e7" 225 226 231;
    surface0 = mkColor "d5d6db" 213 214 219;
    surface1 = mkColor "cacbd0" 202 203 208;
    surface2 = mkColor "bfc0c5" 191 192 197;
    overlay0 = mkColor "9699a3" 150 153 163;
    overlay1 = mkColor "8c8fa0" 140 143 160;
    overlay2 = mkColor "8284a0" 130 132 160;
    subtext0 = mkColor "6f7490" 111 116 144;
    subtext1 = mkColor "565a6e" 86 90 110;
    text = mkColor "3760bf" 55 96 191;
    rosewater = mkColor "b15c00" 177 92 0;
    flamingo = mkColor "b55a65" 181 90 101;
    pink = mkColor "9854f1" 152 84 241;
    mauve = mkColor "7847bd" 120 71 189;
    red = mkColor "f52a65" 245 42 101;
    maroon = mkColor "c9243f" 201 36 63;
    peach = mkColor "b15c00" 177 92 0;
    yellow = mkColor "8c6c3e" 140 108 62;
    green = mkColor "587539" 88 117 57;
    teal = mkColor "007197" 0 113 151;
    sky = mkColor "007197" 0 113 151;
    sapphire = mkColor "006a90" 0 106 144;
    blue = mkColor "2e7de9" 46 125 233;
    lavender = mkColor "4457ca" 68 87 202;
    ansi = {
      black = mkAnsi "e9e9ed" 233 233 237 "7f85a2" 127 133 162;
      red = mkAnsi "8c4351" 140 67 81 "f52a65" 245 42 101;
      green = mkAnsi "485e30" 72 94 48 "587539" 88 117 57;
      yellow = mkAnsi "8f5e15" 143 94 21 "8c6c3e" 140 108 62;
      blue = mkAnsi "2e7de9" 46 125 233 "2e7de9" 46 125 233;
      magenta = mkAnsi "7847bd" 120 71 189 "9854f1" 152 84 241;
      cyan = mkAnsi "007197" 0 113 151 "007197" 0 113 151;
      white = mkAnsi "6172b0" 97 114 176 "3760bf" 55 96 191;
    };
  };
}
