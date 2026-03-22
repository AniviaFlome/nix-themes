{ lib, ... }:

{
  _class = "nixos";

  imports = [
    (lib.modules.importApply ../global.nix { themesModules = import ./all-modules.nix; })
  ];
}
