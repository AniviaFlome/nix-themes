{ themesLib }:

let
  inherit (themesLib) mkColor mkAnsi;
in

{
  # ── Wave (dark, default) ──────────────────────────────────────────────────
  # https://github.com/rebelot/kanagawa.nvim
  wave = {
    meta = {
      name = "Kanagawa";
      slug = "kanagawa";
      variant = "wave";
      dark = true;
    };
    # sumiInk backgrounds
    crust = mkColor "090618" 9 6 24;
    mantle = mkColor "16161d" 22 22 29;
    base = mkColor "1f1f28" 31 31 40;
    surface0 = mkColor "2a2a37" 42 42 55;
    surface1 = mkColor "363646" 54 54 70;
    surface2 = mkColor "54546d" 84 84 109;
    overlay0 = mkColor "727169" 114 113 105;
    overlay1 = mkColor "938aa9" 147 138 169;
    overlay2 = mkColor "9cabca" 156 171 202;
    subtext0 = mkColor "c0a36e" 192 163 110; # boatYellow (dim text)
    subtext1 = mkColor "c8c093" 200 192 147; # oldWhite
    text = mkColor "dcd7ba" 220 215 186; # fujiWhite
    # Accent colors
    rosewater = mkColor "ff9e3b" 255 158 59; # roninYellow (warm)
    flamingo = mkColor "ffa066" 255 160 102; # surimiOrange
    pink = mkColor "d27e99" 210 126 153; # sakuraPink
    mauve = mkColor "957fb8" 149 127 184; # oniViolet
    red = mkColor "e82424" 232 36 36; # samuraiRed
    maroon = mkColor "e46876" 228 104 118; # waveRed
    peach = mkColor "ffa066" 255 160 102; # surimiOrange
    yellow = mkColor "e6c384" 230 195 132; # carpYellow
    green = mkColor "98bb6c" 152 187 108; # springGreen
    teal = mkColor "7aa89f" 122 168 159; # waveAqua2
    sky = mkColor "7fb4ca" 127 180 202; # springBlue
    sapphire = mkColor "7e9cd8" 126 156 216; # crystalBlue
    blue = mkColor "7e9cd8" 126 156 216; # crystalBlue
    lavender = mkColor "9cabca" 156 171 202; # springViolet2
    ansi = {
      black = mkAnsi "090618" 9 6 24 "727169" 114 113 105;
      red = mkAnsi "c34043" 195 64 67 "e82424" 232 36 36;
      green = mkAnsi "76946a" 118 148 106 "98bb6c" 152 187 108;
      yellow = mkAnsi "c0a36e" 192 163 110 "e6c384" 230 195 132;
      blue = mkAnsi "7e9cd8" 126 156 216 "7fb4ca" 127 180 202;
      magenta = mkAnsi "957fb8" 149 127 184 "938aa9" 147 138 169;
      cyan = mkAnsi "6a9589" 106 149 137 "7aa89f" 122 168 159;
      white = mkAnsi "c8c093" 200 192 147 "dcd7ba" 220 215 186;
    };
  };

  # ── Dragon (muted dark) ───────────────────────────────────────────────────
  dragon = {
    meta = {
      name = "Kanagawa";
      slug = "kanagawa";
      variant = "dragon";
      dark = true;
    };
    crust = mkColor "0d0c0c" 13 12 12;
    mantle = mkColor "12120f" 18 18 15;
    base = mkColor "181616" 24 22 22;
    surface0 = mkColor "1d1c19" 29 28 25;
    surface1 = mkColor "282727" 40 39 39;
    surface2 = mkColor "393836" 57 56 54;
    overlay0 = mkColor "625e5a" 98 94 90;
    overlay1 = mkColor "7a8382" 122 131 130;
    overlay2 = mkColor "8a9a9a" 138 154 154;
    subtext0 = mkColor "a09f90" 160 159 144;
    subtext1 = mkColor "b4a98e" 180 169 142;
    text = mkColor "c5c9c5" 197 201 197;
    rosewater = mkColor "b35b46" 179 91 70;
    flamingo = mkColor "b6804d" 182 128 77;
    pink = mkColor "a292a3" 162 146 163;
    mauve = mkColor "8992a7" 137 146 167;
    red = mkColor "c4746e" 196 116 110;
    maroon = mkColor "b56060" 181 96 96;
    peach = mkColor "b6804d" 182 128 77;
    yellow = mkColor "c4b28a" 196 178 138;
    green = mkColor "8a9a7b" 138 154 123;
    teal = mkColor "8ea4a2" 142 164 162;
    sky = mkColor "8ba4b0" 139 164 176;
    sapphire = mkColor "7e9cd8" 126 156 216; # same as wave (no dragon equivalent)
    blue = mkColor "8ba4b0" 139 164 176;
    lavender = mkColor "9cabca" 156 171 202;
    ansi = {
      black = mkAnsi "0d0c0c" 13 12 12 "625e5a" 98 94 90;
      red = mkAnsi "c4746e" 196 116 110 "c4746e" 196 116 110;
      green = mkAnsi "8a9a7b" 138 154 123 "8a9a7b" 138 154 123;
      yellow = mkAnsi "c4b28a" 196 178 138 "c4b28a" 196 178 138;
      blue = mkAnsi "8ba4b0" 139 164 176 "8ba4b0" 139 164 176;
      magenta = mkAnsi "8992a7" 137 146 167 "a292a3" 162 146 163;
      cyan = mkAnsi "8ea4a2" 142 164 162 "8ea4a2" 142 164 162;
      white = mkAnsi "c5c9c5" 197 201 197 "c5c9c5" 197 201 197;
    };
  };

  # ── Lotus (light) ─────────────────────────────────────────────────────────
  lotus = {
    meta = {
      name = "Kanagawa";
      slug = "kanagawa";
      variant = "lotus";
      dark = false;
    };
    crust = mkColor "d5cea3" 213 206 163;
    mantle = mkColor "dcd5a8" 220 213 168;
    base = mkColor "f2ecbc" 242 236 188;
    surface0 = mkColor "e7ddb6" 231 221 182;
    surface1 = mkColor "ddd5af" 221 213 175;
    surface2 = mkColor "d4cba5" 212 203 165;
    overlay0 = mkColor "c3b99a" 195 185 154;
    overlay1 = mkColor "9e9b93" 158 155 147;
    overlay2 = mkColor "8e8d87" 142 141 135;
    subtext0 = mkColor "7e7b73" 126 123 115;
    subtext1 = mkColor "6e6a60" 110 106 96;
    text = mkColor "545464" 84 84 100;
    rosewater = mkColor "e98a00" 233 138 0;
    flamingo = mkColor "cc6d00" 204 109 0;
    pink = mkColor "b35b8f" 179 91 143;
    mauve = mkColor "8f5fb8" 143 95 184;
    red = mkColor "c84053" 200 64 83;
    maroon = mkColor "b33040" 179 48 64;
    peach = mkColor "cc6d00" 204 109 0;
    yellow = mkColor "77713f" 119 113 63;
    green = mkColor "6f894e" 111 137 78;
    teal = mkColor "4e8b6f" 78 139 111;
    sky = mkColor "6693bf" 102 147 191;
    sapphire = mkColor "4d699b" 77 105 155;
    blue = mkColor "4d699b" 77 105 155;
    lavender = mkColor "7979b8" 121 121 184;
    ansi = {
      black = mkAnsi "1f1f28" 31 31 40 "9e9b93" 158 155 147;
      red = mkAnsi "c84053" 200 64 83 "c84053" 200 64 83;
      green = mkAnsi "6f894e" 111 137 78 "6f894e" 111 137 78;
      yellow = mkAnsi "77713f" 119 113 63 "77713f" 119 113 63;
      blue = mkAnsi "4d699b" 77 105 155 "4d699b" 77 105 155;
      magenta = mkAnsi "8f5fb8" 143 95 184 "b35b8f" 179 91 143;
      cyan = mkAnsi "4e8b6f" 78 139 111 "6693bf" 102 147 191;
      white = mkAnsi "545464" 84 84 100 "545464" 84 84 100;
    };
  };
}
