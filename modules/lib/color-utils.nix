{ lib }:

let
  /**
    Construct a color entry for a palette.

    # Example

    ```nix
    mkColor "f38ba8" 243 139 168
    => { hex = "#f38ba8"; rgb = { r = 243; g = 139; b = 168; }; }
    ```
  */
  mkColor = hex: r: g: b: {
    hex = "#${hex}";
    rgb = { inherit r g b; };
  };

  /**
    Construct an ANSI color pair (normal + bright).

    # Example

    ```nix
    mkAnsi "f38ba8" 243 139 168 "ff7777" 255 119 119
    => { normal = { hex = "#f38ba8"; rgb = ...; }; bright = { hex = "#ff7777"; rgb = ...; }; }
    ```
  */
  mkAnsi = nhex: nr: ng: nb: bhex: br: bg: bb: {
    normal = mkColor nhex nr ng nb;
    bright = mkColor bhex br bg bb;
  };
in

{
  inherit mkColor mkAnsi;
}
