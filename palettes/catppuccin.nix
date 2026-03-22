{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Latte (light) ────────────────────────────────────────────────────────
  latte = {
    meta = {
      name = "Catppuccin";
      slug = "catppuccin";
      variant = "latte";
      dark = false;
    };
    crust = mkColor "dce0e8" 220 224 232;
    mantle = mkColor "e6e9ef" 230 233 239;
    base = mkColor "eff1f5" 239 241 245;
    surface0 = mkColor "ccd0da" 204 208 218;
    surface1 = mkColor "bcc0cc" 188 192 204;
    surface2 = mkColor "acb0be" 172 176 190;
    overlay0 = mkColor "9ca0b0" 156 160 176;
    overlay1 = mkColor "8c8fa1" 140 143 161;
    overlay2 = mkColor "7c7f93" 124 127 147;
    subtext0 = mkColor "6c6f85" 108 111 133;
    subtext1 = mkColor "5c5f77" 92 95 119;
    text = mkColor "4c4f69" 76 79 105;
    rosewater = mkColor "dc8a78" 220 138 120;
    flamingo = mkColor "dd7878" 221 120 120;
    pink = mkColor "ea76cb" 234 118 203;
    mauve = mkColor "8839ef" 136 57 239;
    red = mkColor "d20f39" 210 15 57;
    maroon = mkColor "e64553" 230 69 83;
    peach = mkColor "fe640b" 254 100 11;
    yellow = mkColor "df8e1d" 223 142 29;
    green = mkColor "40a02b" 64 160 43;
    teal = mkColor "179299" 23 146 153;
    sky = mkColor "04a5e5" 4 165 229;
    sapphire = mkColor "209fb5" 32 159 181;
    blue = mkColor "1e66f5" 30 102 245;
    lavender = mkColor "7287fd" 114 135 253;
    ansi = {
      black = mkAnsi "4c4f69" 76 79 105 "5c5f77" 92 95 119;
      red = mkAnsi "d20f39" 210 15 57 "e64553" 230 69 83;
      green = mkAnsi "40a02b" 64 160 43 "40a02b" 64 160 43;
      yellow = mkAnsi "df8e1d" 223 142 29 "df8e1d" 223 142 29;
      blue = mkAnsi "1e66f5" 30 102 245 "1e66f5" 30 102 245;
      magenta = mkAnsi "ea76cb" 234 118 203 "8839ef" 136 57 239;
      cyan = mkAnsi "179299" 23 146 153 "04a5e5" 4 165 229;
      white = mkAnsi "acb0be" 172 176 190 "eff1f5" 239 241 245;
    };
  };

  # ── Frappé (medium dark) ──────────────────────────────────────────────────
  frappe = {
    meta = {
      name = "Catppuccin";
      slug = "catppuccin";
      variant = "frappe";
      dark = true;
    };
    crust = mkColor "232634" 35 38 52;
    mantle = mkColor "292c3c" 41 44 60;
    base = mkColor "303446" 48 52 70;
    surface0 = mkColor "414559" 65 69 89;
    surface1 = mkColor "51576d" 81 87 109;
    surface2 = mkColor "626880" 98 104 128;
    overlay0 = mkColor "737994" 115 121 148;
    overlay1 = mkColor "838ba7" 131 139 167;
    overlay2 = mkColor "949cbb" 148 156 187;
    subtext0 = mkColor "a5adce" 165 173 206;
    subtext1 = mkColor "b5bfe2" 181 191 226;
    text = mkColor "c6d0f5" 198 208 245;
    rosewater = mkColor "f2d5cf" 242 213 207;
    flamingo = mkColor "eebebe" 238 190 190;
    pink = mkColor "f4b8e4" 244 184 228;
    mauve = mkColor "ca9ee6" 202 158 230;
    red = mkColor "e78284" 231 130 132;
    maroon = mkColor "ea999c" 234 153 156;
    peach = mkColor "ef9f76" 239 159 118;
    yellow = mkColor "e5c890" 229 200 144;
    green = mkColor "a6d189" 166 209 137;
    teal = mkColor "81c8be" 129 200 190;
    sky = mkColor "99d1db" 153 209 219;
    sapphire = mkColor "85c1dc" 133 193 220;
    blue = mkColor "8caaee" 140 170 238;
    lavender = mkColor "babbf1" 186 187 241;
    ansi = {
      black = mkAnsi "303446" 48 52 70 "626880" 98 104 128;
      red = mkAnsi "e78284" 231 130 132 "ea999c" 234 153 156;
      green = mkAnsi "a6d189" 166 209 137 "a6d189" 166 209 137;
      yellow = mkAnsi "e5c890" 229 200 144 "e5c890" 229 200 144;
      blue = mkAnsi "8caaee" 140 170 238 "8caaee" 140 170 238;
      magenta = mkAnsi "f4b8e4" 244 184 228 "ca9ee6" 202 158 230;
      cyan = mkAnsi "81c8be" 129 200 190 "99d1db" 153 209 219;
      white = mkAnsi "b5bfe2" 181 191 226 "c6d0f5" 198 208 245;
    };
  };

  # ── Macchiato ─────────────────────────────────────────────────────────────
  macchiato = {
    meta = {
      name = "Catppuccin";
      slug = "catppuccin";
      variant = "macchiato";
      dark = true;
    };
    crust = mkColor "181926" 24 25 38;
    mantle = mkColor "1e2030" 30 32 48;
    base = mkColor "24273a" 36 39 58;
    surface0 = mkColor "363a4f" 54 58 79;
    surface1 = mkColor "494d64" 73 77 100;
    surface2 = mkColor "5b6078" 91 96 120;
    overlay0 = mkColor "6e738d" 110 115 141;
    overlay1 = mkColor "8087a2" 128 135 162;
    overlay2 = mkColor "939ab7" 147 154 183;
    subtext0 = mkColor "a5adcb" 165 173 203;
    subtext1 = mkColor "b8c0e0" 184 192 224;
    text = mkColor "cad3f5" 202 211 245;
    rosewater = mkColor "f4dbd6" 244 219 214;
    flamingo = mkColor "f0c6c6" 240 198 198;
    pink = mkColor "f5bde6" 245 189 230;
    mauve = mkColor "c6a0f6" 198 160 246;
    red = mkColor "ed8796" 237 135 150;
    maroon = mkColor "ee99a0" 238 153 160;
    peach = mkColor "f5a97f" 245 169 127;
    yellow = mkColor "eed49f" 238 212 159;
    green = mkColor "a6da95" 166 218 149;
    teal = mkColor "8bd5ca" 139 213 202;
    sky = mkColor "91d7e3" 145 215 227;
    sapphire = mkColor "7dc4e4" 125 196 228;
    blue = mkColor "8aadf4" 138 173 244;
    lavender = mkColor "b7bdf8" 183 189 248;
    ansi = {
      black = mkAnsi "24273a" 36 39 58 "5b6078" 91 96 120;
      red = mkAnsi "ed8796" 237 135 150 "ee99a0" 238 153 160;
      green = mkAnsi "a6da95" 166 218 149 "a6da95" 166 218 149;
      yellow = mkAnsi "eed49f" 238 212 159 "eed49f" 238 212 159;
      blue = mkAnsi "8aadf4" 138 173 244 "8aadf4" 138 173 244;
      magenta = mkAnsi "f5bde6" 245 189 230 "c6a0f6" 198 160 246;
      cyan = mkAnsi "8bd5ca" 139 213 202 "91d7e3" 145 215 227;
      white = mkAnsi "b8c0e0" 184 192 224 "cad3f5" 202 211 245;
    };
  };

  # ── Mocha (darkest) ───────────────────────────────────────────────────────
  mocha = {
    meta = {
      name = "Catppuccin";
      slug = "catppuccin";
      variant = "mocha";
      dark = true;
    };
    crust = mkColor "11111b" 17 17 27;
    mantle = mkColor "181825" 24 24 37;
    base = mkColor "1e1e2e" 30 30 46;
    surface0 = mkColor "313244" 49 50 68;
    surface1 = mkColor "45475a" 69 71 90;
    surface2 = mkColor "585b70" 88 91 112;
    overlay0 = mkColor "6c7086" 108 112 134;
    overlay1 = mkColor "7f849c" 127 132 156;
    overlay2 = mkColor "9399b2" 147 153 178;
    subtext0 = mkColor "a6adc8" 166 173 200;
    subtext1 = mkColor "bac2de" 186 194 222;
    text = mkColor "cdd6f4" 205 214 244;
    rosewater = mkColor "f5e0dc" 245 224 220;
    flamingo = mkColor "f2cdcd" 242 205 205;
    pink = mkColor "f5c2e7" 245 194 231;
    mauve = mkColor "cba6f7" 203 166 247;
    red = mkColor "f38ba8" 243 139 168;
    maroon = mkColor "eba0ac" 235 160 172;
    peach = mkColor "fab387" 250 179 135;
    yellow = mkColor "f9e2af" 249 226 175;
    green = mkColor "a6e3a1" 166 227 161;
    teal = mkColor "94e2d5" 148 226 213;
    sky = mkColor "89dceb" 137 220 235;
    sapphire = mkColor "74c7ec" 116 199 236;
    blue = mkColor "89b4fa" 137 180 250;
    lavender = mkColor "b4befe" 180 190 254;
    ansi = {
      black = mkAnsi "1e1e2e" 30 30 46 "45475a" 69 71 90;
      red = mkAnsi "f38ba8" 243 139 168 "eba0ac" 235 160 172;
      green = mkAnsi "a6e3a1" 166 227 161 "a6e3a1" 166 227 161;
      yellow = mkAnsi "f9e2af" 249 226 175 "f9e2af" 249 226 175;
      blue = mkAnsi "89b4fa" 137 180 250 "89b4fa" 137 180 250;
      magenta = mkAnsi "f5c2e7" 245 194 231 "cba6f7" 203 166 247;
      cyan = mkAnsi "94e2d5" 148 226 213 "89dceb" 137 220 235;
      white = mkAnsi "bac2de" 186 194 222 "cdd6f4" 205 214 244;
    };
  };
}
