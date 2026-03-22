{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Dark Hard ─────────────────────────────────────────────────────────────
  # https://github.com/morhetz/gruvbox
  dark-hard = {
    meta = {
      name = "Gruvbox";
      slug = "gruvbox";
      variant = "dark-hard";
      dark = true;
    };
    crust = mkColor "141413" 20 20 19;
    mantle = mkColor "191817" 25 24 23;
    base = mkColor "1d2021" 29 32 33;
    surface0 = mkColor "282828" 40 40 40;
    surface1 = mkColor "3c3836" 60 56 54;
    surface2 = mkColor "504945" 80 73 69;
    overlay0 = mkColor "665c54" 102 92 84;
    overlay1 = mkColor "7c6f64" 124 111 100;
    overlay2 = mkColor "928374" 146 131 116;
    subtext0 = mkColor "a89984" 168 153 132;
    subtext1 = mkColor "bdae93" 189 174 147;
    text = mkColor "ebdbb2" 235 219 178;
    rosewater = mkColor "d65d0e" 214 93 14; # faded orange
    flamingo = mkColor "fe8019" 254 128 25; # orange
    pink = mkColor "d3869b" 211 134 155; # bright purple (pinkish)
    mauve = mkColor "b16286" 177 98 134; # purple
    red = mkColor "fb4934" 251 73 52; # bright red
    maroon = mkColor "cc241d" 204 36 29; # neutral red
    peach = mkColor "fe8019" 254 128 25; # bright orange
    yellow = mkColor "fabd2f" 250 189 47; # bright yellow
    green = mkColor "b8bb26" 184 187 38; # bright green
    teal = mkColor "8ec07c" 142 192 124; # bright aqua
    sky = mkColor "83a598" 131 165 152; # bright blue (aqua-ish)
    sapphire = mkColor "458588" 69 133 136; # neutral blue
    blue = mkColor "83a598" 131 165 152; # bright blue
    lavender = mkColor "a0a8cc" 160 168 204; # derived: cool tint
    ansi = {
      black = mkAnsi "1d2021" 29 32 33 "928374" 146 131 116;
      red = mkAnsi "cc241d" 204 36 29 "fb4934" 251 73 52;
      green = mkAnsi "98971a" 152 151 26 "b8bb26" 184 187 38;
      yellow = mkAnsi "d79921" 215 153 33 "fabd2f" 250 189 47;
      blue = mkAnsi "458588" 69 133 136 "83a598" 131 165 152;
      magenta = mkAnsi "b16286" 177 98 134 "d3869b" 211 134 155;
      cyan = mkAnsi "689d6a" 104 157 106 "8ec07c" 142 192 124;
      white = mkAnsi "a89984" 168 153 132 "ebdbb2" 235 219 178;
    };
  };

  # ── Dark Medium ───────────────────────────────────────────────────────────
  dark-medium = {
    meta = {
      name = "Gruvbox";
      slug = "gruvbox";
      variant = "dark-medium";
      dark = true;
    };
    crust = mkColor "191816" 25 24 22;
    mantle = mkColor "1e1c1a" 30 28 26;
    base = mkColor "282828" 40 40 40;
    surface0 = mkColor "3c3836" 60 56 54;
    surface1 = mkColor "504945" 80 73 69;
    surface2 = mkColor "665c54" 102 92 84;
    overlay0 = mkColor "7c6f64" 124 111 100;
    overlay1 = mkColor "878176" 135 129 118;
    overlay2 = mkColor "928374" 146 131 116;
    subtext0 = mkColor "a89984" 168 153 132;
    subtext1 = mkColor "bdae93" 189 174 147;
    text = mkColor "ebdbb2" 235 219 178;
    rosewater = mkColor "d65d0e" 214 93 14;
    flamingo = mkColor "fe8019" 254 128 25;
    pink = mkColor "d3869b" 211 134 155;
    mauve = mkColor "b16286" 177 98 134;
    red = mkColor "fb4934" 251 73 52;
    maroon = mkColor "cc241d" 204 36 29;
    peach = mkColor "fe8019" 254 128 25;
    yellow = mkColor "fabd2f" 250 189 47;
    green = mkColor "b8bb26" 184 187 38;
    teal = mkColor "8ec07c" 142 192 124;
    sky = mkColor "83a598" 131 165 152;
    sapphire = mkColor "458588" 69 133 136;
    blue = mkColor "83a598" 131 165 152;
    lavender = mkColor "a0a8cc" 160 168 204;
    ansi = {
      black = mkAnsi "282828" 40 40 40 "928374" 146 131 116;
      red = mkAnsi "cc241d" 204 36 29 "fb4934" 251 73 52;
      green = mkAnsi "98971a" 152 151 26 "b8bb26" 184 187 38;
      yellow = mkAnsi "d79921" 215 153 33 "fabd2f" 250 189 47;
      blue = mkAnsi "458588" 69 133 136 "83a598" 131 165 152;
      magenta = mkAnsi "b16286" 177 98 134 "d3869b" 211 134 155;
      cyan = mkAnsi "689d6a" 104 157 106 "8ec07c" 142 192 124;
      white = mkAnsi "a89984" 168 153 132 "ebdbb2" 235 219 178;
    };
  };

  # ── Dark Soft ─────────────────────────────────────────────────────────────
  dark-soft = {
    meta = {
      name = "Gruvbox";
      slug = "gruvbox";
      variant = "dark-soft";
      dark = true;
    };
    crust = mkColor "252220" 37 34 32;
    mantle = mkColor "2c2a27" 44 42 39;
    base = mkColor "32302f" 50 48 47;
    surface0 = mkColor "45403d" 69 64 61;
    surface1 = mkColor "504945" 80 73 69;
    surface2 = mkColor "665c54" 102 92 84;
    overlay0 = mkColor "7c6f64" 124 111 100;
    overlay1 = mkColor "878176" 135 129 118;
    overlay2 = mkColor "928374" 146 131 116;
    subtext0 = mkColor "a89984" 168 153 132;
    subtext1 = mkColor "bdae93" 189 174 147;
    text = mkColor "ebdbb2" 235 219 178;
    rosewater = mkColor "d65d0e" 214 93 14;
    flamingo = mkColor "fe8019" 254 128 25;
    pink = mkColor "d3869b" 211 134 155;
    mauve = mkColor "b16286" 177 98 134;
    red = mkColor "fb4934" 251 73 52;
    maroon = mkColor "cc241d" 204 36 29;
    peach = mkColor "fe8019" 254 128 25;
    yellow = mkColor "fabd2f" 250 189 47;
    green = mkColor "b8bb26" 184 187 38;
    teal = mkColor "8ec07c" 142 192 124;
    sky = mkColor "83a598" 131 165 152;
    sapphire = mkColor "458588" 69 133 136;
    blue = mkColor "83a598" 131 165 152;
    lavender = mkColor "a0a8cc" 160 168 204;
    ansi = {
      black = mkAnsi "32302f" 50 48 47 "928374" 146 131 116;
      red = mkAnsi "cc241d" 204 36 29 "fb4934" 251 73 52;
      green = mkAnsi "98971a" 152 151 26 "b8bb26" 184 187 38;
      yellow = mkAnsi "d79921" 215 153 33 "fabd2f" 250 189 47;
      blue = mkAnsi "458588" 69 133 136 "83a598" 131 165 152;
      magenta = mkAnsi "b16286" 177 98 134 "d3869b" 211 134 155;
      cyan = mkAnsi "689d6a" 104 157 106 "8ec07c" 142 192 124;
      white = mkAnsi "a89984" 168 153 132 "ebdbb2" 235 219 178;
    };
  };

  # ── Light Hard ────────────────────────────────────────────────────────────
  light-hard = {
    meta = {
      name = "Gruvbox";
      slug = "gruvbox";
      variant = "light-hard";
      dark = false;
    };
    crust = mkColor "dcd2b5" 220 210 181;
    mantle = mkColor "e8dec8" 232 222 200;
    base = mkColor "f9f5d7" 249 245 215;
    surface0 = mkColor "f2e5bc" 242 229 188;
    surface1 = mkColor "ebdbb2" 235 219 178;
    surface2 = mkColor "d5c4a1" 213 196 161;
    overlay0 = mkColor "bdae93" 189 174 147;
    overlay1 = mkColor "a89984" 168 153 132;
    overlay2 = mkColor "928374" 146 131 116;
    subtext0 = mkColor "7c6f64" 124 111 100;
    subtext1 = mkColor "665c54" 102 92 84;
    text = mkColor "3c3836" 60 56 54;
    rosewater = mkColor "af3a03" 175 58 3;
    flamingo = mkColor "d65d0e" 214 93 14;
    pink = mkColor "8f3f71" 143 63 113;
    mauve = mkColor "8f3f71" 143 63 113;
    red = mkColor "9d0006" 157 0 6;
    maroon = mkColor "cc241d" 204 36 29;
    peach = mkColor "af3a03" 175 58 3;
    yellow = mkColor "b57614" 181 118 20;
    green = mkColor "79740e" 121 116 14;
    teal = mkColor "427b58" 66 123 88;
    sky = mkColor "076678" 7 102 120;
    sapphire = mkColor "076678" 7 102 120;
    blue = mkColor "076678" 7 102 120;
    lavender = mkColor "4a6a96" 74 106 150;
    ansi = {
      black = mkAnsi "f9f5d7" 249 245 215 "928374" 146 131 116;
      red = mkAnsi "9d0006" 157 0 6 "cc241d" 204 36 29;
      green = mkAnsi "79740e" 121 116 14 "98971a" 152 151 26;
      yellow = mkAnsi "b57614" 181 118 20 "d79921" 215 153 33;
      blue = mkAnsi "076678" 7 102 120 "458588" 69 133 136;
      magenta = mkAnsi "8f3f71" 143 63 113 "b16286" 177 98 134;
      cyan = mkAnsi "427b58" 66 123 88 "689d6a" 104 157 106;
      white = mkAnsi "3c3836" 60 56 54 "282828" 40 40 40;
    };
  };

  # ── Light Medium ──────────────────────────────────────────────────────────
  light-medium = {
    meta = {
      name = "Gruvbox";
      slug = "gruvbox";
      variant = "light-medium";
      dark = false;
    };
    crust = mkColor "d8ccad" 216 204 173;
    mantle = mkColor "e4d8bb" 228 216 187;
    base = mkColor "fbf1c7" 251 241 199;
    surface0 = mkColor "f2e5bc" 242 229 188;
    surface1 = mkColor "ebdbb2" 235 219 178;
    surface2 = mkColor "d5c4a1" 213 196 161;
    overlay0 = mkColor "bdae93" 189 174 147;
    overlay1 = mkColor "a89984" 168 153 132;
    overlay2 = mkColor "928374" 146 131 116;
    subtext0 = mkColor "7c6f64" 124 111 100;
    subtext1 = mkColor "665c54" 102 92 84;
    text = mkColor "3c3836" 60 56 54;
    rosewater = mkColor "af3a03" 175 58 3;
    flamingo = mkColor "d65d0e" 214 93 14;
    pink = mkColor "8f3f71" 143 63 113;
    mauve = mkColor "8f3f71" 143 63 113;
    red = mkColor "9d0006" 157 0 6;
    maroon = mkColor "cc241d" 204 36 29;
    peach = mkColor "af3a03" 175 58 3;
    yellow = mkColor "b57614" 181 118 20;
    green = mkColor "79740e" 121 116 14;
    teal = mkColor "427b58" 66 123 88;
    sky = mkColor "076678" 7 102 120;
    sapphire = mkColor "076678" 7 102 120;
    blue = mkColor "076678" 7 102 120;
    lavender = mkColor "4a6a96" 74 106 150;
    ansi = {
      black = mkAnsi "fbf1c7" 251 241 199 "928374" 146 131 116;
      red = mkAnsi "9d0006" 157 0 6 "cc241d" 204 36 29;
      green = mkAnsi "79740e" 121 116 14 "98971a" 152 151 26;
      yellow = mkAnsi "b57614" 181 118 20 "d79921" 215 153 33;
      blue = mkAnsi "076678" 7 102 120 "458588" 69 133 136;
      magenta = mkAnsi "8f3f71" 143 63 113 "b16286" 177 98 134;
      cyan = mkAnsi "427b58" 66 123 88 "689d6a" 104 157 106;
      white = mkAnsi "3c3836" 60 56 54 "282828" 40 40 40;
    };
  };

  # ── Light Soft ────────────────────────────────────────────────────────────
  light-soft = {
    meta = {
      name = "Gruvbox";
      slug = "gruvbox";
      variant = "light-soft";
      dark = false;
    };
    crust = mkColor "d5c9a8" 213 201 168;
    mantle = mkColor "e0d5b8" 224 213 184;
    base = mkColor "f2e5bc" 242 229 188;
    surface0 = mkColor "eadbb3" 234 219 179;
    surface1 = mkColor "e0ceaa" 224 206 170;
    surface2 = mkColor "d5c4a1" 213 196 161;
    overlay0 = mkColor "bdae93" 189 174 147;
    overlay1 = mkColor "a89984" 168 153 132;
    overlay2 = mkColor "928374" 146 131 116;
    subtext0 = mkColor "7c6f64" 124 111 100;
    subtext1 = mkColor "665c54" 102 92 84;
    text = mkColor "3c3836" 60 56 54;
    rosewater = mkColor "af3a03" 175 58 3;
    flamingo = mkColor "d65d0e" 214 93 14;
    pink = mkColor "8f3f71" 143 63 113;
    mauve = mkColor "8f3f71" 143 63 113;
    red = mkColor "9d0006" 157 0 6;
    maroon = mkColor "cc241d" 204 36 29;
    peach = mkColor "af3a03" 175 58 3;
    yellow = mkColor "b57614" 181 118 20;
    green = mkColor "79740e" 121 116 14;
    teal = mkColor "427b58" 66 123 88;
    sky = mkColor "076678" 7 102 120;
    sapphire = mkColor "076678" 7 102 120;
    blue = mkColor "076678" 7 102 120;
    lavender = mkColor "4a6a96" 74 106 150;
    ansi = {
      black = mkAnsi "f2e5bc" 242 229 188 "928374" 146 131 116;
      red = mkAnsi "9d0006" 157 0 6 "cc241d" 204 36 29;
      green = mkAnsi "79740e" 121 116 14 "98971a" 152 151 26;
      yellow = mkAnsi "b57614" 181 118 20 "d79921" 215 153 33;
      blue = mkAnsi "076678" 7 102 120 "458588" 69 133 136;
      magenta = mkAnsi "8f3f71" 143 63 113 "b16286" 177 98 134;
      cyan = mkAnsi "427b58" 66 123 88 "689d6a" 104 157 106;
      white = mkAnsi "3c3836" 60 56 54 "282828" 40 40 40;
    };
  };
}
