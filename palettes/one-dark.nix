{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Dark ──────────────────────────────────────────────────────────────────
  # https://github.com/joshdick/onedark.vim
  dark = {
    meta = {
      name = "One Dark";
      slug = "one-dark";
      variant = "dark";
      dark = true;
    };
    crust = mkColor "21252b" 33 37 43;
    mantle = mkColor "24272d" 36 39 45;
    base = mkColor "282c34" 40 44 52;
    surface0 = mkColor "2c323c" 44 50 60;
    surface1 = mkColor "3e4452" 62 68 82;
    surface2 = mkColor "4b5263" 75 82 99;
    overlay0 = mkColor "5c6370" 92 99 112;
    overlay1 = mkColor "636979" 99 105 121;
    overlay2 = mkColor "717888" 113 120 136;
    subtext0 = mkColor "8b9098" 139 144 152;
    subtext1 = mkColor "9ba2af" 155 162 175;
    text = mkColor "abb2bf" 171 178 191;
    rosewater = mkColor "e5c07b" 229 192 123; # yellow (warm)
    flamingo = mkColor "e06c75" 224 108 117; # red (warm pink)
    pink = mkColor "c678dd" 198 120 221;
    mauve = mkColor "c678dd" 198 120 221;
    red = mkColor "e06c75" 224 108 117;
    maroon = mkColor "be5046" 190 80 70;
    peach = mkColor "d19a66" 209 154 102; # dark yellow / orange
    yellow = mkColor "e5c07b" 229 192 123;
    green = mkColor "98c379" 152 195 121;
    teal = mkColor "56b6c2" 86 182 194;
    sky = mkColor "61afef" 97 175 239;
    sapphire = mkColor "4a9fd8" 74 159 216; # derived: darken blue
    blue = mkColor "61afef" 97 175 239;
    lavender = mkColor "a0a8e8" 160 168 232; # derived: blue with purple tint
    ansi = {
      black = mkAnsi "282c34" 40 44 52 "5c6370" 92 99 112;
      red = mkAnsi "e06c75" 224 108 117 "be5046" 190 80 70;
      green = mkAnsi "98c379" 152 195 121 "98c379" 152 195 121;
      yellow = mkAnsi "e5c07b" 229 192 123 "d19a66" 209 154 102;
      blue = mkAnsi "61afef" 97 175 239 "61afef" 97 175 239;
      magenta = mkAnsi "c678dd" 198 120 221 "c678dd" 198 120 221;
      cyan = mkAnsi "56b6c2" 86 182 194 "56b6c2" 86 182 194;
      white = mkAnsi "abb2bf" 171 178 191 "ffffff" 255 255 255;
    };
  };

  # ── Light ─────────────────────────────────────────────────────────────────
  # Based on Atom's One Light syntax
  light = {
    meta = {
      name = "One Dark";
      slug = "one-dark";
      variant = "light";
      dark = false;
    };
    crust = mkColor "e4e4e4" 228 228 228;
    mantle = mkColor "eeeeee" 238 238 238;
    base = mkColor "fafafa" 250 250 250;
    surface0 = mkColor "f0f0f0" 240 240 240;
    surface1 = mkColor "e8e8e8" 232 232 232;
    surface2 = mkColor "dadada" 218 218 218;
    overlay0 = mkColor "c8c8c8" 200 200 200;
    overlay1 = mkColor "a8a8a8" 168 168 168;
    overlay2 = mkColor "a0a1a7" 160 161 167;
    subtext0 = mkColor "717174" 113 113 116;
    subtext1 = mkColor "555558" 85 85 88;
    text = mkColor "383a42" 56 58 66;
    rosewater = mkColor "c18401" 193 132 1; # orange2
    flamingo = mkColor "e45649" 228 86 73; # red
    pink = mkColor "a626a4" 166 38 164;
    mauve = mkColor "a626a4" 166 38 164;
    red = mkColor "e45649" 228 86 73;
    maroon = mkColor "c91243" 201 18 67;
    peach = mkColor "986801" 152 104 1; # orange
    yellow = mkColor "c18401" 193 132 1;
    green = mkColor "50a14f" 80 161 79;
    teal = mkColor "0184bb" 1 132 187; # cyan
    sky = mkColor "4078f2" 64 120 242; # blue as sky
    sapphire = mkColor "2060d8" 32 96 216; # derived
    blue = mkColor "4078f2" 64 120 242;
    lavender = mkColor "7060d0" 112 96 208; # derived
    ansi = {
      black = mkAnsi "fafafa" 250 250 250 "383a42" 56 58 66;
      red = mkAnsi "e45649" 228 86 73 "c91243" 201 18 67;
      green = mkAnsi "50a14f" 80 161 79 "50a14f" 80 161 79;
      yellow = mkAnsi "c18401" 193 132 1 "986801" 152 104 1;
      blue = mkAnsi "4078f2" 64 120 242 "4078f2" 64 120 242;
      magenta = mkAnsi "a626a4" 166 38 164 "a626a4" 166 38 164;
      cyan = mkAnsi "0184bb" 1 132 187 "0184bb" 1 132 187;
      white = mkAnsi "383a42" 56 58 66 "000000" 0 0 0;
    };
  };
}
