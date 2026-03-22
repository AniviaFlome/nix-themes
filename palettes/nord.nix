{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Dark ──────────────────────────────────────────────────────────────────
  # https://www.nordtheme.com/docs/colors-and-palettes
  # Nord only has an official dark variant. 16 colors -> mapped to 26 slots.
  dark = {
    meta = {
      name = "Nord";
      slug = "nord";
      variant = "dark";
      dark = true;
    };
    # Polar Night (backgrounds)
    crust = mkColor "242933" 36 41 51; # derived: darker than nord0
    mantle = mkColor "292e3a" 41 46 58; # derived: between crust and base
    base = mkColor "2e3440" 46 52 64; # nord0
    surface0 = mkColor "3b4252" 59 66 82; # nord1
    surface1 = mkColor "404859" 64 72 89; # derived: between nord1 and nord2
    surface2 = mkColor "434c5e" 67 76 94; # nord2
    overlay0 = mkColor "4c566a" 76 86 106; # nord3
    overlay1 = mkColor "5e697e" 94 105 126; # derived: lighten nord3
    overlay2 = mkColor "6e7d93" 110 125 147; # derived: lighten further
    # Snow Storm (foregrounds)
    subtext0 = mkColor "c5ccda" 197 204 218; # derived: between nord4 and nord5
    subtext1 = mkColor "d0d7e4" 208 215 228; # derived: close to nord5
    text = mkColor "d8dee9" 216 222 233; # nord4
    # Frost (blues) and Aurora (accents)
    rosewater = mkColor "d8b4a0" 216 180 160; # derived: warm frost tint
    flamingo = mkColor "d0a0a0" 208 160 160; # derived: warm pinkish
    pink = mkColor "b48ead" 180 142 173; # nord15 (purple -> closest pink)
    mauve = mkColor "b48ead" 180 142 173; # nord15 purple
    red = mkColor "bf616a" 191 97 106; # nord11
    maroon = mkColor "b05060" 176 80 96; # derived: darken nord11
    peach = mkColor "d08770" 208 135 112; # nord12 orange
    yellow = mkColor "ebcb8b" 235 203 139; # nord13
    green = mkColor "a3be8c" 163 190 140; # nord14
    teal = mkColor "8fbcbb" 143 188 187; # nord7
    sky = mkColor "88c0d0" 136 192 208; # nord8
    sapphire = mkColor "81a1c1" 129 161 193; # nord9
    blue = mkColor "5e81ac" 94 129 172; # nord10
    lavender = mkColor "8fa7c9" 143 167 201; # derived: lighten nord10
    ansi = {
      black = mkAnsi "3b4252" 59 66 82 "4c566a" 76 86 106;
      red = mkAnsi "bf616a" 191 97 106 "bf616a" 191 97 106;
      green = mkAnsi "a3be8c" 163 190 140 "a3be8c" 163 190 140;
      yellow = mkAnsi "ebcb8b" 235 203 139 "ebcb8b" 235 203 139;
      blue = mkAnsi "81a1c1" 129 161 193 "81a1c1" 129 161 193;
      magenta = mkAnsi "b48ead" 180 142 173 "b48ead" 180 142 173;
      cyan = mkAnsi "88c0d0" 136 192 208 "8fbcbb" 143 188 187;
      white = mkAnsi "e5e9f0" 229 233 240 "eceff4" 236 239 244;
    };
  };
}
